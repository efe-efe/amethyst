import LayoutController from './layout/layoutController';
import util from './util';

(function(){
    const layout = LayoutController.GetInstance();
    const upgradesContainer = layout.GetTopPanel().FindChildrenWithClassTraverse('upgrades')[0];
    const upgradesContainers = upgradesContainer.FindChildrenWithClassTraverse('upgrade');

    upgradesContainers.forEach((upgradeContainer, i) => {
        upgradeContainer.SetDisableFocusOnMouseDown(true);
    });

    GameEvents.Subscribe('custom_npc:request_upgrades', function(event: any){
        upgradesContainer.style.visibility = 'visible';
        upgradesContainers.forEach((upgradeContainer, i) => {
            const titlePanel = upgradeContainer.FindChildrenWithClassTraverse('upgrade__title')[0] as LabelPanel;
            const descriptionPanel = upgradeContainer.FindChildrenWithClassTraverse('upgrade__description')[0] as LabelPanel;
            titlePanel.text = 'Empty';
            descriptionPanel.text = 'No upgrades here';
    
            const upgradeData = event.upgrades[i + 1];
            if(upgradeData){
                titlePanel.text = upgradeData.name;
                descriptionPanel.text = upgradeData.description;
                upgradeContainer.ClearPanelEvent('onactivate');
                upgradeContainer.SetPanelEvent('onactivate', () => {
                    const playerId = util.getCurrentPlayer();
                    GameEvents.SendCustomGameEventToServer('custom_npc:apply_upgrade', {
                        playerIndex: playerId,
                        payload: { upgradeId: upgradeData.id, }
                    } as never);
            
                    upgradesContainer.style.visibility = 'collapse';
                });
            }
        });
    });
})();