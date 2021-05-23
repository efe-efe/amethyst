import CustomEntities from '../customEntities';
import CustomAbilities from '../customAbilities';

const customEntities = CustomEntities.GetInstance();
const customAbilities = CustomAbilities.GetInstance();

export default class LayoutController{
    private static instance: LayoutController;
    private topPanel: Panel;
    private dimmerPanel: Panel;

    private constructor(){
        let topPanel = $.GetContextPanel();
        while(topPanel.GetParent() != null){
            const upperPanel = topPanel.GetParent();
            if(upperPanel){
                topPanel = upperPanel;
            }
        }

        this.topPanel = topPanel;
        this.dimmerPanel = $.CreatePanelWithProperties('Panel', this.topPanel, 'customDimmer', {
            class: 'customDimmer',
            hittest: 'false',
            hittestchildren: 'false',
        });

        this.dimmerPanel.style.height = '100%';
        this.dimmerPanel.style.width = '100%';
        this.dimmerPanel.style.backgroundColor = 'rgb(0, 0, 0)';
        this.dimmerPanel.style.opacity = '0.0';
        this.dimmerPanel.style.transitionProperty = 'opacity';
        this.dimmerPanel.style.transitionDuration = '0.5s';
        this.dimmerPanel.style.zIndex = -1;
    }

    public static GetInstance(): LayoutController {
        if (!LayoutController.instance) {
            LayoutController.instance = new LayoutController();
        }

        return LayoutController.instance;
    }

    public ShowDimmer(): void{
        this.dimmerPanel.style.opacity = '0.85';
    }

    public HideDimmer(): void{
        this.dimmerPanel.style.opacity = '0.0';
    }

    public GetTopPanel(): Panel{
        return this.topPanel;
    }

    public ChangeAbilityTextBySlotIndex(text: string, slotIndex: number): void{
        const boxName = 'Ability' + slotIndex;
        this.ChangeAbilityTextByBoxName(text, boxName);
    }

    private ChangeAbilityTextByBoxName(text: string, boxName: string): void{
        const abilityPanel = this.topPanel.FindChildTraverse(boxName);
    
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

    //MOVe this sOmeWhere
    private IsLocalSelectingOwnedUnit(): boolean{
        const localPlayerId = Game.GetLocalPlayerID();
        let selectedPlayerId = undefined;

        const selectedEntity = Players.GetSelectedEntities(localPlayerId)[0];
        if(selectedEntity){
            selectedPlayerId = Entities.GetPlayerOwnerID(selectedEntity);
        }

        return selectedPlayerId === localPlayerId;
    }

    public UpdateCurrency(): void{
        $.Schedule(0.03, () => {
            if(this.UpdateCurrencyVisibility()){
                this.UpdateCurrencyValues();
            }
            this.UpdateCurrency();
        });
    }

    public UpdateCurrencyVisibility(): boolean{
        if(!this.IsLocalSelectingOwnedUnit()){
            for(let i = 0; i < 9; i++){
                this.DisableAbilityEnergy(i);
            }
            return false;
        } else {
            return true;
        }
    }
    
    public UpdateCurrencyValues(): void{
        const localPlayerId = Game.GetLocalPlayerID();
        const selectedEntity = Players.GetSelectedEntities(localPlayerId)[0];
        const entityData = customEntities.GetEntity(selectedEntity);

        if(entityData){
            for(let i = 0; i < 9; i++){
                const abilityPanel = this.topPanel.FindChildTraverse('Ability' + i);
                if(abilityPanel){
                    const abilityIndex = Entities.GetAbility(selectedEntity, i);
                    const abilityEnergyCost = customAbilities.GetEnergyCost(abilityIndex);
                    const abilityManaCost = Abilities.GetManaCost(abilityIndex);
                    this.UpdateResourceBoxOnAbility(abilityPanel, abilityManaCost, abilityEnergyCost);
                    
                    if(abilityEnergyCost > 0){
                        this.UpdateAbilityEnergy(abilityPanel, abilityEnergyCost, entityData.energy);
                    }
                }
            }
        }
    }
        
    public UpdateResourceBoxOnAbility(abilityPanel: Panel, abilityManaCost: number, abilityEnergyCost: number): void{
        if(abilityManaCost > 0 || abilityEnergyCost > 0){
            abilityPanel.SetHasClass('no_mana_cost', false);
            
            const manaCost = abilityPanel.FindChildTraverse('ManaCost') as LabelPanel;
            const bevel = abilityPanel.FindChildTraverse('AbilityBevel') as ImagePanel;
            const image = abilityPanel.FindChildTraverse('AbilityImage') as ImagePanel;

            if(abilityEnergyCost > 0){
                manaCost.text = abilityEnergyCost.toString();
                manaCost.style.color = 'rgb(233, 53, 53)';
            }
            if(abilityManaCost > 0){
                manaCost.text = abilityManaCost.toString();
                manaCost.style.color = '#57b7ff';
                bevel.style.washColor = '#6095FD';
                //image.style.washColor = '#57b7ff';
            }
        } else {
            abilityPanel.SetHasClass('no_mana_cost', true);
        }
    }

    public UpdateAbilityEnergy(abilityPanel: Panel, abilityEnergyCost: number, entityEnergy: number): void{
        const image = abilityPanel.FindChildTraverse('AbilityImage') as ImagePanel;
        const bevel = abilityPanel.FindChildTraverse('AbilityBevel') as ImagePanel;
        const abilityButton = abilityPanel.FindChildTraverse('AbilityButton')!;

        if(entityEnergy >= abilityEnergyCost){
            abilityButton.style.preTransformScale2d = '1.0';
            image.style.washColor = '#bc591600';
            bevel.style.washColor = '#bc591600';
        } else {
            abilityButton.style.preTransformScale2d = '0.9';
            image.style.washColor = '#bc5916';
            bevel.style.washColor = '#bc5916';
        }
    }

    public DisableAbilityEnergy(slotIndex: number): void{
        const abilityPanel = this.topPanel.FindChildTraverse('Ability' + slotIndex);
        if(abilityPanel){
            abilityPanel.SetHasClass('energy', false);
            abilityPanel.SetHasClass('no_mana_cost', true);
        }
    }

    public CollapsePanel(panelName: string): void{
        const panel = this.topPanel.FindChildTraverse(panelName);

        if(panel){
            panel.style.visibility = 'collapse';
        }
    }

    public CollapsePanelByClass(className: string): void{
        const panel = this.topPanel.FindChildrenWithClassTraverse(className)[0];

        if(panel){
            panel.style.visibility = 'collapse';
        }
    }

    public SetPanelMargin(panelName: string, margins: any): void{
        const panel = this.topPanel.FindChildTraverse(panelName);

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
}
