import ProgressBar from "../progressBar";
import { std } from "../std";
import { Color, colors, findAllModifiers } from "../util";
import { Status, StatusContent, StatusPriority, StatusTrigger, allStatus } from "./statusDefinitions";

type BarData = { id: BuffID; status: Status };

const priorityOrder: { [key in StatusPriority]: number } = {
    veryHigh: 5,
    high: 4,
    medium: 3,
    low: 2,
    veryLow: 1
};

export function statusComponent(parent: Panel, entityIndex: EntityIndex, options?: { playerId: PlayerID; color: Color }) {
    const recast = recastComponent(parent, entityIndex);
    const dynamicContainer = std.panel(parent, { class: "dynamic" });
    const playerName = options ? playerNameComponent(dynamicContainer, options.playerId, options.color) : undefined;
    const bar = barComponent(dynamicContainer, entityIndex);

    scheduleUpdate();

    function scheduleUpdate(): void {
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

        const unitBarDatas = findAllModifiers(entityIndex)
            .map(serializeModifier)
            .filter((status): status is BarData => status != undefined)
            .sort((a, b) => priorityOrder[b.status.priority] - priorityOrder[a.status.priority]);

        if (unitBarDatas.length > 0) {
            const barData = unitBarDatas[0];
            bar.update(barData);
            bar.setVisible(true);
            playerName?.setVisible(false);

            if (barData.status.ability) {
                recast.update(barData.status.ability.name, barData.status.ability.hotkey);
                recast.setVisible(true);
            } else {
                recast.setVisible(false);
            }
        } else {
            bar.setVisible(false);
            playerName?.setVisible(true);
            recast.setVisible(false);
        }

        $.Schedule(0.03, () => {
            scheduleUpdate();
        });
    }
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

function barComponent(parent: Panel, entityIndex: EntityIndex) {
    const root = std.panel(parent, { class: "bar" });
    const topPanel = std.panel(root, { class: "bar__top" });
    const botPanel = std.panel(root, { class: "bar__bot" });
    const textGlowPanel = std.label(topPanel, { class: ["bar__text", "bar__text--glow"] });
    const textPanel = std.label(topPanel, { class: "bar__text" });
    const progressBar = new ProgressBar("bar__progress-bar", botPanel, {
        background_color: "rgba(0, 0, 0, 0.9)"
    });

    function setText(text: string) {
        textGlowPanel.text = text.toUpperCase();
        textPanel.text = text.toUpperCase();
    }

    function update(barData: BarData, maxStacks?: number) {
        const progressRatio = getProgressRatio(entityIndex, barData.id, barData.status.content, barData.status.trigger, maxStacks);
        progressBar.SetProgress(progressRatio * 100);
        progressBar.SetForegroundColor(barData.status.backgroundColor);
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

function recastComponent(parent: Panel, entityIndex: EntityIndex) {
    const root = std.panel(parent, { class: "recast" });
    const imagePanel = std.abilityImage(root, { class: "recast__image" });
    const textPanel = std.label(root, { class: "recast__text" });

    function update(abilityName: string, hotkey: string) {
        const ability = Entities.GetAbilityByName(entityIndex, abilityName);
        imagePanel.abilityname = abilityName;
        textPanel.text = hotkey;
    }

    return {
        update,
        setVisible: (visible: boolean) => root.SetHasClass("recast--visible", visible)
    };
}
