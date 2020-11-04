import Alliances from './alliances';
import Health from './commonComponents/health';
import { Color, colors, panels } from './shared/util';
import { AllianceData } from './types';

const alliances = Alliances.GetInstance();
const ROUNDS_TO_WIN = 5;
const ROUNDS_DIFFERENCE_TO_WIN = 3;

export default class AllianceBar{
    panel: Panel;
    healthPanel: Panel;
    bottomPanel: Panel;
    scorePointsPanel: Panel;
    amethystsTextPanel: LabelPanel;
    modifier: BuffID | undefined;

    health: Health;
    color: Color;

    constructor(container: Panel, allianceData: AllianceData){
        const alliance = alliances.findAllianceByName(allianceData.name)!;
        this.color = colors[alliance.GetColor()];

        this.panel = panels.createPanelSimple(container, 'alliance-bar');
        this.healthPanel = panels.createPanelSimple(this.panel, 'alliance-bar__health');
        this.bottomPanel = panels.createPanelSimple(this.panel, 'alliance-bar__bottom');

        const amethystsPanel = panels.createPanelSimple(this.bottomPanel, 'alliance-bar__amethysts');
        const scoreContainerPanel = panels.createPanelSimple(this.bottomPanel, 'alliance-bar__score-container');
        
        
        const amethystsImageContainerPanel = panels.createPanelSimple(amethystsPanel, 'alliance-bar__amethysts-image-container');
        const amethystsImagePanel = panels.createPanelSimple(amethystsImageContainerPanel, 'alliance-bar__amethysts-image', 'Image') as ImagePanel;
        this.amethystsTextPanel = panels.createPanelSimple(amethystsPanel, 'alliance-bar__amethysts-text', 'Label') as LabelPanel;

        this.scorePointsPanel = panels.createPanelSimple(scoreContainerPanel, 'alliance-bar__score-points');

        for(let i = 0; i < ROUNDS_TO_WIN; i++){
            const pointPanel = panels.createPanelSimple(this.scorePointsPanel, 'alliance-bar__score-point');
            pointPanel.SetHasClass('alliance-bar__score-point--disabled', true);
            pointPanel.style.backgroundColor = colors.Gradient(this.color);
        }
        
        amethystsImagePanel.SetImage('file://{images}/custom_game/amethyst.png');
        this.amethystsTextPanel.text = 'X0';

        this.health = new Health(this.healthPanel, this.color, '15px', true, true);
        this.UpdateData(allianceData);
    }

    public UpdateData(allianceData: AllianceData): void{
        this.UpdateAmethysts(allianceData.amethysts);
        this.health.Update(allianceData.health, 30, allianceData.max_health, allianceData.shield);

        for(let i = 0; i < ROUNDS_DIFFERENCE_TO_WIN; i++){
            this.scorePointsPanel.GetChild(i)!.SetHasClass('alliance-bar__score-point--disabled', false);
            this.scorePointsPanel.GetChild(i)!.SetHasClass('alliance-bar__score-point--inactive', true);
        }
        

        for(let i = 0; i < allianceData.score ; i++){
            this.scorePointsPanel.GetChild(i)!.SetHasClass('alliance-bar__score-point--inactive', false);
            this.scorePointsPanel.GetChild(i)!.SetHasClass('alliance-bar__score-point--active', true);
        }
    }

    UpdateAmethysts(amount: number): void{
        this.amethystsTextPanel.text = 'X' + amount.toString();
    }
}