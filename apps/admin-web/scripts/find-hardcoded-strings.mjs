import fs from "node:fs";
import path from "node:path";
import ts from "typescript";

const ROOT = process.cwd();
const TARGETS = ["app", "components"].map((segment) => path.join(ROOT, segment));
const EXCLUDED = [".next", "node_modules", "tests"];
const TEXT_REGEX = /[\p{L}]/u;
const IGNORE_TEXT = new Set(["->", "—"]);
const PROP_NAMES = new Set([
  "title",
  "description",
  "label",
  "placeholder",
  "aria-label",
  "confirmLabel",
  "body",
  "eyebrow",
  "legend",
  "helperText",
]);

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
    } else if (/\.(tsx|ts)$/.test(entry.name) && !/\.(test|spec)\.(tsx|ts)$/.test(entry.name)) {
      files.push(fullPath);
    }
  }
  return files;
}

function report(file, node, text, findings) {
  const trimmed = text.trim();
  if (!trimmed || IGNORE_TEXT.has(trimmed) || !TEXT_REGEX.test(trimmed)) {
    return;
  }
  if (/^[a-z0-9_:[\]\-./()%#\s]+$/i.test(trimmed) && !/\s[a-z]/i.test(trimmed)) {
    return;
  }
  const { line } = ts.getLineAndCharacterOfPosition(node.getSourceFile(), node.getStart());
  findings.push(`${path.relative(ROOT, file)}:${line + 1}: ${trimmed}`);
}

function shouldCheckLiteral(node) {
  if (ts.isImportDeclaration(node.parent) || ts.isExportDeclaration(node.parent)) {
    return false;
  }
  if (ts.isPropertyAssignment(node.parent)) {
    if (ts.isIdentifier(node.parent.name)) {
      return PROP_NAMES.has(node.parent.name.text);
    }
    if (ts.isStringLiteral(node.parent.name)) {
      return PROP_NAMES.has(node.parent.name.text);
    }
  }
  if (ts.isJsxAttribute(node.parent)) {
    return PROP_NAMES.has(node.parent.name.text);
  }
  return false;
}

const findings = [];

for (const target of TARGETS) {
  for (const file of walk(target)) {
    const source = fs.readFileSync(file, "utf8");
    const sourceFile = ts.createSourceFile(file, source, ts.ScriptTarget.Latest, true, file.endsWith(".tsx") ? ts.ScriptKind.TSX : ts.ScriptKind.TS);

    function visit(node) {
      if (ts.isJsxText(node)) {
        report(file, node, node.getText(sourceFile), findings);
      } else if ((ts.isStringLiteral(node) || ts.isNoSubstitutionTemplateLiteral(node)) && shouldCheckLiteral(node)) {
        report(file, node, node.text, findings);
      }
      ts.forEachChild(node, visit);
    }

    visit(sourceFile);
  }
}

if (findings.length === 0) {
  console.log("No hardcoded user-facing strings found.");
  process.exit(0);
}

console.log(findings.join("\n"));
process.exit(1);
