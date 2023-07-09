import { Alliance } from "../../alliances";
import Rewards from "../../rewards/rewards";
import GameState, { CustomGameState } from "../game_state";
import Stage, { StageData } from "./stage";

enum RunStates {
    ROOM = 0
}

export default class Run extends GameState {
    alliances: Alliance[];
    stagesData: StageData[];
    stage: Stage | undefined;
    currentStage = 0;

    constructor(alliances: Alliance[], stagesData: StageData[]) {
        super(alliances, -1);
        this.alliances = alliances;
        this.stagesData = stagesData;
        this.SendDataToClient();

        this.GetAllPlayers().forEach(player => {
            const customNpc = player.customNpc;
            if (customNpc) {
                customNpc.SelectReward(Rewards[0]);
            }
        });
    }

    SendDataToClient(): void {
        CustomNetTables.SetTableValue("main", "pve", {
            currentStage: this.currentStage + 1
        });
    }

    Update(): void {
        super.Update();
        if (this.stage) {
            this.stage.Update();
        } else {
            if (this.stagesData[this.currentStage]) {
                this.stage = this.GenerateStage(this.stagesData[this.currentStage]);
            } else {
                this.End();
            }
        }
    }

    GenerateStage(stageData: StageData): Stage {
        return new Stage(this.alliances, stageData, this);
    }

    OnStageEnd(): void {
        this.currentStage++;
        this.stage = undefined;
        this.SendDataToClient();
    }

    End(): void {
        GameRules.Addon.SetState(CustomGameState.POST_RUN);
    }
}
