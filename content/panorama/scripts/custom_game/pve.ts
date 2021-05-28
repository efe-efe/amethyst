import LayoutController from './layout/layoutController';
import util, { tables } from './util';

(function(){
    const layout = LayoutController.GetInstance();
    const bountiesContainerPanel = layout.GetTopPanel().FindChildrenWithClassTraverse('bounties')[0];
    const bountyPanels = bountiesContainerPanel.FindChildrenWithClassTraverse('bounty');

    const upgradesContainerPanel = layout.GetTopPanel().FindChildrenWithClassTraverse('upgrades')[0];
    const upgradePanels = upgradesContainerPanel.FindChildrenWithClassTraverse('upgrade');

    [...bountyPanels, ...upgradePanels].forEach((panel, i) => {
        panel.SetDisableFocusOnMouseDown(true);
    });

    const Hidebounties = () => {
        bountiesContainerPanel.style.visibility = 'collapse';
    };
    const HideUpgrades = () => {
        upgradesContainerPanel.style.visibility = 'collapse';
    };

    const Showbounties = (bounties: any) => {
        bountiesContainerPanel.style.visibility = 'visible';
        bountyPanels.forEach((bountyPanel, i) => {
            const titlePanel = bountyPanel.FindChildrenWithClassTraverse('bounty__title')[0] as LabelPanel;
            const descriptionPanel = bountyPanel.FindChildrenWithClassTraverse('bounty__description')[0] as LabelPanel;
            titlePanel.text = 'Empty';
            descriptionPanel.text = 'No bounties here';
    
            const bountyData = bounties[i + 1];
            if(bountyData){
                titlePanel.text = bountyData.name;
                descriptionPanel.text = bountyData.description;

                bountyPanel.ClearPanelEvent('onactivate');
                bountyPanel.SetPanelEvent('onactivate', () => {
                    const playerId = util.getCurrentPlayer();
                    GameEvents.SendCustomGameEventToServer('custom_npc:select_bounty', {
                        playerIndex: playerId,
                        payload: { bountyId: bountyData.id, }
                    } as never);
                });
            }
        });
    };

    const ShowUpgrades = (upgrades: any) => {
        upgradesContainerPanel.style.visibility = 'visible';
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
                    GameEvents.SendCustomGameEventToServer('custom_npc:apply_upgrade', {
                        playerIndex: playerId,
                        payload: { upgradeId: upgradeData.id, }
                    } as never);
                });
            }
        });
    };

    tables.subscribeToNetTableAndLoadNow('custom_npc_bounties' as never, (table: never, key: string | number | symbol, value: any) => {
        const playerId = util.getCurrentPlayer();
        if(playerId === value.playerId){
            if(value.bounties){
                Showbounties(value.bounties);
            } else {
                Hidebounties();
            }
        }
    });

    tables.subscribeToNetTableAndLoadNow('custom_npc_upgrades' as never, (table: never, key: string | number | symbol, value: any) => {
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