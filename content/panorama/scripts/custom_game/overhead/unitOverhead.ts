import Overhead from './overhead';
import Status from './status';
import util, { Color, colors, panels } from '../util';
import Health from '../commonComponents/health';
import { UnitData } from '../types';

enum StatusScope {
    STATUS_SCOPE_PUBLIC = 1,
    STATUS_SCOPE_LOCAL
}

export default class UnitOverhead extends Overhead{
    topPanel: Panel;
    midPanel: Panel;
    botPanel: Panel;
    healthPanel: Panel;
    color: Color;
    
    botSwitchPanel: SwitchPanel | undefined;

    status: Status;
    health: Health;
    isLocalPlayer: boolean;
    
    constructor(unitData: UnitData){
        super(unitData.entityIndex);
        const localPlayerId = Game.GetLocalPlayerID();

        this.isLocalPlayer = localPlayerId == unitData.playerId;
        this.color = colors.orange;
        this.topPanel = panels.createPanelSimple(this.containerPanel, 'unit-overhead__top');
        this.midPanel = panels.createPanelSimple(this.containerPanel, 'unit-overhead__mid');
        this.botPanel = panels.createPanelSimple(this.containerPanel, 'unit-overhead__bot');
        const resourcesPanel = panels.createPanelSimple(this.botPanel, 'unit-overhead-resources');
        this.healthPanel = panels.createPanelSimple(resourcesPanel, 'unit-overhead-resources__health');
        
        this.status = new Status(this.midPanel, unitData.entityIndex);
        this.health = new Health(this.healthPanel, {
            color: this.color,
            rounded: true,
        });
        this.UpdateData(unitData);
    }

    public UpdateData(unitData: UnitData): void{
        if(!util.isEmptyObject(unitData.status)){
            let currentStatus = undefined;

            for(const modifierName in unitData.status){
                const tempStatus = unitData.status[modifierName];
        
                if(!currentStatus || (tempStatus.priority > currentStatus.priority)){
                    if(tempStatus.scope == StatusScope.STATUS_SCOPE_LOCAL){
                        if(this.isLocalPlayer){
                            currentStatus = tempStatus;
                        }
                    } else {
                        currentStatus = tempStatus;
                    }
                }
            }

            if(currentStatus){
                this.status.GetPanel().style.visibility = 'visible';
                this.status.Activate(
                    currentStatus.label,
                    currentStatus.style_name,
                    currentStatus.trigger,
                    currentStatus.modifier_name,
                    currentStatus.max_stacks,
                    currentStatus.content,
                );
            } else {
                this.status.Deactivate();
                this.status.GetPanel().style.visibility = 'collapse';
            }
        } else {
            this.status.Deactivate();
            this.status.GetPanel().style.visibility = 'collapse';
        }

        this.health.Update(unitData.health, 30, unitData.maxHealth, unitData.shield);
    }
}

class SwitchPanel{
    childrens: Panel[] = [];
    state: 0 | 1 | -1 = 1;

    constructor(firstPanel: Panel, secondPanel: Panel){
        this.AddPanel(firstPanel);
        this.AddPanel(secondPanel);
        this.Switch();
    }

    ShutDownBoth(): void{
        this.childrens[0].style.visibility = 'collapse';
        this.childrens[1].style.visibility = 'collapse';
        this.state = -1;
    }

    Switch(): void{
        if(this.state == 0){
            this.childrens[0].style.visibility = 'collapse';
            this.childrens[1].style.visibility = 'visible';
            this.state = 1;
        } else {
            this.childrens[1].style.visibility = 'collapse';
            this.childrens[0].style.visibility = 'visible';
            this.state = 0;
        }
    }

    SetState(state: 0 | 1): void{
        if(this.state != state){
            this.Switch();
        }
    }

    AddPanel(panel: Panel): void{
        this.childrens.push(panel);
    }
}