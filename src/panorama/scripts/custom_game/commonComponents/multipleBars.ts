import ProgressBar from "../progressBar";
import { colors } from "../util";

type MultipleBarsOptions = {
    value: number, 
    maxValue: number, 
    fullColor: string, 
    missingColor?: string,
    valuePerCell: number,
    className: string,
}

export default class MultipleBars{
    progressBars: ProgressBar[] = []
    valuePerCell: number;
    container: Panel;
    maxValue: number;
    fullColor: string;
    missingColor: string;
    className: string;

    constructor(container: Panel, options: MultipleBarsOptions){
        this.container = container;
        this.maxValue = options.maxValue;
        
        this.fullColor = options.fullColor;
        this.valuePerCell = options.valuePerCell;
        this.missingColor = options.missingColor || colors.Gradient(colors.gray);
        this.className = options.className;
        this.UpdateCells();
        this.Update(options.value, options.maxValue);
    }

    Update(value: number, maxValue: number): void{
        /*if(!IsVisibleByLocal(this.entity_index)){
            return;
        }*/
        if(maxValue != this.maxValue){
            this.maxValue = maxValue;
            this.UpdateCells();
        }
    
        const fixedValue = parseInt(value.toFixed(), 10);
        const fullPanels = Math.floor(fixedValue/this.valuePerCell);
        const missingValue = fixedValue % this.valuePerCell;
        const missingValuePercent = parseInt((missingValue * 100/this.valuePerCell).toFixed(), 10);

        for(let i = 0; i < fullPanels; i ++){
            this.progressBars[i].SetProgress(100);
            this.progressBars[i].SetForegroundColor(this.fullColor);
        }

        for(let i = fullPanels; i <= this.progressBars.length; i ++){
            if(this.progressBars[i]){
                if(i == fullPanels){
                    this.progressBars[i].SetForegroundColor(this.missingColor);
                    this.progressBars[i].SetProgress(missingValuePercent);
                } else {
                    this.progressBars[i].SetProgress(0);
                }
            }
        }
    }

    UpdateCells(): void{
        const cells = this.maxValue/this.valuePerCell;

        while(this.progressBars.length < cells){
            this.AddCell();
        }

        while(this.progressBars.length > cells){
            this.RemoveCell();
        }

        this.SetWidths();
    }

    AddCell(): void{
        const index = this.progressBars.length;
        const progressBar = new ProgressBar(this.className + "__progress-bar__" + index, this.container, { foreground_color: colors.Gradient(colors.blue) });
        
        if(index > 0){
            progressBar.SetBorder({left: "0"});
        }

        this.progressBars.push(progressBar);
    }

    SetWidths(): void{
        const width = (100 * this.valuePerCell)/this.maxValue;
        this.progressBars.forEach(bar => {
            bar.SetTotalWidth(width);
        });
    }

    RemoveCell(): void{
        this.progressBars[this.progressBars.length - 1].SetVisibility("collapse");
        this.progressBars.pop();
    }
}