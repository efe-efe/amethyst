import LayoutController from './layout/layoutController';
import util, { tables } from './util';

(function(){
    const layout = LayoutController.GetInstance();
    const rewardsContainerPanel = layout.GetTopPanel().FindChildrenWithClassTraverse('rewards')[0];
    const rewardPanels = rewardsContainerPanel.FindChildrenWithClassTraverse('reward');

    const favorsContainerPanel = layout.GetTopPanel().FindChildrenWithClassTraverse('upgrades')[0];
    const upgradePanels = favorsContainerPanel.FindChildrenWithClassTraverse('upgrade');

    [...rewardPanels, ...upgradePanels].forEach((panel, i) => {
        panel.SetDisableFocusOnMouseDown(true);
    });

    const HideRewards = () => {
        rewardsContainerPanel.style.visibility = 'collapse';
    };
    const HideUpgrades = () => {
        favorsContainerPanel.style.visibility = 'collapse';
    };

    const ShowRewards = (rewards: any) => {
        rewardsContainerPanel.style.visibility = 'visible';
        rewardPanels.forEach((rewardPanel, i) => {
            const titlePanel = rewardPanel.FindChildrenWithClassTraverse('reward__title')[0] as LabelPanel;
            const descriptionPanel = rewardPanel.FindChildrenWithClassTraverse('reward__description')[0] as LabelPanel;
            titlePanel.text = 'Empty';
            descriptionPanel.text = 'No rewards here';
    
            const rewardData = rewards[i + 1];
            if(rewardData){
                titlePanel.text = rewardData.name;
                descriptionPanel.text = rewardData.description;

                rewardPanel.ClearPanelEvent('onactivate');
                rewardPanel.SetPanelEvent('onactivate', () => {
                    const playerId = util.getCurrentPlayer();
                    GameEvents.SendCustomGameEventToServer('custom_npc:select_reward', {
                        playerIndex: playerId,
                        payload: { type: rewardData.type, }
                    } as never);
                });
            }
        });
    };

    const ShowUpgrades = (upgrades: any) => {
        favorsContainerPanel.style.visibility = 'visible';
        upgradePanels.forEach((upgradeContainer, i) => {
            const titlePanel = upgradeContainer.FindChildrenWithClassTraverse('upgrade__title')[0] as LabelPanel;
            const descriptionPanel = upgradeContainer.FindChildrenWithClassTraverse('upgrade__description')[0] as LabelPanel;
            const abilityPanel = upgradeContainer.FindChildrenWithClassTraverse('upgrade__ability')[0] as AbilityImage;
            titlePanel.text = 'Empty';
            descriptionPanel.text = 'No upgrades here';
            abilityPanel.abilityname = '';
    
            const upgradeData = upgrades[i + 1];
            if(upgradeData){
                titlePanel.text = upgradeData.name;
                descriptionPanel.text = upgradeData.description;

                if(upgradeData.ability){
                    abilityPanel.abilityname = upgradeData.ability;
                }

                upgradeContainer.ClearPanelEvent('onactivate');
                upgradeContainer.SetPanelEvent('onactivate', () => {
                    const playerId = util.getCurrentPlayer();
                    GameEvents.SendCustomGameEventToServer('custom_npc:apply_favor', {
                        playerIndex: playerId,
                        payload: { upgradeId: upgradeData.id, }
                    } as never);
                });
            }
        });
    };

    tables.subscribeToNetTableAndLoadNow('custom_npc_rewards' as never, (table: never, key: string | number | symbol, value: any) => {
        const playerId = util.getCurrentPlayer();
        if(playerId === value.playerId){
            if(value.rewards){
                ShowRewards(value.rewards);
            } else {
                HideRewards();
            }
        }
    });

    tables.subscribeToNetTableAndLoadNow('custom_npc_favors' as never, (table: never, key: string | number | symbol, value: any) => {
        const playerId = util.getCurrentPlayer();
        if(playerId === value.playerId){
            if(value.upgrades){
                ShowUpgrades(value.upgrades);
            } else {
                HideUpgrades();
            }
        }
    });
})();