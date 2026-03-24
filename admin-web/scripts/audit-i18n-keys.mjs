import fs from "node:fs";
import path from "node:path";
import ts from "typescript";

const ROOT = process.cwd();
const EXCLUDED = [".next", "node_modules", "tests"];
const METHOD_NAMES = new Set(["slice", "toUpperCase", "toLowerCase", "trim", "map", "join", "replace"]);
const SOURCE_DIRS = ["app", "components", "lib"].map((segment) => path.join(ROOT, segment));
const DICTIONARY_FILE = path.join(ROOT, "lib", "i18n", "dictionaries.ts");
const ADMIN_UI_FILE = path.join(ROOT, "lib", "i18n", "admin-ui.ts");

function walk(dir) {
  const entries = fs.readdirSync(dir, { withFileTypes: true });
  const files = [];
  for (const entry of entries) {
    if (EXCLUDED.includes(entry.name)) {
      continue;
    }
    const fullPath = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      files.push(...walk(fullPath));
    } else if (/\.(tsx|ts)$/.test(entry.name)) {
      files.push(fullPath);
    }
  }
  return files;
}

function createSource(file) {
  const source = fs.readFileSync(file, "utf8");
  return ts.createSourceFile(file, source, ts.ScriptTarget.Latest, true, file.endsWith(".tsx") ? ts.ScriptKind.TSX : ts.ScriptKind.TS);
}

function collectObjectPaths(expression, prefix = []) {
  const results = new Set();
  const currentExpression = ts.isAsExpression(expression) ? expression.expression : expression;
  if (!ts.isObjectLiteralExpression(currentExpression)) {
    return results;
  }
  for (const property of currentExpression.properties) {
    if (!ts.isPropertyAssignment(property)) {
      continue;
    }
    const name = ts.isIdentifier(property.name)
      ? property.name.text
      : ts.isStringLiteral(property.name)
        ? property.name.text
        : null;
    if (!name) {
      continue;
    }
    const nextPrefix = [...prefix, name];
    results.add(nextPrefix.join("."));
    if (ts.isObjectLiteralExpression(property.initializer)) {
      for (const child of collectObjectPaths(property.initializer, nextPrefix)) {
        results.add(child);
      }
    }
  }
  return results;
}

function extractDeclaredPaths(file, variableName) {
  const sourceFile = createSource(file);
  let paths = new Set();

  function visit(node) {
    if (
      ts.isVariableDeclaration(node) &&
      ts.isIdentifier(node.name) &&
      node.name.text === variableName &&
      node.initializer &&
      (ts.isObjectLiteralExpression(node.initializer) || ts.isAsExpression(node.initializer))
    ) {
      paths = collectObjectPaths(node.initializer);
    }
    ts.forEachChild(node, visit);
  }

  visit(sourceFile);
  return paths;
}

function getPropertyChain(node) {
  const parts = [];
  let current = node;
  while (ts.isPropertyAccessExpression(current)) {
    parts.unshift(current.name.text);
    current = current.expression;
  }
  if (ts.isIdentifier(current)) {
    parts.unshift(current.text);
    return parts;
  }
  return null;
}

function collectUsedPaths() {
  const used = {
    dictionary: new Set(),
    ui: new Set(),
  };

  for (const dir of SOURCE_DIRS) {
    for (const file of walk(dir)) {
      const sourceFile = createSource(file);
      function visit(node) {
        if (ts.isPropertyAccessExpression(node)) {
          const chain = getPropertyChain(node);
          if (chain?.[0] === "dictionary" && chain.length > 1 && !METHOD_NAMES.has(chain.at(-1))) {
            used.dictionary.add(chain.slice(1).join("."));
          }
          if (chain?.[0] === "ui" && chain.length > 1 && !METHOD_NAMES.has(chain.at(-1))) {
            used.ui.add(chain.slice(1).join("."));
          }
        }
        ts.forEachChild(node, visit);
      }
      visit(sourceFile);
    }
  }

  return used;
}

const dictionaryPaths = extractDeclaredPaths(DICTIONARY_FILE, "dictionaries");
const adminUiPaths = extractDeclaredPaths(ADMIN_UI_FILE, "ui");
const used = collectUsedPaths();

const missing = [];

for (const key of used.dictionary) {
  if (!dictionaryPaths.has(`ar.${key}`)) {
    missing.push(`dictionary.${key}`);
  }
}

for (const key of used.ui) {
  if (!adminUiPaths.has(`ar.${key}`)) {
    missing.push(`ui.${key}`);
  }
}

if (missing.length === 0) {
  console.log("No missing translation keys detected.");
  process.exit(0);
}

console.log(missing.sort().join("\n"));
process.exit(1);
