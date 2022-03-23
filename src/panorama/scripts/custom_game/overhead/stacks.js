import { modifiers, panels } from '../util';
export default class Stacks {
    constructor(container, entityIndex, modifierName) {
        this.panel = panels.createPanelSimple(container, 'stacks');
        this.entityIndex = entityIndex;
        this.modifierName = modifierName;
        const stackPanels = [];
        for (let i = 0; i < 4; i++) {
            stackPanels.push(panels.createPanelSimple(this.panel, 'stacks__stack'));
        }
        this.Update();
    }
    Update() {
        let modifierIndex = modifiers.findModifierByName(this.entityIndex, this.modifierName);
        if (modifierIndex) {
            modifierIndex = modifierIndex;
            const stacks = Buffs.GetStackCount(this.entityIndex, modifierIndex);
            for (let i = 0; i < 4; i++) {
                if (i < stacks) {
                    this.FillStack(i);
                }
                else {
                    this.EmptyStack(i);
                }
            }
        }
        else {
            for (let i = 0; i < 4; i++) {
                this.EmptyStack(i);
            }
        }
        $.Schedule(0.03, () => {
            this.Update();
        });
    }
    ChangeStackState(index, full) {
        this.panel.GetChild(index).SetHasClass('stacks__stack--empty', !full);
    }
    EmptyStack(index) {
        this.ChangeStackState(index, false);
    }
    FillStack(index) {
        this.ChangeStackState(index, true);
    }
    GetPanel() {
        return this.panel;
    }
}
