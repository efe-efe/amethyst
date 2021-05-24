import LayoutController from './layout/layoutController';
import util, { tables } from './util';

(function(){
    const layout = LayoutController.GetInstance();
    const upgradesContainer = layout.GetTopPanel().FindChildrenWithClassTraverse('upgrades')[0];
    const upgradesContainers = upgradesContainer.FindChildrenWithClassTraverse('upgrade');

    upgradesContainers.forEach((upgradeContainer, i) => {
        upgradeContainer.SetDisableFocusOnMouseDown(true);
    });

    const HideUpgrades = () => {
        upgradesContainer.style.visibility = 'collapse';
    };

    const ShowUpgrades = (upgrades: any) => {
        upgradesContainer.style.visibility = 'visible';
        upgradesContainers.forEach((upgradeContainer, i) => {
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

    const tableName = 'custom_npc_upgrades' as never;
    tables.subscribeToNetTableAndLoadNow(tableName, (table: never, key: string | number | symbol, value: any) => {
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