import { toplevelRoot } from "../components/topLevelRoot";
import { std } from "../std";
import { decodeFromJson, subscribeToNetTableAndLoadNow } from "../util";

const root = toplevelRoot("upgradesHUD");
let options: Panel[] = [];

subscribeToNetTableAndLoadNow("pve", (table, key, value) => {
    if ((key as PlayerID) == Game.GetLocalPlayerID()) {
        const upgrades = decodeFromJson(value.upgrades);

        for (const option of options) {
            option.DeleteAsync(0);
        }

        options = [];

        if (upgrades.length == 0) {
            return;
        }

        for (const upgrade of upgrades) {
            const option = std.button(root, { class: "upgrade" });
            std.label(option, { text: upgrade });

            option.SetPanelEvent("onactivate", () => {
                GameEvents.SendCustomGameEventToServer("pickUpgrade", upgrade);
            });

            options.push(option);
        }
    }
});
