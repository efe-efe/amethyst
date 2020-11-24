import Alliances from './alliances';
import Health from './commonComponents/health';
import Mana from './commonComponents/mana';
import { Color, colors, panels } from './shared/util';
import { HeroData } from './types';

const alliances = Alliances.GetInstance();

export default class HeroInfoCard{
    containerPanel: Panel;
    leftPanel: Panel;
    rightPanel: Panel;
    
    leftTopPanel: Panel;
    leftMidPanel: Panel;
    leftBotPanel: Panel;

    healthPanel: Panel;
    manaPanel: Panel;

    health: Health;
    mana: Mana | undefined;
    color: Color;
    
    constructor(heroData: HeroData, alliancePanel: Panel){
        const alliance = alliances.findAllianceByTeam(heroData.teamId)!;

        this.color = colors[alliance.GetColor()];
        this.containerPanel = panels.createPanelSimple(alliancePanel, 'hero-info-card');

        this.leftPanel = panels.createPanelSimple(this.containerPanel, 'hero-info-card__left');
        this.rightPanel = panels.createPanelSimple(this.containerPanel, 'hero-info-card__right');

        this.leftTopPanel = panels.createPanelSimple(this.leftPanel, 'hero-info-card__top');
        this.leftMidPanel = panels.createPanelSimple(this.leftPanel, 'hero-info-card__mid');
        this.leftBotPanel = panels.createPanelSimple(this.leftPanel, 'hero-info-card__bot');

        if(heroData.allianceName == 'DOTA_ALLIANCE_DIRE'){
            this.containerPanel.SetHasClass('hero-info-card--right', true);
        }

        for(let i = 0; i < 9; i++){
            $.CreatePanelWithProperties('DOTAAbilityImage', this.rightPanel, 'hero-info-card__ability_' + i, {
                class: 'hero-info-card__ability',
            });
        }

        const imagePanel = panels.createPanelSimple(this.leftTopPanel, 'hero-info-card__image', 'DOTAHeroImage') as HeroImage;
        const resourcesPanel = panels.createPanelSimple(this.leftMidPanel, 'hero-info-card-resources');
        this.healthPanel = panels.createPanelSimple(resourcesPanel, 'hero-info-card-resources__health');
        this.manaPanel = panels.createPanelSimple(resourcesPanel, 'hero-info-card-resources__mana');

        
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

        this.UpdateAbilities(heroData.abilities);
    }

    private UpdateAbilities(abilities: {
            [key: string]: {
                name: string;
                level: number;
            }
        }): void{

        const upgradedAbilities = [];
        let iterator = 0;

        for(const index in abilities){
            const ability = abilities[index];
            
            if(ability.level >= 2){
                upgradedAbilities.push(ability);
            }
        }

        for(let i = 0; i < this.rightPanel.GetChildCount(); i++){
            const tmpPanel = this.rightPanel.GetChild(i) as AbilityImage;

            if(upgradedAbilities[iterator]){
                tmpPanel.style.width = '35px';
                tmpPanel.style.marginRight = '5px';
                tmpPanel.abilityname = upgradedAbilities[iterator].name;

                tmpPanel.SetPanelEvent('onmouseover', () => {
                    $.DispatchEvent( 'DOTAShowAbilityTooltipForEntityIndex',
                        tmpPanel, tmpPanel.abilityname, Players.GetLocalPlayerPortraitUnit()
                    );
                });

                tmpPanel.SetPanelEvent('onmouseout', () => {
                    $.DispatchEvent( 'DOTAHideAbilityTooltip',
                        tmpPanel
                    );
                });

                iterator ++;
            } else {
                tmpPanel.style.width = '0px';
                tmpPanel.style.marginRight = '0px';
            }
        }
    }
}