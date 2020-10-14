export default class LayoutController{
    private static instance: LayoutController;
    private mainPanel: Panel;

    private constructor(){
        this.mainPanel = this.GetTopPanel();
    }

    public static GetInstance(): LayoutController {
        if (!LayoutController.instance) {
            LayoutController.instance = new LayoutController();
        }

        return LayoutController.instance;
    }


    public GetTopPanel(): Panel{
        let topPanel = $.GetContextPanel();
        while(topPanel.GetParent() != null){
            const upperPanel = topPanel.GetParent();
            if(upperPanel){
                topPanel = upperPanel;
            }
        }

        return topPanel;
    }

    public ChangeAbilityTextBySlotIndex(text: string, slotIndex: number): void{
        const boxName = 'Ability' + slotIndex;
        this.ChangeAbilityTextByBoxName(text, boxName);
    }

    private ChangeAbilityTextByBoxName(text: string, boxName: string): void{
        const abilityPanel = this.mainPanel.FindChildTraverse(boxName);
    
        if(abilityPanel){
            const hotkey = abilityPanel.FindChildTraverse('HotkeyText') as LabelPanel;
    
            if(hotkey){
                hotkey.text = text;
                hotkey.GetParent()!.visible = true;
            } else {
                $.Schedule(2.0, () => {
                    this.ChangeAbilityTextByBoxName(text, boxName);
                });
                return;
            }
        } else {
            $.Schedule(2.0, () => {
                this.ChangeAbilityTextByBoxName(text, boxName);
            }); 
            return;
        }
    }

    public CollapsePanel(panelName: string): void{
        const panel = this.mainPanel.FindChildTraverse(panelName);

        if(panel){
            panel.style.visibility = 'collapse';
        }
    }

    private CollapsePanelByClass(className: string): void{
        const panel = this.mainPanel.FindChildrenWithClassTraverse(className)[0];

        if(panel){
            panel.style.visibility = 'collapse';
        }
    }

    public SetPanelMargin(panelName: string, margins: any): void{
        const panel = this.mainPanel.FindChildTraverse(panelName);

        if(panel){
            if(margins.bottom){
                panel.style.marginBottom = margins.bottom;
            }
            if(margins.right){
                panel.style.marginRight = margins.right;
            }
            if(margins.bottom){
                panel.style.marginBottom = margins.bottom;
            }
            if(margins.left){
                panel.style.marginLeft = margins.left;
            }
        }
    }

    public SetDefaultUI(): void{
        GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_TIMEOFDAY, false);
        GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_HEROES, false);
        GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_FLYOUT_SCOREBOARD, false);
        GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ACTION_MINIMAP, false);
        GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ENDGAME, false);
        GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_HERO_SELECTION_TEAMS, false);
        GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_ITEMS, false);
        GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_SHOP, false);

        this.CollapsePanel('inventory_tpscroll_container');
        this.CollapsePanel('inventory_neutral_slot_container');
        this.CollapsePanelByClass('AbilityInsetShadowRight');
        this.CollapsePanel('StatBranch');
        this.CollapsePanel('health_mana');

        const rightFlarePanel = this.mainPanel.FindChildTraverse('right_flare')!;
        rightFlarePanel.style.width = '52px';
        rightFlarePanel.style.height = '97px';
        rightFlarePanel.style.marginRight = '244px';


        const centerWithStatsPanel = this.mainPanel.FindChildTraverse('center_with_stats')!;
        centerWithStatsPanel.style.horizontalAlign = 'left';
        centerWithStatsPanel.style.marginLeft = '80px';

        const buffContainerPanel = this.mainPanel.FindChildTraverse('BuffContainer')!;
        buffContainerPanel.style.width = '40%';

        const abilitiesAndStatsBranchPanel = this.mainPanel.FindChildTraverse('AbilitiesAndStatBranch')!;
        abilitiesAndStatsBranchPanel.style.marginBottom = '-15px';

        const centerBgPanel = this.mainPanel.FindChildTraverse('center_bg')!;
        centerBgPanel.style.height = '80px';

        this.SetPanelMargin('debuffs', { bottom: '95px' });
        this.SetPanelMargin('buffs', { bottom: '95px' });
    }
}