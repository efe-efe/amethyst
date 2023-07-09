import LayoutController from "./layout/layoutController";
import util, { tables } from "./util";

enum RewardTypes {
    FAVOR = 0,
    SHARD,
    ITEM,
    KNOWLEDGE,
    VITALITY,
    SECRET_SHOP,
    GOLD
}

(function () {
    const layout = LayoutController.GetInstance();
    const rewardsMainContainerPanel = layout.GetTopPanel().FindChildrenWithClassTraverse("rewards")[0];
    const rewardsContainerPanel = layout.GetTopPanel().FindChildrenWithClassTraverse("rewards-container")[0];
    const upgradesContainerPanel = layout.GetTopPanel().FindChildrenWithClassTraverse("upgrades")[0];

    const CreateRewardPanel = (isLast: boolean): Panel => {
        const panel = $.CreatePanel("Panel", rewardsContainerPanel, "");
        panel.BLoadLayoutSnippet("Reward");
        if (isLast) {
            panel.AddClass("reward--last");
        }
        OnPanelCreated(panel);
        return panel;
    };

    const CreateUpgradePanel = (isLast: boolean): Panel => {
        const panel = $.CreatePanel("Panel", upgradesContainerPanel, "");
        panel.BLoadLayoutSnippet("Upgrade");
        if (isLast) {
            panel.AddClass("upgrade--last");
        }
        OnPanelCreated(panel);
        return panel;
    };

    const OnPanelCreated = (panel: Panel): void => {
        panel.SetDisableFocusOnMouseDown(true);
        panel.SetPanelEvent("onactivate", () => {
            const playerId = util.getCurrentPlayer();
            GameEvents.SendCustomGameEventToServer("custom_npc:apply_favor", {
                playerIndex: playerId,
                payload: { upgradeId: "" }
            } as never);
        });
    };

    const images: {
        [key: number]: {
            src: string;
            height?: number;
            width?: number;
        };
    } = {
        [RewardTypes.FAVOR]: {
            src: "file://{images}/custom_game/shield-9dsfs0d.png",
            width: 120
        },
        [RewardTypes.SHARD]: {
            src: "file://{images}/custom_game/patch_general.png"
        },
        [RewardTypes.ITEM]: {
            src: "file://{images}/custom_game/immortal_alt.png",
            width: 150
        },
        [RewardTypes.KNOWLEDGE]: {
            src: "file://{images}/custom_game/book.png"
        },
        [RewardTypes.VITALITY]: {
            src: "file://{images}/custom_game/benefactor_bg.png",
            width: 150
        },
        [RewardTypes.SECRET_SHOP]: {
            src: "file://{images}/custom_game/book.png"
        },
        [RewardTypes.GOLD]: {
            src: "file://{images}/custom_game/tribute_image.png"
        }
    };

    const CleanRewards = () => {
        const panels = rewardsContainerPanel.FindChildrenWithClassTraverse("reward");
        panels.forEach(panel => {
            panel.DeleteAsync(0);
        });
    };

    const CleanUpgrades = () => {
        const panels = upgradesContainerPanel.FindChildrenWithClassTraverse("upgrade");
        panels.forEach(panel => {
            panel.DeleteAsync(0);
        });
    };

    const HideRewards = () => {
        CleanRewards();
        rewardsMainContainerPanel.style.visibility = "collapse";
    };
    const HideUpgrades = () => {
        CleanUpgrades();
        upgradesContainerPanel.style.visibility = "collapse";
    };

    const ShowRewards = (rewards: any) => {
        CleanRewards();
        rewardsMainContainerPanel.style.visibility = "visible";
        for (const key in rewards) {
            const panel = CreateRewardPanel(false);
            const reward = rewards[key];
            const titlePanel = panel.FindChildrenWithClassTraverse("reward__title")[0] as LabelPanel;
            const descriptionPanel = panel.FindChildrenWithClassTraverse("reward__description")[0] as LabelPanel;
            const imagePanel = panel.FindChildrenWithClassTraverse("reward__image")[0] as ImagePanel;

            if (reward) {
                titlePanel.text = reward.name;
                descriptionPanel.text = reward.description;

                const image = images[reward.type as number];
                imagePanel.SetImage(image.src);
                if (image.height) {
                    imagePanel.style.height = image.height + "px";
                } else {
                    imagePanel.style.height = "120px";
                }
                if (image.width) {
                    imagePanel.style.width = image.width + "px";
                } else {
                    imagePanel.style.width = "170px";
                }

                panel.SetPanelEvent("onactivate", () => {
                    const playerId = util.getCurrentPlayer();
                    GameEvents.SendCustomGameEventToServer("custom_npc:select_reward", {
                        playerIndex: playerId,
                        payload: { type: reward.type }
                    } as never);
                });
            }
        }
    };

    const ShowUpgrades = (upgrades: any) => {
        CleanUpgrades();
        upgradesContainerPanel.style.visibility = "visible";
        let missingPanels = 3;
        for (const key in upgrades) {
            const panel = CreateUpgradePanel(false);
            const upgrade = upgrades[key];
            const titlePanel = panel.FindChildrenWithClassTraverse("upgrade__title")[0] as LabelPanel;
            const descriptionPanel = panel.FindChildrenWithClassTraverse("upgrade__description")[0] as LabelPanel;
            const abilityPanel = panel.FindChildrenWithClassTraverse("upgrade__ability")[0] as AbilityImage;

            titlePanel.text = upgrade.name;
            descriptionPanel.text = upgrade.description;

            if (upgrade.ability) {
                abilityPanel.abilityname = upgrade.ability;
            }
            if (upgrade.abilityIconName) {
                abilityPanel.abilityname = upgrade.abilityIconName;
            }
            panel.SetPanelEvent("onactivate", () => {
                const playerId = util.getCurrentPlayer();
                GameEvents.SendCustomGameEventToServer("custom_npc:apply_favor", {
                    playerIndex: playerId,
                    payload: { upgradeId: upgrade.id }
                } as never);
            });
            missingPanels--;
        }

        for (let i = 0; i < missingPanels; i++) {
            CreateUpgradePanel(false);
        }
    };

    tables.subscribeToNetTableAndLoadNow("custom_npc_rewards", (table, key, value) => {
        const playerId = util.getCurrentPlayer();
        if (playerId === value.playerId) {
            if (value.rewards) {
                ShowRewards(value.rewards);
            } else {
                HideRewards();
            }
        }
    });

    tables.subscribeToNetTableAndLoadNow("custom_npc_favors", (table, key, value) => {
        const playerId = util.getCurrentPlayer();
        if (playerId === value.playerId) {
            if (value.upgrades) {
                ShowUpgrades(value.upgrades);
            } else {
                HideUpgrades();
            }
        }
    });
})();
