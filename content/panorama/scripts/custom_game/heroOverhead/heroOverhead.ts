import Overhead from '../shared/overhead/overhead';
import Recast from './recast';
import Status from './status';
import util, { Color, colors, panels } from '../shared/util';
import Player from './player';
import Charges from './charges';
import Cooldown from './cooldown';
import Stacks from './stacks';
import Health from '../commonComponents/health';
import Alliances from '../alliances';
import Castpoint from './castpoint';
import Mana from '../commonComponents/mana';
import { HeroData } from '../types';

enum StatusScope {
    STATUS_SCOPE_PUBLIC = 1,
    STATUS_SCOPE_LOCAL
}

const alliances = Alliances.GetInstance();

export default class HeroOverhead extends Overhead{
    topPanel: Panel;
    midPanel: Panel;
    botPanel: Panel;
    chargesPanel: Panel;
    healthPanel: Panel;
    manaPanel: Panel;
    castpointPanel: Panel;
    ammoPanel: Panel;
    stackbarsPanel: Panel;
    cooldownPanel: Panel;

    color: Color;
    
    midSwitchPanel: SwitchPanel;
    botSwitchPanel: SwitchPanel | undefined;

    recast: Recast;
    status: Status;
    health: Health;
    mana: Mana | undefined;
    castpoint: Castpoint;
    charges: Charges | undefined;
    cooldown: Cooldown | undefined;
    stacks: Stacks | undefined;

    isLocalPlayer: boolean;
    
    constructor(heroData: HeroData){
        super(heroData.entityIndex);
        const alliance = alliances.findAllianceByTeam(heroData.teamId)!;
        const localPlayerId = Game.GetLocalPlayerID();

        this.isLocalPlayer = localPlayerId == heroData.playerId;
        this.color = colors[alliance.GetColor()];
        this.topPanel = panels.createPanelSimple(this.containerPanel, 'hero-overhead__top');
        this.midPanel = panels.createPanelSimple(this.containerPanel, 'hero-overhead__mid');
        this.botPanel = panels.createPanelSimple(this.containerPanel, 'hero-overhead__bot');
        this.chargesPanel = panels.createPanelSimple(this.botPanel, 'hero-overhead-charges');
        const resourcesPanel = panels.createPanelSimple(this.botPanel, 'hero-overhead-resources');
        this.healthPanel = panels.createPanelSimple(resourcesPanel, 'hero-overhead-resources__health');
        this.manaPanel = panels.createPanelSimple(resourcesPanel, 'hero-overhead-resources__mana');
        this.castpointPanel = panels.createPanelSimple(resourcesPanel, 'hero-overhead-resources__castpoint');
        this.ammoPanel = panels.createPanelSimple(this.botPanel, 'hero-overhead-ammo');
        this.stackbarsPanel = panels.createPanelSimple(this.ammoPanel, 'hero-overhead-ammo__stackbars');
        this.cooldownPanel = panels.createPanelSimple(this.ammoPanel, 'hero-overhead-ammo__cooldown');

        if(alliance.IsLocal()){
            this.mana = new Mana(this.manaPanel, heroData.mana, heroData.maxMana);
        }
        
        this.recast = new Recast(this.topPanel);
        this.status = new Status(this.midPanel, heroData.entityIndex);
        const player = new Player(this.midPanel, heroData.playerId, this.color);
        this.health = new Health(this.healthPanel, this.color);
        this.castpoint = new Castpoint(this.castpointPanel, heroData.entityIndex);

        this.midSwitchPanel =  new SwitchPanel(player.GetPanel(), this.status.GetPanel());
        this.botSwitchPanel =  new SwitchPanel(this.cooldownPanel, this.stackbarsPanel);

        if(heroData.cooldown && this.isLocalPlayer){
            this.cooldown = new Cooldown(this.cooldownPanel, heroData.entityIndex, heroData.cooldown);
            this.botSwitchPanel.SetState(0);
        }
        if(heroData.stackbars && this.isLocalPlayer){
            this.stacks = new Stacks(this.ammoPanel, heroData.entityIndex, heroData.stackbars);
            this.botSwitchPanel.SetState(1);
        }
        if(heroData.charges && this.isLocalPlayer){
            this.charges = new Charges(this.chargesPanel, heroData.entityIndex, heroData.charges);
        }

        this.UpdateData(heroData);
    }

    public UpdateData(heroData: HeroData): void{
        if(!util.isEmptyObject(heroData.recast) && this.isLocalPlayer){
            const currentRecast = util.getFirstObjectElement(heroData.recast);
            this.recast.Activate(currentRecast.ability_name, currentRecast.key);
        } else {
            this.recast.Deactivate();
        }

        if(!util.isEmptyObject(heroData.status)){
            let currentStatus = undefined;

            for(const modifierName in heroData.status){
                const tempStatus = heroData.status[modifierName];
        
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
                this.status.Activate(
                    currentStatus.label,
                    currentStatus.style_name,
                    currentStatus.trigger,
                    currentStatus.modifier_name,
                    currentStatus.max_stacks
                );
                
                this.midSwitchPanel.SetState(1);
            }
        } else {
            this.status.Deactivate();
            this.midSwitchPanel.SetState(0);
        }

        this.health.Update(heroData.health, heroData.treshold, heroData.maxHealth, heroData.shield);
        if(this.mana){
            this.mana.Update(heroData.mana, heroData.maxMana);
        }
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