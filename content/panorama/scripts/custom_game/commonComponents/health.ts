import ProgressBar from '../progressBar';
import { colors, Color } from '../shared/util';

export default class Health{
    healthProgressBar: ProgressBar;
    shieldProgressBar: ProgressBar;
    color: Color;
    showValue: boolean;
    usePercentage: boolean;

    constructor(container: Panel, color: Color, showValue = false, usePercentage = false){
        this.color = color;
        this.showValue = showValue;
        this.usePercentage = usePercentage;

        this.healthProgressBar = new ProgressBar('health__progress-bar', container, { 
            foreground_color: colors.Gradient(this.color), 
            delayed: true, 
            show_value: this.showValue 
        });
        this.shieldProgressBar = new ProgressBar('shield__progress-bar', container, { foreground_color: colors.Gradient(colors.gray) });
    }

    Update(health: number, treshold: number, maxHealth: number, shield: number): void{
        const potentialHealth = health + (30 - treshold);
    
        let healthPanelWidth;
        let healthProgress;
        let healthTotalWidth;
    
        //const cell_width = 100 * this.health_per_cell/(potentialHealth);
        
        if(shield <= 0){
            this.shieldProgressBar.SetVisibility('collapse');
            this.healthProgressBar.SetBorder({right: '1'});
            healthPanelWidth = 100 * (potentialHealth)/(maxHealth);
    
            if(potentialHealth == 0){
                healthProgress = 0;
            } else {
                healthProgress = 100 * health/(potentialHealth);
            }
            healthTotalWidth = 100;
        } else {
            this.shieldProgressBar.SetVisibility('visible');
            this.healthProgressBar.SetBorder({right: '0'});
            this.shieldProgressBar.SetBorder({left: '0'});
    
            healthTotalWidth = 100 * (health)/(maxHealth + shield);
            healthPanelWidth = 100;
            healthProgress = 100;
            
            const shieldTotalWidth = 100 * (maxHealth + shield - health)/(maxHealth + shield);
            const shieldPanelWidth = 100 * (shield + (30 - treshold))/(maxHealth + shield - health);
            const shieldProgress = 100 * shield/(shield + (30 - treshold));
            
            this.shieldProgressBar.SetTotalWidth(shieldTotalWidth);
            this.shieldProgressBar.SetPanelWidth(shieldPanelWidth);
            this.shieldProgressBar.SetProgress(shieldProgress);
        }
    
        this.healthProgressBar.SetTotalWidth(healthTotalWidth);
        this.healthProgressBar.SetPanelWidth(healthPanelWidth);
        this.healthProgressBar.SetProgress(healthProgress);

        let value = health.toString();

        if(this.usePercentage){
            value = Math.floor(100 * potentialHealth/maxHealth).toString() + '%';
        }
        this.healthProgressBar.SetValue(value);
    }
}