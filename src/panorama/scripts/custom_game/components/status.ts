import { std } from "../std";
import { Color, colors, findAllModifiers } from "../util";

type BarData = { id: BuffID; status: Status };

const priorityOrder: { [key in StatusPriority]: number } = {
    veryHigh: 5,
    high: 4,
    medium: 3,
    low: 2,
    veryLow: 1
};

export function statusComponent(parent: Panel, entityIndex: EntityIndex, options?: { playerId: PlayerID; color: Color }) {
    const root = std.panel(parent, { class: "status" });
    const recast = recastComponent(root);
    const dynamicContainer = std.panel(root, { class: "status__dynamic" });
    const playerName = options ? playerNameComponent(dynamicContainer, options.playerId, options.color) : undefined;
    const statusBar = statusBarComponent(dynamicContainer, entityIndex);

    scheduleUpdate();

    function serializeModifier(modifier: BuffID) {
        const name = Buffs.GetName(entityIndex, modifier);
        const status = allStatus.get(name);

        if (status?.modifierCode == "modifier_casting") {
            const ability = Buffs.GetAbility(entityIndex, modifier);
            if (Abilities.GetAbilityType(ability) != ABILITY_TYPES.ABILITY_TYPE_ULTIMATE) {
                return;
            }
        }

        if (status) {
            return { id: modifier, status: status };
        }
    }

    function scheduleUpdate(): void {
        const unitBarDatas = findAllModifiers(entityIndex)
            .map(serializeModifier)
            .filter((status): status is BarData => status != undefined)
            .sort((a, b) => priorityOrder[b.status.priority] - priorityOrder[a.status.priority]);

        if (unitBarDatas.length > 0) {
            const barData = unitBarDatas[0];
            statusBar.update(barData);
            statusBar.setVisible(true);
            playerName?.setVisible(false);

            if (barData.status.ability) {
                recast.update(barData.status.ability.name, barData.status.ability.hotkey);
                recast.setVisible(true);
            } else {
                recast.setVisible(false);
            }
        } else {
            statusBar.setVisible(false);
            playerName?.setVisible(true);
            recast.setVisible(false);
        }

        $.Schedule(0.03, () => {
            scheduleUpdate();
        });
    }

    return {
        root
    };
}

function playerNameComponent(parent: Panel, playerId: PlayerID, color: Color) {
    const root = std.panel(parent, { class: "player-name" });
    const textPanel = std.label(root, { class: "player-name__text" });
    textPanel.text = Players.GetPlayerName(playerId);
    textPanel.style.color = colors.Gradient(color);

    return {
        root,
        setVisible: (visible: boolean) => (root.visible = visible)
    };
}

function statusBarComponent(parent: Panel, entityIndex: EntityIndex) {
    const root = std.panel(parent, { class: "status-bar" });
    const textContainer = std.panel(root, { class: "status-bar__text-container" });
    const textGlowPanel = std.label(textContainer, { class: ["status-bar__text", "status-bar__text--glow"] });
    const textPanel = std.label(textContainer, { class: "status-bar__text" });
    const progressBar = std.progressBar(root, {
        class: "status-bar__progress-bar",
        min: 0,
        max: 1
    });

    function setText(text: string) {
        textGlowPanel.text = text.toUpperCase();
        textPanel.text = text.toUpperCase();
    }

    function update(barData: BarData, maxStacks?: number) {
        const progressRatio = getProgressRatio(entityIndex, barData.id, barData.status.content, barData.status.trigger, maxStacks);
        progressBar.value = progressRatio;

        const progressBarLeft = progressBar.FindChildrenWithClassTraverse("ProgressBarLeft")[0];
        progressBarLeft.style.backgroundColor = barData.status.backgroundColor;

        textGlowPanel.style.textShadow = barData.status.textShadow;
        textPanel.style.color = barData.status.color;
        setText($.Localize(`#DOTA_Tooltip_${barData.status.modifierCode}`));
    }

    function getProgressRatio(
        entityIndex: EntityIndex,
        modifierIndex: BuffID,
        content: StatusContent,
        trigger: StatusTrigger,
        maxStacks?: number
    ): number {
        let progressRatio = 1;

        if (trigger == "duration") {
            const duration = Buffs.GetDuration(entityIndex, modifierIndex);
            const remaining = Buffs.GetRemainingTime(entityIndex, modifierIndex);
            if (remaining && duration) {
                progressRatio = remaining / duration;
            }
            if (isNaN(progressRatio)) {
                progressRatio = 1;
            }
            if (content == "fillup") {
                progressRatio = 1 - progressRatio;
            }
        } else if (trigger == "stacks") {
            const stacks = Buffs.GetStackCount(entityIndex, modifierIndex) || 0;
            if (maxStacks) {
                progressRatio = stacks / maxStacks;
            }
            if (isNaN(progressRatio)) {
                progressRatio = 1;
            }
            if (content == "fillup") {
                progressRatio = 1 - progressRatio;
            }
        }

        return progressRatio;
    }

    return {
        root,
        update,
        setVisible: (visible: boolean) => (root.visible = visible)
    };
}

function recastComponent(parent: Panel) {
    const root = std.panel(parent, { class: "recast" });
    const imagePanel = std.abilityImage(root, { class: "recast__image" });
    const textPanel = std.label(root, { class: "recast__text" });

    function update(abilityName: string, hotkey: string) {
        imagePanel.abilityname = abilityName;
        textPanel.text = hotkey;
    }

    return {
        update,
        setVisible: (visible: boolean) => root.SetHasClass("recast--visible", visible)
    };
}

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
        textShadow: createTextShadow("#9DBDEC"),
        priority: "veryHigh"
    });
}

function defineUltimateStatus(modifierCode: string, content: "fillup" | "clearout") {
    return defineStatus(modifierCode, {
        backgroundColor: "#F5E767",
        textShadow: createTextShadow("#F5E767"),
        content: content
    });
}

function defineShieldStatus(modifierCode: string) {
    return defineStatus(modifierCode, { backgroundColor: "#E8C070" });
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
defineStatus("modifier_sniper_counter", {
    backgroundColor: "#AEB3A3",
    color: "#AEB3A3"
});
defineStatus("modifier_phantom_bleed", {
    backgroundColor: ORANGE,
    textShadow: createTextShadow(PURPLE),
    color: RED
});
defineStatus("modifier_phantom_ex_basic_attack", {
    backgroundColor: "#DC8668",
    color: "#DC8668"
});
defineStatus("modifier_invoker_spirit_custom", {
    backgroundColor: "#DC8668",
    color: "#DC8668"
});
defineStatus("modifier_mars_soldier_duration", {
    backgroundColor: "#DC8668",
    color: "#DC8668"
});

defineStatus("modifier_phantom_counter");

defineUltimateStatus("modifier_casting", "fillup");
defineUltimateStatus("modifier_sniper_ultimate_channeling", "clearout");

defineCounterStatus("modifier_juggernaut_counter_countering");
defineCounterStatus("modifier_phantom_counter_countering");

defineRecastStatus("modifier_juggernaut_special_attack_recast", "juggernaut_special_attack_recast", "E");
defineRecastStatus("modifier_juggernaut_extra_recast", "juggernaut_extra_recast", "F");
defineRecastStatus("modifier_juggernaut_counter_recast", "juggernaut_counter_recast", "Q");
defineRecastStatus("modifier_juggernaut_ex_counter_recast", "juggernaut_ex_counter", "1");

defineRecastStatus("modifier_phantom_counter_recast", "phantom_counter_recast", "Q");
defineRecastStatus("modifier_phantom_ex_counter_recast", "phantom_ex_counter_recast", "2");
defineRecastStatus("modifier_phantom_extra_recast", "phantom_extra", "F");

defineRecastStatus("modifier_spectre_counter_recast", "spectre_counter_recast", "Q");

defineShieldStatus("modifier_juggernaut_extra_shield");
defineShieldStatus("modifier_phantom_counter_shield");

// styles["Generic"] = {
//     backgroundColor: "#F5E767",
//     textShadow: createTextShadow("#F5E767")
// };
// styles["Heal"] = { backgroundColor: LIGHT_GREEN, color: LIGHT_GREEN };
// styles["Mana"] = { backgroundColor: LIGHT_BLUE, color: LIGHT_BLUE };

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
// styles["Revenant"] = {
//     backgroundColor: ORANGE,
//     textShadow: createTextShadow(PURPLE),
//     color: RED
// };
// styles["Darkness"] = { backgroundColor: "#DC8668", color: "#DC8668" };
