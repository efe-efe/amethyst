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