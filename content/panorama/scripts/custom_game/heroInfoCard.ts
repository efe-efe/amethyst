import Alliances from './alliances';
import Health from './commonComponents/health';
import Mana from './commonComponents/mana';
import { Color, colors, panels } from './shared/util';
import { HeroData } from './types';

const alliances = Alliances.GetInstance();

export default class HeroInfoCard{
    containerPanel: Panel;
    topPanel: Panel;
    midPanel: Panel;
    botPanel: Panel;

    healthPanel: Panel;
    manaPanel: Panel;

    health: Health;
    mana: Mana | undefined;
    color: Color;
    
    constructor(heroData: HeroData, alliancePanel: Panel){
        const alliance = alliances.findAllianceByTeam(heroData.teamId)!;

        this.color = colors[alliance.GetColor()];
        this.containerPanel = panels.createPanelSimple(alliancePanel, 'hero-status');
        this.topPanel = panels.createPanelSimple(this.containerPanel, 'hero-status__top');
        this.midPanel = panels.createPanelSimple(this.containerPanel, 'hero-status__mid');
        this.botPanel = panels.createPanelSimple(this.containerPanel, 'hero-status__bot');

        const imagePanel = panels.createPanelSimple(this.topPanel, 'hero-status__image', 'DOTAHeroImage') as HeroImage;
        const resourcesPanel = panels.createPanelSimple(this.midPanel, 'hero-status-resources');
        this.healthPanel = panels.createPanelSimple(resourcesPanel, 'hero-status-resources__health');
        this.manaPanel = panels.createPanelSimple(resourcesPanel, 'hero-status-resources__mana');


        if(alliance.IsLocal()){
            this.mana = new Mana(this.manaPanel, heroData.mana, heroData.maxMana);
        }

        this.health = new Health(this.healthPanel, this.color, '13px', true);
        imagePanel.heroname = heroData.name;

        this.UpdateData(heroData);
    }

    public UpdateData(heroData: HeroData): void{
        this.health.Update(heroData.health, heroData.treshold, heroData.maxHealth, heroData.shield);
        if(this.mana){
            this.mana.Update(heroData.mana, heroData.maxMana);
        }
    }
}