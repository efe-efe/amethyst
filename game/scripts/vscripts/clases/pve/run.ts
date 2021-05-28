import Alliance from '../alliance';
import GameState, { CustomGameState } from '../game_state';
import Stage, { StageData } from './stage';

enum RunStates {
    ROOM = 0,
}

export default class Run extends GameState{
    alliances: Alliance[];
    stagesData: StageData[];
    stage: Stage | undefined;
    currentStage = 0;

    constructor(alliances: Alliance[], stagesData: StageData[]){
        super(alliances, -1);
        this.alliances = alliances;
        this.stagesData = stagesData;
    }

    Update(): void{
        super.Update();
        if(this.stage){
            this.stage.Update();
        } else {
            if(this.stagesData[this.currentStage]){
                this.stage = this.GenerateStage(this.stagesData[this.currentStage]);
            } else {
                this.End();
            }
        }
    }

    GenerateStage(stageData: StageData): Stage{
        return new Stage(this.alliances, stageData, this);
    }

    OnUnitHurt(unit: CDOTA_BaseNPC): void{
        if(this.stage){
            this.stage.OnUnitHurt(unit);
        }
    }

    OnUnitDies(unit: CDOTA_BaseNPC): void{
        if(this.stage){
            this.stage.OnUnitDies(unit);
        }
    }

    OnHeroUpgrade(): void{
        if(this.stage){
            this.stage.OnHeroUpgrade();
        }
    }

    OnStageEnd(): void{
        this.currentStage++;
        this.stage = undefined;
    }

    End(): void{
        GameRules.Addon.SetState(CustomGameState.POST_RUN);
    }
}

