import fs from "node:fs";
import path from "node:path";
import ts from "typescript";

const ROOT = process.cwd();
const EXCLUDED = [".next", "node_modules", "tests"];
const METHOD_NAMES = new Set(["slice", "toUpperCase", "toLowerCase", "trim", "map", "join", "replace"]);
const SOURCE_DIRS = ["app", "components", "lib"].map((segment) => path.join(ROOT, segment));
const CONFIG_FILE = path.join(ROOT, "lib", "i18n", "config.ts");
const MESSAGE_LOADERS_FILE = path.join(ROOT, "lib", "i18n", "messages.ts");
const MESSAGES_DIR = path.join(ROOT, "messages");

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

    if (ts.isObjectLiteralExpression(property.initializer) || ts.isAsExpression(property.initializer)) {
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

function extractTopLevelKeys(file, variableName) {
  const sourceFile = createSource(file);
  const keys = new Set();

  function visit(node) {
    if (
      ts.isVariableDeclaration(node) &&
      ts.isIdentifier(node.name) &&
      node.name.text === variableName &&
      node.initializer &&
      (ts.isObjectLiteralExpression(node.initializer) || ts.isAsExpression(node.initializer))
    ) {
      const expression = ts.isAsExpression(node.initializer) ? node.initializer.expression : node.initializer;
      if (!ts.isObjectLiteralExpression(expression)) {
        return;
      }

      for (const property of expression.properties) {
        if (!ts.isPropertyAssignment(property)) {
          continue;
        }

        const name = ts.isIdentifier(property.name)
          ? property.name.text
          : ts.isStringLiteral(property.name)
            ? property.name.text
            : null;

        if (name) {
          keys.add(name);
        }
      }
    }

    ts.forEachChild(node, visit);
  }

  visit(sourceFile);
  return keys;
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

const configuredLocales = extractTopLevelKeys(CONFIG_FILE, "localeRegistry");
const loaderLocales = extractTopLevelKeys(MESSAGE_LOADERS_FILE, "localeMessageLoaders");
const missing = [];

for (const locale of configuredLocales) {
  const messageFile = path.join(MESSAGES_DIR, `${locale}.ts`);
  if (!fs.existsSync(messageFile)) {
    missing.push(`missing message file for locale "${locale}"`);
  }
  if (!loaderLocales.has(locale)) {
    missing.push(`missing message loader for locale "${locale}"`);
  }
}

for (const locale of loaderLocales) {
  if (!configuredLocales.has(locale)) {
    missing.push(`message loader "${locale}" is not registered in localeRegistry`);
  }
}

const localePaths = new Map();
for (const locale of configuredLocales) {
  const messageFile = path.join(MESSAGES_DIR, `${locale}.ts`);
  if (!fs.existsSync(messageFile)) {
    continue;
  }
  localePaths.set(locale, extractDeclaredPaths(messageFile, "messages"));
}

const used = collectUsedPaths();

for (const [locale, paths] of localePaths) {
  for (const key of used.dictionary) {
    if (!paths.has(`dictionary.${key}`)) {
      missing.push(`${locale}: dictionary.${key}`);
    }
  }

  for (const key of used.ui) {
    if (!paths.has(`ui.${key}`)) {
      missing.push(`${locale}: ui.${key}`);
    }
  }
}

if (missing.length === 0) {
  console.log("No missing translation keys or locale registration issues detected.");
  process.exit(0);
}

console.log(missing.sort().join("\n"));
process.exit(1);
