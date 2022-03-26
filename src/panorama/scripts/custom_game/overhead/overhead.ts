import { modifiers, entities, panels } from "../util";
import LayoutController from "../layout/layoutController";

const screenWidth = Game.GetScreenWidth();
const sreenHeight = Game.GetScreenHeight();
const scale = 1080 / sreenHeight;

export default class Overhead{
    private entityIndex: EntityIndex;
    public containerPanel: Panel;
    private thinkInterval = 0.03;
    
    constructor(entiyIndex: EntityIndex){
        this.entityIndex = entiyIndex;

        const layout = LayoutController.GetInstance();
        const basePanel = layout.GetTopPanel().FindChildrenWithClassTraverse("main")[0];

        this.containerPanel = panels.createPanelSimple(basePanel, "overhead");
        this.containerPanel.style.width = "160px"; 
        this.containerPanel.style.flowChildren = "down";
        this.Update();
    }

    Update(): void{
        if(this.UpdateVisibility()){
            this.UpdatePosition();
        }

        $.Schedule(this.thinkInterval, () => {
            this.Update();
        }); 
    }

    UpdatePosition(): boolean{
        const origin = Entities.GetAbsOrigin(this.entityIndex);
        const offset = Entities.GetHealthBarOffset(this.entityIndex);
    
        const wx = Game.WorldToScreenX(origin[0], origin[1], origin[2] + offset);
        const wy = Game.WorldToScreenY(origin[0], origin[1], origin[2] + offset);
    
        const check = Game.ScreenXYToWorld(wx, wy);

        if(check[1] != 0) {
            if(wy > sreenHeight || wx < 0 || wx > screenWidth || wy < 0){
                this.SoftHide();
                return false;
            }

            const x = scale * Math.min(screenWidth - this.containerPanel.actuallayoutwidth, Math.max(0, wx - this.containerPanel.actuallayoutwidth/2));
            const y = scale * Math.min(sreenHeight - this.containerPanel.actuallayoutheight, Math.max(0, wy - this.containerPanel.actuallayoutheight));
    
            this.containerPanel.style.position = x + "px " + y + "px 0px;";
            if(
                this.containerPanel.actuallayoutwidth ==  0 &&
                this.containerPanel.actuallayoutheight ==  0
            ){
                this.SoftHide();
                return true;
            }
        } else {
            this.SoftHide();
            return false;
        }
        return true;
    }
    
    UpdateVisibility(): boolean{
        const hide = modifiers.findModifierByName(this.entityIndex, "modifier_hide_bar");

        if(Entities.IsAlive(this.entityIndex) && entities.isVisibleByLocal(this.entityIndex) && !hide){
            this.Show();
            return true;
        } else {
            this.Hide();
            return false;
        }
    }

    SoftHide(): void{
        this.containerPanel.style.position = "-1000px -1000px 0px;";
    }

    Hide(): void{
        this.containerPanel.style.opacity = "0.0";
    }

    Show(): void{
        this.containerPanel.style.opacity = "1.0";
    }

    SetWidth(width: number): void{
        this.containerPanel.style.width = width + "px";
    }
}