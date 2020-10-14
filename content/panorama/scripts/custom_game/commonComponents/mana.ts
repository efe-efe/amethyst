import ProgressBar from '../progressBar';
import { colors } from '../shared/util';

export default class Mana{
    progressBars: ProgressBar[] = []
    manaPerCell = 25;
    container: Panel;

    constructor(container: Panel, mana: number, maxMana: number){
        this.container = container;

        this.Update(mana, maxMana);
    }

    Update(mana: number, maxMana: number): void{
        /*if(!IsVisibleByLocal(this.entity_index)){
            return;
        }*/
    
        const cells = maxMana/this.manaPerCell;
        let iterator = 0;
    
        while(this.progressBars.length < cells){
            const progressBar = new ProgressBar('mana__progress-bar__' + iterator, this.container, { foreground_color: colors.Gradient(colors.blue) });
            this.progressBars.push(progressBar);
    
            iterator++;
        }
    
        while(this.progressBars.length > cells){
            this.progressBars[this.progressBars.length - 1].SetVisibility('collapse');
            this.progressBars.pop();
        }
        for(let i = 0; i < this.progressBars.length; i++){
            const width = (100 * this.manaPerCell)/maxMana;
            this.progressBars[i].SetTotalWidth(width);
            if(i > 0){
                this.progressBars[i].SetBorder({left: 0});
            }
        }
    
        let panelIterator = 0;
        let manaTmp = 0;
    
        for(let i = 0; i <= mana; i ++){
            if(manaTmp == this.manaPerCell){
                this.progressBars[panelIterator].SetProgress(100);
                this.progressBars[panelIterator].SetForegroundColor(colors.Gradient(colors.blue));
                manaTmp = 0;
                panelIterator++;
            }
            if(manaTmp < this.manaPerCell && i == mana && i != maxMana){
                this.progressBars[panelIterator].SetProgress(manaTmp * 4);
                this.progressBars[panelIterator].SetForegroundColor(colors.Gradient(colors.gray));
    
                for(let j = panelIterator + 1; j < this.progressBars.length; j ++){
                    this.progressBars[j].SetProgress(0);
                }
            }
    
            manaTmp++;
        }
    }
}