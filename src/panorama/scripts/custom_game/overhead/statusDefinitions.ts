export type StatusPriority = "veryHigh" | "high" | "medium" | "low" | "veryLow";
export type StatusTrigger = "duration" | "stacks";
export type StatusContent = "clearout" | "fillup";

export type Status = {
    modifierCode: string;
    backgroundColor: string;
    textShadow: string;
    color: string;
    priority: StatusPriority;
    trigger: StatusTrigger;
    content: StatusContent;
    ability?: {
        name: string;
        hotkey: string;
    };
};

export const allStatus: Map<string, Status> = new Map();

function createTextShadow(color: string) {
    return "0px 0px 30px 8.0 " + color + ";";
}

function defineStatus(
    modifierCode: string,
    options?: {
        priority?: StatusPriority;
        backgroundColor?: string;
        textShadow?: string;
        color?: string;
        trigger?: StatusTrigger;
        content?: StatusContent;
        ability?: {
            name: string;
            hotkey: string;
        };
    }
) {
    const backgroundColor = options?.backgroundColor ?? "#F5E767";
    const textShadow = options?.textShadow ?? "none";
    const color = options?.color ?? "#FAFAFA";
    const priority = options?.priority ?? "medium";
    const trigger = options?.trigger ?? "duration";
    const content = options?.content ?? "clearout";

    allStatus.set(modifierCode, {
        modifierCode,
        backgroundColor,
        textShadow,
        color,
        priority,
        trigger,
        content,
        ability: options?.ability
    });
}

function defineRecastStatus(modifierCode: string, abilityName: string, abilityHotkey: string) {
    return defineStatus(modifierCode, {
        ability: {
            name: abilityName,
            hotkey: abilityHotkey
        },
        backgroundColor: "#ADC6DE",
        textShadow: createTextShadow("#ADC6DE"),
        priority: "veryHigh"
    });
}

function defineCounterStatus(modifierCode: string) {
    return defineStatus(modifierCode, {
        backgroundColor: "#9DBDEC",
        textShadow: createTextShadow("#9DBDEC")
    });
}

const SKY_BLUE = "#84f4eb";
const LIGHT_GREEN = "#b2f7bd";
const PURPLE = "#C655C4";
const BLUE = "#3b55ed";
const LIGHT_BLUE = "#81c3f9";
const RED = "#ed4747";
const ORANGE = "#E55C34";

defineStatus("modifier_juggernaut_mobility", {
    backgroundColor: ORANGE,
    textShadow: createTextShadow("#DC8668"),
    color: "#FFF5D7"
});
defineStatus("modifier_juggernaut_mobility", {
    backgroundColor: ORANGE,
    textShadow: createTextShadow("#DC8668"),
    color: "#FFF5D7"
});
defineStatus("modifier_juggernaut_swiftness", {
    backgroundColor: LIGHT_GREEN,
    color: LIGHT_GREEN
});
defineStatus("modifier_ruby", {
    backgroundColor: ORANGE,
    textShadow: createTextShadow(ORANGE),
    color: RED
});
defineStatus("modifier_sapphire", {
    backgroundColor: LIGHT_BLUE,
    color: LIGHT_BLUE,
    textShadow: createTextShadow(BLUE)
});
defineStatus("modifier_emerald", {
    backgroundColor: LIGHT_GREEN,
    textShadow: createTextShadow(LIGHT_GREEN)
});
defineStatus("modifier_casting", {
    backgroundColor: "#F5E767",
    textShadow: createTextShadow("#F5E767"),
    content: "fillup"
});
defineStatus("modifier_generic_fading_slow", {
    backgroundColor: "#C2AB71",
    color: "#C2AB71"
});
defineStatus("modifier_generic_sleep", {
    backgroundColor: "#CB8CFF",
    textShadow: createTextShadow("#CB8CFF")
});
defineStatus("modifier_generic_silence", {
    backgroundColor: "#C5FAFF",
    textShadow: createTextShadow("#FFBF20")
});
defineStatus("modifier_generic_stunned", {
    backgroundColor: "#ABD5FF",
    textShadow: createTextShadow("#ABD5FF")
});
defineStatus("modifier_generic_root", {
    backgroundColor: "#94A551",
    textShadow: createTextShadow("#94A551")
});
defineStatus("modifier_adrenaline", {
    backgroundColor: "#CEDCFF",
    color: "#CEDCFF"
});

defineCounterStatus("modifier_juggernaut_counter_countering");

defineRecastStatus("modifier_juggernaut_special_attack_recast", "juggernaut_special_attack_recast", "E");
defineRecastStatus("modifier_juggernaut_extra_recast", "juggernaut_extra_recast", "F");
defineRecastStatus("modifier_juggernaut_counter_recast", "juggernaut_counter_recast", "Q");
defineRecastStatus("modifier_juggernaut_ex_counter_recast", "juggernaut_ex_counter", "1");

// styles["Generic"] = {
//     backgroundColor: "#F5E767",
//     textShadow: createTextShadow("#F5E767")
// };
// styles["Heal"] = { backgroundColor: LIGHT_GREEN, color: LIGHT_GREEN };
// styles["Mana"] = { backgroundColor: LIGHT_BLUE, color: LIGHT_BLUE };
// styles["Shield"] = { backgroundColor: "#E8C070" };

// styles["Channeling"] = { backgroundColor: "#F5E767" };
// styles["Invisible"] = { backgroundColor: "#AEB3A3", color: "#AEB3A3" };
// styles["BladeFury"] = {
//     backgroundColor: ORANGE,
//     textShadow: createTextShadow("#DC8668"),
//     color: "#FFF5D7"
// };
// styles["Mekansm"] = { backgroundColor: SKY_BLUE };
// styles["Meteor"] = { backgroundColor: SKY_BLUE, color: "#DC8668" };
// styles["Nullify"] = {
//     backgroundColor: PURPLE,
//     textShadow: createTextShadow(PURPLE)
// };
// styles["Inhibit"] = {
//     backgroundColor: BLUE,
//     textShadow: createTextShadow(BLUE)
// };
// styles["Sacrifice"] = {
//     backgroundColor: LIGHT_BLUE,
//     textShadow: createTextShadow(RED)
// };
// styles["Flutter"] = {
//     backgroundColor: LIGHT_GREEN,
//     textShadow: createTextShadow(LIGHT_GREEN)
// };
// styles["Fear"] = {
//     backgroundColor: ORANGE,
//     textShadow: createTextShadow("#DC8668"),
//     color: "#DC8668"
// };
// styles["PhaseShift"] = {
//     backgroundColor: LIGHT_BLUE,
//     textShadow: createTextShadow(LIGHT_BLUE)
// };
// styles["SpellBlock"] = {
//     backgroundColor: LIGHT_BLUE,
//     textShadow: createTextShadow(RED)
// };
// styles["FairyDust"] = {
//     backgroundColor: PURPLE,
//     textShadow: createTextShadow(LIGHT_BLUE)
// };
// styles["Desolate"] = { backgroundColor: "#C655C4", color: "#C655C4" };
// styles["DancingBlades"] = { backgroundColor: "#DC8668", color: "#DC8668" };
// styles["Raze"] = {
//     backgroundColor: ORANGE,
//     textShadow: createTextShadow("#DC8668"),
//     color: "#E8C070"
// };
// styles["Desolation"] = {
//     backgroundColor: "#E55C34",
//     textShadow: createTextShadow("#DC8668"),
//     color: "#E8C070"
// };
// styles["StormUnleashed"] = {
//     backgroundColor: BLUE,
//     textShadow: createTextShadow(LIGHT_BLUE),
//     color: SKY_BLUE
// };
// styles["Bleeding"] = {
//     backgroundColor: ORANGE,
//     textShadow: createTextShadow(PURPLE),
//     color: RED
// };
// styles["Revenant"] = {
//     backgroundColor: ORANGE,
//     textShadow: createTextShadow(PURPLE),
//     color: RED
// };
// styles["Darkness"] = { backgroundColor: "#DC8668", color: "#DC8668" };
