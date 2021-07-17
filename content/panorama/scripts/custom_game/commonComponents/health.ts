import ProgressBar from '../progressBar';
import { colors, Color, panels } from '../util';

type HealthData = {
    color: Color;
    fontSize?: string ;
    showValue?: boolean;
    usePercentage?: boolean;
    rounded?: boolean;
    maxTreshold?: number;
    shieldOnFront?: boolean;
}

export default class Health{
    healthProgressBar: ProgressBar;
    shieldProgressBar: ProgressBar;
    healthPanel: Panel;
    cellsPanel: Panel;
    cellsPanels: Panel[] = [];
    valuePanel: LabelPanel;
    color: Color;
    showValue: boolean;
    usePercentage: boolean;
    rounded: boolean;
    maxTreshold: number;
    borderRadius = '3';
    shieldOnFront: boolean;
    active = true;

    constructor(container: Panel, data: HealthData){
        const fontSize = (data.fontSize) ? data.fontSize : '13px';
        const showValue = (data.showValue) ? data.showValue : false;
        const usePercentage = (data.usePercentage) ? data.usePercentage : false;
        this.rounded = (data.rounded) ? data.rounded : false;
        this.maxTreshold = (data.maxTreshold) ? data.maxTreshold : 30;
        this.shieldOnFront = (data.shieldOnFront) ? data.shieldOnFront : false;

        this.color = data.color;
        this.showValue = showValue;
        this.usePercentage = usePercentage;

        this.healthPanel =  panels.createPanelSimple(container, 'health');
        this.cellsPanel = panels.createPanelSimple(container, 'health__cells');
        this.valuePanel = panels.createPanelSimple(container, 'health__value', 'Label') as LabelPanel;

        if(!this.shieldOnFront){
            this.healthPanel.style.flowChildren = 'right';
        }

        this.healthProgressBar = new ProgressBar('health__progress-bar', this.healthPanel, { 
            foreground_color: colors.Gradient(this.color), 
            delayed: true, 
            background_color: 'black',
            border_radius: (this.rounded) ? this.borderRadius + 'px' : '0',
        });
        this.shieldProgressBar = new ProgressBar('shield__progress-bar', this.healthPanel, { 
            foreground_color: colors.Gradient(colors.gray),
            background_color: 'black',
            border_radius: (this.rounded) ? this.borderRadius + 'px' : '0',
        });

        this.healthPanel.style.height = '100%';
        this.healthPanel.style.width = '100%';
        
        this.cellsPanel.style.flowChildren = 'right';
        this.cellsPanel.style.height = '100%';
        this.cellsPanel.style.width = '100%';
        this.cellsPanel.style.borderRadius = (this.rounded) ? this.borderRadius + 'px' : '0';

        if(this.showValue){
            this.valuePanel.style.align = 'center center';
            this.valuePanel.style.textShadow = '0px 0px 8px 7.0 #000000b0';
            this.valuePanel.style.color = '#FAFAFA';
            this.valuePanel.style.fontSize = fontSize;
            this.valuePanel.style.fontFamily = 'Radiance, FZLanTingHei-R-GBK, TH Sarabun New, Gulim,MingLiU';
        } else {
            this.valuePanel.style.visibility = 'collapse';
        }
    }

    Activate(): void {
        this.healthPanel.style.visibility = 'visible';
        this.active = true;
    }

    Deactivate(): void {
        this.healthPanel.style.visibility = 'collapse';
        this.active = false;
    }

    Update(health: number, treshold: number, maxHealth: number, shield: number): void{
        if(!this.active){
            return;
        }

        const healeableAmount = this.maxTreshold - treshold;
        const potentialHealth = health + (healeableAmount);
    
        let healthPanelWidth;
        let healthProgress;
        let healthTotalWidth;
        
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
            if(this.shieldOnFront){
                healthTotalWidth = 100;
                const shieldTotalWidth = 100 * (shield)/(maxHealth);
                this.shieldProgressBar.SetTotalWidth(shieldTotalWidth);
            } else {
                this.healthProgressBar.SetBorder({right: '0'});
                this.shieldProgressBar.SetBorder({left: '0'});

                if(this.rounded){
                    this.healthProgressBar.SetBorderRadius({topRight: '0', bottomRight: '0'});
                    this.shieldProgressBar.SetBorderRadius({topLeft: '0', bottomLeft: '0'});
                }
                healthTotalWidth = 100 * (health)/(maxHealth + shield);
                const shieldTotalWidth = 100 * (maxHealth + shield - health)/(maxHealth + shield);
                this.shieldProgressBar.SetTotalWidth(shieldTotalWidth);
            }

            this.shieldProgressBar.SetVisibility('visible');

            healthPanelWidth = 100;
            healthProgress = 100;

            const shieldProgress = 100 * shield/(shield + healeableAmount);
            const shieldPanelWidth = 100 * (shield + healeableAmount)/(maxHealth + shield - health);
            this.shieldProgressBar.SetProgress(shieldProgress);
            this.shieldProgressBar.SetPanelWidth(shieldPanelWidth);
        }
        this.healthProgressBar.SetTotalWidth(healthTotalWidth);
        this.healthProgressBar.SetPanelWidth(healthPanelWidth);
        this.healthProgressBar.SetProgress(healthProgress);

        if(this.showValue){
            let value = health.toString();

            if(this.usePercentage){
                value = Math.floor(100 * potentialHealth/maxHealth).toString() + '%';
            }
            this.valuePanel.text = value;
        }

        if(this.shieldOnFront){
            this.UpdateCellsShieldOnFront(health, maxHealth);
        } else {
            this.UpdateCells(health, healeableAmount, maxHealth, shield);
        }
    }

    UpdateCellsShieldOnFront(health: number, maxHealth: number): void{
        this.UpdateCells(health, health, maxHealth, 0);
    }

    UpdateCells(health: number, healeableAmount: number, maxHealth: number, shield: number): void{
        const potentialHealthPoints = health + shield + healeableAmount;
        const cellsTotalWidth = 100 * potentialHealthPoints/(maxHealth + shield);
        this.cellsPanel.style.width = cellsTotalWidth + '%';

        const rest = potentialHealthPoints % this.maxTreshold;
        const cells = Math.ceil(potentialHealthPoints/this.maxTreshold);

        while(this.cellsPanels.length < cells){
            this.AddCell();
        }

        while(this.cellsPanels.length > cells){
            this.RemoveCell();
        }

        this.cellsPanels.forEach((panel, i) => {
            let cellWidth = this.GetCellWidth(this.maxTreshold, potentialHealthPoints);
            if((i == this.cellsPanels.length - 1) && rest > 0){
                cellWidth = this.GetCellWidth(rest, potentialHealthPoints);
            }

            panel.style.width = cellWidth + '%';
        });
    }

    GetCellWidth(value: number, potentialHealthPoints: number): number{
        return (100 * value)/(potentialHealthPoints);
    }

    AddCell(): void{
        const index = this.cellsPanel.GetChildCount();
        const panel = panels.createPanelSimple(this.cellsPanel, 'cell_panel_' + index);

        panel.style.borderRight = '1px solid rgba(0, 0, 0, 0.6)';
        panel.style.height = '100%';

        this.cellsPanels.push(panel);
    }

    RemoveCell(): void{
        this.cellsPanels[this.cellsPanels.length - 1].DeleteAsync(0);
        this.cellsPanels.pop();
    }
}

