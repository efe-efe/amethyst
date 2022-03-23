import ProgressBar from "../progressBar";
import { modifiers } from "../util";

export default class Castpoint{
    progressBar: ProgressBar;
    entityIndex: EntityIndex;
    container: Panel;

    constructor(container: Panel, entityIndex: EntityIndex){
        this.progressBar = new ProgressBar("castpoint__progress-bar", container, {});
        this.entityIndex = entityIndex;
        this.container = container;

        this.Update();
    }

    Update(): void{
        let modifierIndex = modifiers.findModifierByName(this.entityIndex, "modifier_casting");

        if(modifierIndex){
            modifierIndex = modifierIndex as BuffID;

            const duration = Buffs.GetDuration(this.entityIndex, modifierIndex);
            const remaining = Buffs.GetRemainingTime(this.entityIndex, modifierIndex);
    
            let progressRatio = 1;
            if (remaining && duration) { progressRatio = remaining/duration; }
            if (isNaN(progressRatio)) { progressRatio = 1; }
            progressRatio = 1 - progressRatio;
    
            this.progressBar.SetProgress(progressRatio * 100);
            this.progressBar.SetForegroundColor("#FAFAFA");
    
            this.container.style.opacity = "1.0";
        } else {
            const fillness = this.progressBar.GetProgress();
            if(fillness < 100){     
                this.progressBar.SetForegroundColor("rgb(238, 53, 0)");
            } else {
                this.progressBar.SetForegroundColor("rgb(51, 162, 40)");
            }
            this.container.style.opacity = "0.0";
        }

        $.Schedule(0.03, () => {
            this.Update();
        });
    }
}