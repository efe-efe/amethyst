import { toplevelRoot } from "../components/topLevelRoot";
import { std } from "../std";
import { decodeFromJson, subscribeToNetTableAndLoadNow } from "../util";

function upgradesComponent(parent: Panel) {
    const root = std.panel(parent, { class: "upgrades" });
    let upgrades: ReturnType<typeof upgradeComponent>[] = [];

    function cleanUpgrades() {
        for (const upgrade of upgrades) {
            upgrade.destroy();
        }

        upgrades = [];
    }

    function setUpgrades(updated: UpgradeId[]) {
        for (const upgrade of updated) {
            const component = upgradeComponent(root, upgrade);

            upgrades.push(component);
        }
    }

    return {
        root,
        cleanUpgrades,
        setUpgrades
    };
}

function upgradeComponent(parent: Panel, id: UpgradeId) {
    const root = std.panel(parent, { class: "upgrade" });
    const container = std.panel(root, { class: "upgrade__container" });
    const rarity = std.label(root, { class: "upgrade__rarity", text: "Legendary" });
    const iconContainer = std.panel(container, { class: "upgrade__icon-container" });
    const textContainer = std.panel(container, { class: "upgrade__text" });
    const title = std.label(textContainer, { class: "upgrade__title", text: $.Localize(`#Upgrade_${id}`) });
    const description = std.label(textContainer, {
        class: "upgrade__description",
        text: $.Localize(`#Upgrade_${id}_Description`)
    });
    const icon = std.image(iconContainer, {
        class: "upgrade__icon",
        src: "file://{images}/spellicons/phantom_assassin_stifling_dagger.png"
    });

    root.SetPanelEvent("onactivate", () => {
        GameEvents.SendCustomGameEventToServer("pickUpgrade", {
            upgradeId: id
        });
    });

    function destroy() {
        root.DeleteAsync(0);
    }

    return {
        root: root,
        destroy
    };
}

const root = toplevelRoot("upgradesHUD");
root.SetHasClass("upgradesHUD--blessing", true);
root.SetHasClass("upgradesHUD--visible", false);

const tile = std.label(root, { class: "upgradesHUD__title", text: $.Localize("#Upgrade_blessing") });

const upgradesPanel = upgradesComponent(root);
std.image(root, { src: "file://{images}/custom_game/phantom_assassin_art.png", class: "upgradesHUD__hero" });

subscribeToNetTableAndLoadNow("pve", (table, key, value) => {
    if ((key as PlayerID) == Game.GetLocalPlayerID()) {
        upgradesPanel.cleanUpgrades();

        if (!value.selection) {
            root.SetHasClass("upgradesHUD--visible", false);
            return;
        }

        root.SetHasClass("upgradesHUD--visible", true);
        const upgrades = decodeFromJson(value.selection.upgrades);

        upgradesPanel.setUpgrades(upgrades);
    }
});
