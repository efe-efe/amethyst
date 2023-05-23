const path = require("path");

module.exports = {
    mode: "development",
    entry: "../../content/panorama/scripts/custom_game/index.js",
    output: {
        path: path.resolve(__dirname, "../../content/panorama/scripts/custom_game"),
        filename: "bundle.js",
    },
    devtool: "source-map",
};
