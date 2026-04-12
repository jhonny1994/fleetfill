import { copyFile, mkdir, stat, writeFile } from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";

const scriptDir = path.dirname(fileURLToPath(import.meta.url));
const projectRoot = path.resolve(scriptDir, "..");
const sourcePath = path.join(projectRoot, ".next", "dev", "types", "cache-life.d.ts");
const targetPath = path.join(projectRoot, ".next", "types", "cache-life.d.ts");

async function fileExists(filePath) {
  try {
    await stat(filePath);
    return true;
  } catch {
    return false;
  }
}

if (await fileExists(sourcePath)) {
  await mkdir(path.dirname(targetPath), { recursive: true });
  await copyFile(sourcePath, targetPath);
} else if (!(await fileExists(targetPath))) {
  await mkdir(path.dirname(targetPath), { recursive: true });
  await writeFile(
    targetPath,
    "// Placeholder cache-life declarations for standalone typecheck runs.\n",
    "utf8",
  );
}
