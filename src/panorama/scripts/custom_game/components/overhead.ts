import { findModifierByName } from "../util";
import { std } from "../std";
import { statusComponent } from "./status";
import { healthComponent } from "./health";
import { castpointComponent } from "./castpoint";
import { resourceComponent } from "./resource";

const screenWidth = Game.GetScreenWidth();
const sreenHeight = Game.GetScreenHeight();
const scale = 1080 / sreenHeight;

function overhead(to: Panel, entityIndex: EntityIndex) {
    function isEntityVisibleByLocal(entityIndex: EntityIndex) {
        return findModifierByName(entityIndex, "modifier_visible") != undefined;
    }

    function scheduleUpdate() {
        if (updateVisibility()) {
            updatePosition();
        }

        $.Schedule(0.03, () => {
            scheduleUpdate();
        });
    }

    function updatePosition() {
        const origin = Entities.GetAbsOrigin(entityIndex);
        const offset = Entities.GetHealthBarOffset(entityIndex);

        const wx = Game.WorldToScreenX(origin[0], origin[1], origin[2] + offset);
        const wy = Game.WorldToScreenY(origin[0], origin[1], origin[2] + offset);

        const check = Game.ScreenXYToWorld(wx, wy);

        if (check[1] != 0) {
            if (wy > sreenHeight || wx < 0 || wx > screenWidth || wy < 0) {
                hide();
                return false;
            }

            const x = scale * Math.min(screenWidth - to.actuallayoutwidth, Math.max(0, wx - to.actuallayoutwidth / 2));
            const y = scale * Math.min(sreenHeight - to.actuallayoutheight, Math.max(0, wy - to.actuallayoutheight));

            to.style.position = x + "px " + y + "px 0px;";
            if (to.actuallayoutwidth == 0 && to.actuallayoutheight == 0) {
                hide();
                return true;
            }
        } else {
            hide();
            return false;
        }
        return true;
    }

    function updateVisibility() {
        const hidden = findModifierByName(entityIndex, "modifier_hide_bar");
        const visible = Entities.IsAlive(entityIndex) && isEntityVisibleByLocal(entityIndex) && !hidden;
        setVisible(visible);
        return visible;
    }

    function hide() {
        to.style.position = "-1000px -1000px 0px;";
    }

    function setVisible(visible: boolean) {
        to.visible = visible;
    }

    scheduleUpdate();
}

export function unitOverheadComponent(parent: Panel, entityIndex: EntityIndex) {
    const root = std.panel(parent, { class: "overhead" });
    statusComponent(root, entityIndex);
    const info = std.panel(root, { class: "overhead__info" });
    const resources = std.panel(info, { class: "overhead__resources" });
    const healthContainer = std.panel(resources, { class: "overhead__health" });

    const health = healthComponent(healthContainer, {
        rounded: true,
        shieldDisplay: "over",
        color: "red"
    });

    overhead(root, entityIndex);

    function update(data: UnitData) {
        health.update(data.health, 0, data.maxHealth, data.shield);
    }

    return {
        update
    };
}

export function heroOverheadComponent(parent: Panel, entityIndex: EntityIndex) {
    const root = std.panel(parent, { class: "overhead" });
    statusComponent(root, entityIndex);
    const info = std.panel(root, { class: ["overhead__info", "overhead__info--hero"] });
    const charges = std.panel(info, { class: "overhead__charges" });

    const resources = std.panel(info, { class: "overhead__resources" });
    const healthContainer = std.panel(resources, { class: "overhead__health" });
    const manaContainer = std.panel(resources, { class: "overhead__mana" });
    const energyContainer = std.panel(resources, { class: "overhead__energy" });
    const castpointContainer = std.panel(resources, { class: "overhead__castpoint" });
    const ammoContainer = std.panel(info, { class: "overhead__ammo" });
    const stackbarsContainer = std.panel(ammoContainer, { class: "overhead__stackbars" });
    const cooldownContainer = std.panel(ammoContainer, { class: "overhead__cooldown" });

    const health = healthComponent(healthContainer, {
        rounded: true,
        shieldDisplay: "side",
        color: "red"
    });

    const mana = resourceComponent(manaContainer);
    const energy = resourceComponent(energyContainer);
    castpointComponent(castpointContainer, entityIndex);

    overhead(root, entityIndex);

    function update(data: UnitData) {
        health.update(data.health, 0, data.maxHealth, data.shield);
        mana.update(data.mana, data.maxMana);
        mana.setCells(data.maxMana / 25);

        if (data.heroData) {
            energy.update(data.heroData.energy, data.heroData.maxEnergy);
        }
    }

    return {
        update
    };
}
