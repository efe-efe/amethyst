import ProgressBar from '../progressBar';
import { colors } from '../shared/util';

export default class Mana{
    progressBars: ProgressBar[] = []
    manaPerCell = 25;
    container: Panel;
    maxMana: number;

    constructor(container: Panel, mana: number, maxMana: number){
        this.container = container;
        this.maxMana = maxMana;

        this.UpdateCells();
        this.Update(mana, maxMana);
    }

    Update(mana: number, maxMana: number): void{
        /*if(!IsVisibleByLocal(this.entity_index)){
            return;
        }*/

        if(maxMana != this.maxMana){
            this.maxMana = maxMana;
            this.UpdateCells();
        }
    
        const fixedMana = parseInt(mana.toFixed(), 10);
        const fullPanels = Math.floor(fixedMana/this.manaPerCell);
        const missingMana = fixedMana % this.manaPerCell;
        const missingManaPercent = parseInt((missingMana * 100/this.manaPerCell).toFixed(), 10);

        for(let i = 0; i < fullPanels; i ++){
            this.progressBars[i].SetProgress(100);
            this.progressBars[i].SetForegroundColor(colors.Gradient(colors.blue));
        }

        for(let i = fullPanels; i <= this.progressBars.length; i ++){
            if(this.progressBars[i]){
                if(i == fullPanels){
                    this.progressBars[i].SetForegroundColor(colors.Gradient(colors.gray));
                    this.progressBars[i].SetProgress(missingManaPercent);
                } else {
                    this.progressBars[i].SetProgress(0);
                }
            }
        }
    }

    UpdateCells(): void{
        const cells = this.maxMana/this.manaPerCell;

        while(this.progressBars.length < cells){
            this.AddCell();
        }

        while(this.progressBars.length > cells){
            this.RemoveCell();
        }
    }

    AddCell(): void{
        const index = this.progressBars.length;
        const progressBar = new ProgressBar('mana__progress-bar__' + index, this.container, { foreground_color: colors.Gradient(colors.blue) });
        const width = (100 * this.manaPerCell)/this.maxMana;
        progressBar.SetTotalWidth(width);
        if(index > 0){
            progressBar.SetBorder({left: 0});
        }
        this.progressBars.push(progressBar);
    }

    RemoveCell(): void{
        this.progressBars[this.progressBars.length - 1].SetVisibility('collapse');
        this.progressBars.pop();
    }
}