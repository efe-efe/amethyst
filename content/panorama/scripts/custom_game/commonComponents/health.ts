import ProgressBar from '../progressBar';
import { colors, Color, panels } from '../shared/util';

type HealthData = {
    color: Color;
    fontSize?: string ;
    showValue?: boolean;
    usePercentage?: boolean;
    rounded?: boolean;
    resize?: boolean;
}

export default class Health{
    healthProgressBar: ProgressBar;
    shieldProgressBar: ProgressBar;
    healthPanel: Panel;
    valuePanel: LabelPanel;
    color: Color;
    showValue: boolean;
    usePercentage: boolean;
    rounded: boolean;
    borderRadius = '3';

    constructor(container: Panel, data: HealthData){
        const fontSize = (data.fontSize) ? data.fontSize : '13px';
        const showValue = (data.showValue) ? data.showValue : false;
        const usePercentage = (data.usePercentage) ? data.usePercentage : false;
        this.rounded = (data.rounded) ? data.rounded : false;
        const resize = (data.resize) ? data.resize : true;

        this.color = data.color;
        this.showValue = showValue;
        this.usePercentage = usePercentage;

        this.healthPanel =  panels.createPanelSimple(container, 'health');
        this.valuePanel = panels.createPanelSimple(container, 'health__value', 'Label') as LabelPanel;

        this.healthProgressBar = new ProgressBar('health__progress-bar', this.healthPanel, { 
            foreground_color: colors.Gradient(this.color), 
            delayed: true, 
            background_color: 'black',
            border_radius: (this.rounded) ? this.borderRadius + 'px' : '0',
        });
        this.shieldProgressBar = new ProgressBar('shield__progress-bar', this.healthPanel, { 
            foreground_color: colors.Gradient(colors.gray),
            background_color: 'black',
            border_radius: (this.rounded) ? '2px' : '0',
        });
        
        this.healthPanel.style.flowChildren = 'right';
        this.healthPanel.style.height = '100%';
        this.healthPanel.style.width = '100%';

        this.valuePanel.style.align = 'center center';
        this.valuePanel.style.textShadow = '0px 0px 8px 7.0 #000000b0';
        this.valuePanel.style.color = '#FAFAFA';
        this.valuePanel.style.fontSize = fontSize;
        this.valuePanel.style.fontFamily = 'Radiance, FZLanTingHei-R-GBK, TH Sarabun New, Gulim,MingLiU';
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

            if(this.rounded){
                this.healthProgressBar.SetBorderRadius({topRight: this.borderRadius, bottomRight: this.borderRadius});
                this.shieldProgressBar.SetBorderRadius({topLeft: this.borderRadius, bottomLeft: this.borderRadius});
            }

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
            
            if(this.rounded){
                this.healthProgressBar.SetBorderRadius({topRight: '0', bottomRight: '0'});
                this.shieldProgressBar.SetBorderRadius({topLeft: '0', bottomLeft: '0'});
            }

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
        this.valuePanel.text = value;
    }
}