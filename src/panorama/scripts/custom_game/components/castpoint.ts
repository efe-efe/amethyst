import { std } from "../std";
import { findModifierByName } from "../util";

export function castpointComponent(parent: Panel, entityIndex: EntityIndex) {
    const root = std.panel(parent, { class: "castpoint" });
    const progress = std.progressBar(root, { class: "castpoint__progress", min: 0, max: 1 });

    function setVisible(visible: boolean) {
        root.SetHasClass("castpoint--visible", visible);
    }

    function scheduleUpdate() {
        const modifierIndex = findModifierByName(entityIndex, "modifier_casting");

        if (modifierIndex) {
            const duration = Buffs.GetDuration(entityIndex, modifierIndex);
            const remaining = Buffs.GetRemainingTime(entityIndex, modifierIndex);

            const progressRatio = 1 - remaining / duration;
            progress.value = progressRatio;

            root.SetHasClass("castpoint--error", false);
            root.SetHasClass("castpoint--success", false);
            setVisible(true);
        } else {
            root.SetHasClass("castpoint--error", progress.value < 0.85);
            root.SetHasClass("castpoint--success", progress.value >= 0.85);
            setVisible(false);
        }

        $.Schedule(0.03, scheduleUpdate);
    }

    scheduleUpdate();
}
