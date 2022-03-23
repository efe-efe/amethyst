import { modifiers, panels } from "../util";
export default class Charges {
    constructor(container, entityIndex, modifierName) {
        this.panel = panels.createPanelSimple(container, "charges");
        this.entityIndex = entityIndex;
        this.modifierName = modifierName;
        const textPanelLeft = panels.createPanelSimple(this.panel, "charges__text", "Label");
        this.textPanelMid = panels.createPanelSimple(this.panel, "charges__text charges__text--number", "Label");
        const textPanelRight = panels.createPanelSimple(this.panel, "charges__text", "Label");
        textPanelLeft.text = "(";
        this.textPanelMid.text = "0";
        textPanelRight.text = ")";
        this.Update();
    }
    Update() {
        let modifierIndex = modifiers.findModifierByName(this.entityIndex, this.modifierName);
        if (modifierIndex) {
            modifierIndex = modifierIndex;
            const ammount = Buffs.GetStackCount(this.entityIndex, modifierIndex);
            this.textPanelMid.text = ammount.toString();
            this.textPanelMid.style.color = "#FAFAFA";
            if (ammount == 0) {
                this.textPanelMid.style.color = "rgba(238, 53, 0, 1.0)";
            }
        }
        $.Schedule(0.03, () => {
            this.Update();
        });
    }
}
