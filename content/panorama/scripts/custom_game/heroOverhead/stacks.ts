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
            const stacks = Buffs.GetStackCount(this.entityIndex, modifierIndex);


            for(let i = 0; i < 4; i++){
                if(i < stacks){
                    this.FillStack(i);
                } else {
                    this.EmptyStack(i);
                }
            }
        } else {
            for(let i = 0; i < 4; i++){
                this.EmptyStack(i);
            }
        }

        $.Schedule(0.03, () => {
            this.Update();
        });
    }

    ChangeStackState(index: number, full: boolean): void{
        this.panel.GetChild(index)!.SetHasClass('stacks__stack--empty', !full);
    }

    EmptyStack(index: number): void{
        this.ChangeStackState(index, false);
    }

    FillStack(index: number): void{
        this.ChangeStackState(index, true);
    }

    GetPanel(): Panel{
        return this.panel;
    }
}