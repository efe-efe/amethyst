const testFolder = "./content/panorama/images/custom_game";
const fs = require("fs");

fs.readdir(testFolder, (err, files) => {
    if (err) throw err;
    console.log("File is created successfully.");
    files.forEach((file) => {
        const text = `<Image src="file://{images}/custom_game/${file}" />\n`;
        fs.appendFile("image_names.txt", text, function (err) {
            if (err) throw err;
            console.log("File is created successfully.");
        });
    });
});
