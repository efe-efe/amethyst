var COLORS_RGB = {}
COLORS_RGB["LOCAL"] = {
    light: [162, 249, 154],
    dark: [51, 162, 40]
}
COLORS_RGB["YELLOW"] = {
    light: [249, 246, 154],
    dark: [196, 192, 42]
}
COLORS_RGB["LIGHTGREEN"] = {
    light: [154, 249, 224],
    dark: [78, 128, 114]
}
COLORS_RGB["PINK"] = {
    light: [197, 77, 168],
    dark: [92, 15, 73]
}
COLORS_RGB["ORANGE"] = {
    light: [255, 108, 0],
    dark: [219, 99, 11]
}
COLORS_RGB["BLUE"] = {
    light: [27, 113, 230],
    dark: [120, 156, 210]
}
COLORS_RGB["GRAY"] = {
    light: [240, 240, 240],
    dark: [120, 120, 120]
}

var Colors = {
    Gradient: function(color, opacity){
        var m_opacity = opacity || "1.0";

        var color_a = "rgba(" + COLORS_RGB[color].light[0] + "," + COLORS_RGB[color].light[1] + "," + COLORS_RGB[color].light[2] + "," + m_opacity + ")";
        var color_b = "rgba(" + COLORS_RGB[color].dark[0] + "," + COLORS_RGB[color].dark[1] + "," + COLORS_RGB[color].dark[2] + "," + m_opacity + ")";
        return "gradient( linear, 0% 0%, 100% 0%, from( " + color_a + "), to( " + color_b + "));";
    }
}

var Modifiers = {
    FindModifierByName(unit_index, name)
    {
        for (var i = 0; i < Entities.GetNumBuffs(unit_index); i++)
        {
            var buff_name = Buffs.GetName(unit_index, Entities.GetBuff(unit_index, i))
            if (buff_name == name) {
                return Entities.GetBuff(unit_index, i)
            }
        }
        return false
    }
}

function Clamp(num, min, max) {
    return num < min ? min : num > max ? max : num;
}

function SubscribeToNetTableKey(table, key, loadNow, callback){
    var listener = CustomNetTables.SubscribeNetTableListener(table, function(table, tableKey, data){
        if (key == tableKey){
            if (!data) {
                return;
            }

            callback(data, false);
        }
    });

    if (loadNow){
        var data = CustomNetTables.GetTableValue(table, key);

        if (data) {
            callback(data, true);
        }
    }

    return listener;
}