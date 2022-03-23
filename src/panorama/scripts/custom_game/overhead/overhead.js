import { modifiers, entities, panels } from "../util";
import LayoutController from "../layout/layoutController";
export default class Overhead {
    constructor(entiyIndex) {
        this.thinkInterval = 0.03;
        this.entityIndex = entiyIndex;
        const layout = LayoutController.GetInstance();
        const basePanel = layout.GetTopPanel().FindChildrenWithClassTraverse("main")[0];
        this.containerPanel = panels.createPanelSimple(basePanel, "overhead");
        this.containerPanel.style.width = "160px";
        this.containerPanel.style.flowChildren = "down";
        this.Update();
    }
    Update() {
        if (this.UpdateVisibility()) {
            this.UpdatePosition();
        }
        $.Schedule(this.thinkInterval, () => {
            this.Update();
        });
    }
    UpdatePosition() {
        const origin = Entities.GetAbsOrigin(this.entityIndex);
        const offset = Entities.GetHealthBarOffset(this.entityIndex);
        const wx = Game.WorldToScreenX(origin[0], origin[1], origin[2] + offset);
        const wy = Game.WorldToScreenY(origin[0], origin[1], origin[2] + offset);
        const check = Game.ScreenXYToWorld(wx, wy);
        if (check[1] != 0) {
            const sw = Game.GetScreenWidth();
            const sh = Game.GetScreenHeight();
            const scale = 1080 / sh;
            const x = scale * Math.min(sw - this.containerPanel.actuallayoutwidth, Math.max(0, wx - this.containerPanel.actuallayoutwidth / 2));
            const y = scale * Math.min(sh - this.containerPanel.actuallayoutheight, Math.max(0, wy - this.containerPanel.actuallayoutheight));
            this.containerPanel.style.position = x + "px " + y + "px 0px;";
            if (this.containerPanel.actuallayoutwidth == 0 &&
                this.containerPanel.actuallayoutheight == 0) {
                this.containerPanel.style.position = "-1000px -1000px 0px;";
                return true;
            }
        }
        else {
            this.containerPanel.style.position = "-1000px -1000px 0px;";
            return false;
        }
        return true;
    }
    UpdateVisibility() {
        const hide = modifiers.findModifierByName(this.entityIndex, "modifier_hide_bar");
        if (!Entities.IsAlive(this.entityIndex) || !entities.isVisibleByLocal(this.entityIndex) || hide != false) {
            this.Hide();
            return false;
        }
        else {
            this.Show();
            return true;
        }
    }
    Hide() {
        this.containerPanel.style.opacity = "0.0";
    }
    Show() {
        this.containerPanel.style.opacity = "1.0";
    }
    SetWidth(width) {
        this.containerPanel.style.width = width + "px";
    }
}
