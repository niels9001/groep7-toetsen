const fs = require('node:fs');
const path = require('node:path');

const root = path.resolve(__dirname, '..');
const output = path.join(root, 'public');
const mediaExtension = /\.(png|jpg|jpeg|webp|gif|svg|ico|woff2|mp3|mp4)$/i;

fs.rmSync(output, { recursive: true, force: true });
fs.mkdirSync(output);

for (const entry of fs.readdirSync(root, { withFileTypes: true })) {
  if (entry.isFile() && !entry.name.startsWith('.') && /\.(html|js|css)$/.test(entry.name)) {
    fs.copyFileSync(path.join(root, entry.name), path.join(output, entry.name));
  }
}

function copyAssets(directory, destination) {
  for (const entry of fs.readdirSync(directory, { withFileTypes: true })) {
    if (entry.name.startsWith('.')) continue;
    const source = path.join(directory, entry.name);
    const target = path.join(destination, entry.name);
    if (entry.isDirectory()) {
      copyAssets(source, target);
    } else if (entry.isFile() && mediaExtension.test(entry.name)) {
      fs.mkdirSync(destination, { recursive: true });
      fs.copyFileSync(source, target);
    }
  }
}

const assets = path.join(root, 'assets');
if (fs.existsSync(assets)) copyAssets(assets, path.join(output, 'assets'));
if (!fs.existsSync(path.join(output, 'index.html'))) {
  throw new Error('index.html ontbreekt; publicatie afgebroken.');
}
console.log(`Publieke webbestanden verzameld in ${output}`);
