export function image(path: string) {
    return `<img src='file://{images}/custom_game/${path}.png'/>`;
}

function coloredText(text: string, color: string) {
    return `<font color='${color}'>${text}</font>`;
}

export function heal(text: string) {
    return coloredText(text, "#97DF3B");
}

export function abilityWithIcon(name: string, icon: string) {
    return `${image(icon)} <b>${coloredText(name, "#ffffff")}</b>`;
}

export function createKeyword(
    name: string,
    options?: {
        description?: string;
        icon?: string;
        dynamic?: boolean;
        color?: string;
    }
) {
    const color = options?.color ?? "#ffffff";

    function getName(value?: string) {
        let output = "<b>";

        if (options?.icon) {
            output += image(options.icon);
        }

        output += coloredText(name.toUpperCase(), color);

        if (options?.dynamic) {
            output += ` (${value ?? "X"})`;
        }

        return output;
    }

    function getDescription() {
        let output = "";

        output += getName();

        if (options?.description) {
            output += `: ${coloredText(options.description, "#B2B5B3")}`;
        }

        return (output += "</b>");
    }

    return {
        name: getName,
        description: getDescription()
    };
}

export function upgrade(description: string) {
    return `<br><br><b>${image("add")}${coloredText("LEVEL UPGRADE", "#61ffd0")}</b> ${coloredText(
        "(PVP ONLY)",
        "gray"
    )}<br>${description}`;
}

export function secondaryAbility(name: string, icon: string, description: string) {
    return `<br><br><b>${image(icon)} ${coloredText(name.toUpperCase(), "#ffffff")}</b><br> ${description}`;
}
