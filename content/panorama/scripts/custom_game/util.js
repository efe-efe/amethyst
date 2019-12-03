var COLORS_RGB = {}
COLORS_RGB["LOCAL"] = {
    light: "rgba(162, 249, 154, 1.0)",
    dark: "rgba(51, 162, 40, 1.0)",
}
COLORS_RGB["YELLOW"] = {
    light: "rgba(249, 246, 154, 1.0)",
    dark: "rgba(196, 192, 45, 1.0)",
}
COLORS_RGB["LIGHTGREEN"] = {
    light: "rgba(154, 249, 224, 1.0)",
    dark: "rgba(78, 128, 114, 1.0)",
}
COLORS_RGB["PINK"] = {
    light: "rgba(197, 77, 168 ,1.0)",
    dark: "rgba(92, 15, 73, 1.0)",
}
COLORS_RGB["ORANGE"] = {
    light: "rgba(255, 108, 0, 1.0)",
    dark: "rgba(219, 99, 11, 1.0)",
}

var Colors = {
    Gradient: function(color){
        var color_a = COLORS_RGB[color].light;
        var color_b = COLORS_RGB[color].dark;
        return "gradient( linear, 0% 0%, 100% 0%, from( " + color_a + "), to( " + color_b + "));";
    }
}