import ProgressBar from '../progressBar';
import { colors } from '../shared/util';

export default class Energy{
    progressBar: ProgressBar;
    container: Panel;
    fullColor = colors.Gradient(colors.yellowRed);
    color = colors.Gradient(colors.gray);
    
    constructor(container: Panel){
        this.container = container;

        this.progressBar = new ProgressBar('energy__progress-bar', container, { 
            delayed: true, 
            border_radius: '3px',
            background_color: 'rgba(0,0,0, 0.8)',

        });
        this.progressBar.SetBorder({top: '0'});
        this.progressBar.SetBorderRadius({topLeft: '0', topRight: '0'});
    }

    Update(energy: number, maxEnergy: number): void{
        const progress = 100 * (energy)/(maxEnergy);
        this.progressBar.SetProgress(progress);
        if(progress === 100){
            this.progressBar.SetForegroundColor(this.fullColor);
        } else {
            this.progressBar.SetForegroundColor(this.color);
        }
    }
}

