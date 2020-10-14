import { modifiers, panels } from '../shared/util';

export default class Stacks{
    panel: Panel;
    entityIndex: EntityIndex;
    modifierName: string;

    constructor(container: Panel, entityIndex: EntityIndex, modifierName: string){
        this.panel = panels.createPanelSimple(container, 'stacks');
        this.entityIndex = entityIndex;
        this.modifierName = modifierName;

        const stackPanels: Panel[] = [];

        for(let i = 0; i < 4; i++){
            stackPanels.push(panels.createPanelSimple(this.panel, 'stacks__stack'));
        }
        
        this.Update();
    }

    Update(): void{
        let modifierIndex = modifiers.findModifierByName(this.entityIndex, this.modifierName);

        if(modifierIndex){
            modifierIndex = modifierIndex as BuffID;
            
            const ammount = Buffs.GetStackCount(this.entityIndex, modifierIndex);
            for(let i = 0; i < ammount; i++){
                this.panel.GetChild(i)!.style.opacity = '1.0';
            }
        } else {
            for(let i = 0; i < 4; i++){
                this.panel.GetChild(i)!.style.opacity = '0.0';
            }
        }

        $.Schedule(0.03, () => {
            this.Update();
        });
    }

    GetPanel(): Panel{
        return this.panel;
    }
}