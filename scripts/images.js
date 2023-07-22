const watch = require("node-watch");
const glob = require("glob");
const fs = require("fs");

const args = process.argv.slice(2);

const precacheDirPath = "./content/panorama/styles/custom_game";
const precacheFilePath = `${precacheDirPath}/precache.css`;
const imagePath = "content/panorama/images";
const imageSet = new Set();

const fileRegex = new RegExp(`${imagePath}\/(.*)\.png`);

let debounce = undefined;

function updatePrecacheFile() {
    const images = [...imageSet].sort().map(image => `    background-image: url("file://{images}/${image}.png");`);
    const content = `.precache {\n` + images.join("\n") + "\n}";

    if (debounce) {
        clearTimeout(debounce);
    }

    debounce = setTimeout(() => tryWritingPrecache(content), 100);
}

function tryWritingPrecache(content) {
    if (!fs.existsSync(precacheDirPath)) {
        fs.mkdirSync(precacheDirPath, { recursive: true });
    }

    fs.writeFileSync(precacheFilePath, content, "utf-8");
    console.log("\x1b[32m%s\x1b[0m", `Generated precache image list: Total of ${imageSet.size} images listed.`);
}

function cleanFileName(originalName) {
    const name = originalName.replace(/\\/g, "/");
    const match = name.match(fileRegex);
    return match?.[1] ?? name;
}

function addAllImages() {
    glob(`./${imagePath}/**/*.png`, {}, (err, files) => {
        for (const filePath of files) {
            imageSet.add(cleanFileName(filePath));
        }

        updatePrecacheFile();
    });
}

addAllImages();

if (args.includes("--watch")) {
    const watcher = watch([imagePath], { recursive: true });

    watcher.on("change", (eventType, filePath) => {
        if (!filePath) return;
        if (!filePath.includes(".png")) return;

        const cleanedName = cleanFileName(filePath);

        if (eventType == "remove") {
            imageSet.delete(cleanedName);
        } else {
            imageSet.add(cleanedName);
        }

        updatePrecacheFile();
    });
}
