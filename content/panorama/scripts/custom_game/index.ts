//import './targetIndicator';
import './shared/camera/cameraController';
import './shared/mouse/mousePositionController';

import Command from './shared/commands/commands';
import Key, { GetKeyByKeyCode } from './shared/commands/key';
import Action, { GetActionByActionCode } from './shared/commands/actions';
import LayoutController from './shared/layout/layoutController';
import HeroController from './shared/heroController';
import HeroOverhead from './heroOverhead/heroOverhead';
import HeroInfoCard from './heroInfoCard';
import AllianceBar from './allianceBar';
import { tables } from './shared/util';

(function(){
    const clockPanel = $('#top-bar__clock-text') as LabelPanel;
    const refunderButton = $('#refunder__button') as Button;
    const refunderPanel = $('#refunder');
    const customHotkeysPanel = $('#custom-hotkeys');
    const hideShowButton = $('#custom-hotkeys__hide-show-button') as Button;
    const swapButton = $('#custom-hotkeys__swap-button') as Button;
    const customHotkeysAllRowsPanel = $('#custom-hotkeys__hotkeys');
    const customHotkeysTextPanel = hideShowButton.FindChildrenWithClassTraverse('custom-hotkeys__button-text')[0] as LabelPanel;
    
    const heroOverheads: any = {};
    const heroInfoCards: any = {};
    const allianceBars: any = {};

    let customHotkeysShowing = true;
    let maxScore = 3;

    const layout = LayoutController.GetInstance();
    
    const allKeys = [
        new Key('W'),
        new Key('A'),
        new Key('S'),
        new Key('D'),
        new Key('R'),
        new Key('E'),
        new Key('F'),
        new Key('Q'),
        new Key('C'),
        new Key('1'),
        new Key('2'),
        new Key('Space', 'SPACE'),
        new Key('MOUSE_1', 'LMB'),
        new Key('MOUSE_2', 'RMB')
    ];
    
    enum CUSTOM_HeroActionCodes {
        MOVE_UP,
        MOVE_LEFT,
        MOVE_DOWN,
        MOVE_RIGHT,
        BASIC_ATTACK,
        SECOND_ATTACK,
        MOBILITY,
        COUNTER,
        SPECIAL_ATTACK,
        EXTRA,
        ULTIMATE,
        EX_ONE,
        EX_TWO,
        CANCEL,
    }
    
    class AbilityAction extends Action{
        slotIndex: number;
        showEffects: boolean;
    
        constructor(name: string, actionCode: CUSTOM_HeroActionCodes, slotIndex: number, showEffects = true){
            super(name, actionCode);
            this.slotIndex = slotIndex;
            this.showEffects = showEffects;
        }
    
        OnStart(): void{
            HeroController.CastAbility(this.slotIndex, this.showEffects);
        }
    
        OnEnd(): void {
            HeroController.StopCastAbility(this.slotIndex);
        }
    }
    
    class MovementAction extends Action{
        OnStart(): void{
            const direction = this.GetDirectionFromActionCode(this.actionCode);
            HeroController.StartMoving(direction);
        }
    
        OnEnd(): void {
            const direction = this.GetDirectionFromActionCode(this.actionCode);
            HeroController.StopMoving(direction);
        }
    
        GetDirectionFromActionCode(actionCode: CUSTOM_HeroActionCodes): number[]{
            let direction = [0, 0];
            
            if(actionCode == CUSTOM_HeroActionCodes.MOVE_UP){
                direction = [0, 1];
            }
            if(actionCode == CUSTOM_HeroActionCodes.MOVE_DOWN){
                direction = [0, -1];
            }
            if(actionCode == CUSTOM_HeroActionCodes.MOVE_LEFT){
                direction = [-1, 0];
            }
            if(actionCode == CUSTOM_HeroActionCodes.MOVE_RIGHT){
                direction = [1, 0];
            }
    
            return direction;
        }
    }
    
    class CancelAction extends Action{
        OnStart(): void{
            HeroController.Cancel();
        }
    }
    
    const allActions = [
        new MovementAction('Move up', CUSTOM_HeroActionCodes.MOVE_UP),
        new MovementAction('Move down', CUSTOM_HeroActionCodes.MOVE_DOWN),
        new MovementAction('Move left', CUSTOM_HeroActionCodes.MOVE_LEFT),
        new MovementAction('Move right', CUSTOM_HeroActionCodes.MOVE_RIGHT),
        new AbilityAction('Basic attack', CUSTOM_HeroActionCodes.BASIC_ATTACK, 0, false),
        new AbilityAction('Second attack', CUSTOM_HeroActionCodes.SECOND_ATTACK, 1),
        new AbilityAction('Mobility', CUSTOM_HeroActionCodes.MOBILITY, 2),
        new AbilityAction('Counter', CUSTOM_HeroActionCodes.COUNTER, 3),
        new AbilityAction('Special attack', CUSTOM_HeroActionCodes.SPECIAL_ATTACK, 4),
        new AbilityAction('Extra attack', CUSTOM_HeroActionCodes.EXTRA, 5),
        new AbilityAction('Ultimate', CUSTOM_HeroActionCodes.ULTIMATE, 6),
        new AbilityAction('EX one', CUSTOM_HeroActionCodes.EX_ONE, 7),
        new AbilityAction('EX two', CUSTOM_HeroActionCodes.EX_TWO, 8),
        new CancelAction('Cancel', CUSTOM_HeroActionCodes.CANCEL)
    ];
    
    const CreateCommandByKeyAndActionCodes = (keyCode: string, actionCode: CUSTOM_HeroActionCodes, isAbility = false): Command => {
        const key = GetKeyByKeyCode(allKeys, keyCode)!;
        const action = GetActionByActionCode(allActions, actionCode)!;
    
        if(isAbility){
            const actionAsSpell = action as AbilityAction;
            layout.ChangeAbilityTextBySlotIndex(key.text, actionAsSpell.slotIndex);
        }
    
        return new Command(key, action);
    };
    
    const allCommands: Command[] = [
        CreateCommandByKeyAndActionCodes('W', CUSTOM_HeroActionCodes.MOVE_UP),
        CreateCommandByKeyAndActionCodes('A', CUSTOM_HeroActionCodes.MOVE_LEFT),
        CreateCommandByKeyAndActionCodes('S', CUSTOM_HeroActionCodes.MOVE_DOWN),
        CreateCommandByKeyAndActionCodes('D', CUSTOM_HeroActionCodes.MOVE_RIGHT),
        CreateCommandByKeyAndActionCodes('R', CUSTOM_HeroActionCodes.ULTIMATE, true),
        CreateCommandByKeyAndActionCodes('F', CUSTOM_HeroActionCodes.EXTRA, true),
        CreateCommandByKeyAndActionCodes('E', CUSTOM_HeroActionCodes.SPECIAL_ATTACK, true),
        CreateCommandByKeyAndActionCodes('Q', CUSTOM_HeroActionCodes.COUNTER, true),
        CreateCommandByKeyAndActionCodes('C', CUSTOM_HeroActionCodes.CANCEL),
        CreateCommandByKeyAndActionCodes('1', CUSTOM_HeroActionCodes.EX_ONE, true),
        CreateCommandByKeyAndActionCodes('2', CUSTOM_HeroActionCodes.EX_TWO, true),
        CreateCommandByKeyAndActionCodes('Space', CUSTOM_HeroActionCodes.MOBILITY, true),
        CreateCommandByKeyAndActionCodes('MOUSE_1', CUSTOM_HeroActionCodes.BASIC_ATTACK, true),
        CreateCommandByKeyAndActionCodes('MOUSE_2', CUSTOM_HeroActionCodes.SECOND_ATTACK, true),
    ];
    
    GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_TIMEOFDAY, false);
    GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_HEROES, false);
    GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_FLYOUT_SCOREBOARD, false);
    GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ACTION_MINIMAP, false);
    GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ENDGAME, false);
    GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_HERO_SELECTION_TEAMS, false);
    GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_ITEMS, false);
    GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_SHOP, false);

    layout.CollapsePanel('inventory_tpscroll_container');
    layout.CollapsePanel('inventory_neutral_slot_container');
    layout.CollapsePanelByClass('AbilityInsetShadowRight');
    layout.CollapsePanel('StatBranch');
    layout.CollapsePanel('health_mana');

    const rightFlarePanel = layout.GetTopPanel().FindChildTraverse('right_flare')!;
    rightFlarePanel.style.width = '52px';
    rightFlarePanel.style.height = '97px';
    rightFlarePanel.style.marginRight = '244px';

    const centerWithStatsPanel = layout.GetTopPanel().FindChildTraverse('center_with_stats')!;
    centerWithStatsPanel.style.horizontalAlign = 'left';
    centerWithStatsPanel.style.marginLeft = '80px';

    const buffContainerPanel = layout.GetTopPanel().FindChildTraverse('BuffContainer')!;
    buffContainerPanel.style.width = '40%';

    const abilitiesAndStatsBranchPanel = layout.GetTopPanel().FindChildTraverse('AbilitiesAndStatBranch')!;
    abilitiesAndStatsBranchPanel.style.marginBottom = '-15px';

    const centerBgPanel = layout.GetTopPanel().FindChildTraverse('center_bg')!;
    centerBgPanel.style.height = '80px';

    layout.SetPanelMargin('debuffs', { bottom: '95px' });
    layout.SetPanelMargin('buffs', { bottom: '95px' });

    const tableNameHeroes = 'heroes' as never;
    tables.subscribeToNetTableAndLoadNow(tableNameHeroes, (table: never, key: string | number | symbol, value: any) => {
        const entityIndex = value.entityIndex as EntityIndex;
        
        if(!heroOverheads[entityIndex]){
            heroOverheads[entityIndex] = new HeroOverhead(value);
        } else {
            heroOverheads[entityIndex].UpdateData(value);   
        }

        if(!heroInfoCards[entityIndex]){
            let container: Panel | null;

            if(value.allianceName == 'DOTA_ALLIANCE_RADIANT'){
                container = $('#alliances-status').FindChildTraverse('alliances-status__radiant');
            }
            if(value.allianceName == 'DOTA_ALLIANCE_DIRE'){
                container = $('#alliances-status').FindChildTraverse('alliances-status__dire');
            }
            if(value.allianceName == 'DOTA_ALLIANCE_LEGION'){
                container = $('#alliances-status').FindChildTraverse('alliances-status__legion');
            }
            if(value.allianceName == 'DOTA_ALLIANCE_VOID'){
                container = $('#alliances-status').FindChildTraverse('alliances-status__void');
            }
        
            heroInfoCards[entityIndex] = new HeroInfoCard(value, container!);
        } else {
            heroInfoCards[entityIndex].UpdateData(value);   
        }
    });

    const tableNameAlliance = 'alliances' as never;
    tables.subscribeToNetTableAndLoadNow(tableNameAlliance, (table: never, key: string | number | symbol, value: any) => {
        const allianceName = value.name as string;
        
        if(!allianceBars[allianceName]){
            const topBarContainerPanel =  $('#top-bar');
            let topBarPanel: Panel | null = null;

            if(allianceName == 'DOTA_ALLIANCE_RADIANT'){
                topBarPanel = topBarContainerPanel.FindChildTraverse('top-bar__radiant');
            }
            if(allianceName == 'DOTA_ALLIANCE_DIRE'){
                topBarPanel = topBarContainerPanel.FindChildTraverse('top-bar__dire');
            }
            if(allianceName == 'DOTA_ALLIANCE_LEGION'){
                topBarPanel = topBarContainerPanel.FindChildTraverse('top-bar__legion');
            }
            if(allianceName == 'DOTA_ALLIANCE_VOID'){
                topBarPanel = topBarContainerPanel.FindChildTraverse('top-bar__void');
            }
        
            if(topBarPanel){
                allianceBars[allianceName] = new AllianceBar(topBarPanel, value);
                allianceBars[allianceName].UpdateMaxScore(maxScore);
            }

        } else {
            allianceBars[allianceName].UpdateData(value);   
        }
    });

    const tableNameMain = 'main' as never;
    tables.subscribeToNetTableKey(tableNameMain, 'gameState', true, function(data: any){
        const refunderButton = $('#refunder') as Button;

        if(data.gameState == 1){
            refunderButton.style.visibility = 'collapse';
        }
        if(data.gameState == 2){
            refunderButton.style.visibility = 'visible';
        }
    });

    tables.subscribeToNetTableKey(tableNameMain, 'maxScore', true, function(data: any){
        maxScore = data.max_score;

        for(const allianceName in allianceBars){
            const allianceBar = allianceBars[allianceName];
            allianceBar.UpdateMaxScore(maxScore);
        }
    });


    function UpdateTime(data: any): void{
        clockPanel.text = data.timer_minute_10.toString() + data.timer_minute_01.toString() + ':' + data.timer_second_10.toString() + data.timer_second_01.toString();
    }
    GameEvents.Subscribe('countdown', UpdateTime);

    refunderButton.SetPanelEvent('onactivate', () => {
        let playerId = Players.GetLocalPlayer();

        if(Game.IsInToolsMode()){
            const selectedEntity = Players.GetSelectedEntities(playerId)[0];
            if(selectedEntity){
                playerId = Entities.GetPlayerOwnerID(selectedEntity);
            }
        }

        GameEvents.SendCustomGameEventToServer('refund_points', {
            playerId
            playerID: playerId, //Idk why this has to be this way...

        } as never);

        refunderPanel.style.visibility = 'collapse';
    });

    customHotkeysPanel.SetPanelEvent('onmouseover', () => {
        customHotkeysPanel.style.opacity = '1.0';
    });
    customHotkeysPanel.SetPanelEvent('onmouseout', () => {
        customHotkeysPanel.style.opacity = '0.5';
    });

    hideShowButton.SetPanelEvent('onactivate', () => {
        
        if(customHotkeysShowing){
            customHotkeysPanel.style.width = '140px';
            customHotkeysAllRowsPanel.style.height = '0px';
            customHotkeysTextPanel.text = 'SHOW HOTKEYS';
            swapButton.style.visibility = 'collapse';
            customHotkeysShowing = false;
        } else {
            customHotkeysPanel.style.width = '340px';
            customHotkeysAllRowsPanel.style.height = '410px';
            customHotkeysTextPanel.text = 'HIDE HOTKEYS';
            swapButton.style.visibility = 'visible';
            customHotkeysShowing = true;
        }
    });

    swapButton.SetPanelEvent('onactivate', () => {
        let playerId = Players.GetLocalPlayer();

        if(Game.IsInToolsMode()){
            const selectedEntity = Players.GetSelectedEntities(playerId)[0];
            if(selectedEntity){
                playerId = Entities.GetPlayerOwnerID(selectedEntity);
            }
        }

        GameEvents.SendCustomGameEventToServer('swap_r_f', {
            playerId
            playerID: playerId, //Idk why this has to be this way...

        } as never);
    })
})();