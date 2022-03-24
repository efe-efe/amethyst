import Alliance from "../alliance";
import DummyTarget from "../dummy_target";
import GameState, { CustomGameState } from "../game_state";

const DUMMY_TARGET_RESPAWN = 5.0;

interface DummyTargetData {
    origin: Vector;
    timer: number;
    entity: DummyTarget | undefined;
}

export default class Warmup extends GameState{
    dummyTargets: DummyTargetData[] = [];

    constructor(alliances: Alliance[], duration: number){
        super(alliances, duration);
        const dummyTargetsEnts = Entities.FindAllByName("dummy_target");
        
        dummyTargetsEnts.forEach((entity) => {
            this.dummyTargets.push({
                origin: entity.GetAbsOrigin(),
                timer: 0,
                entity: new DummyTarget(entity.GetAbsOrigin()),
            });
        });
    }

    Update(): void{
        super.Update();
        if(this.timeRemaining > 0){
            this.UpdateGameTimer(math.floor(this.timeRemaining/30));

            if(this.timeRemaining <= 30 && this.timeRemaining > 0){
                const data = { text: tostring(this.timeRemaining/30) } as never;
                CustomGameEventManager.Send_ServerToAllClients("custom_message", data);
            }

            this.dummyTargets.forEach((dummyTarget) => {
                if(!dummyTarget.entity){
                    dummyTarget.timer = dummyTarget.timer - 1;
                    if(dummyTarget.timer <= 0){
                        dummyTarget.entity = new DummyTarget(dummyTarget.origin);
                    }
                } else {
                    if(!dummyTarget.entity.Alive()){
                        dummyTarget.timer = DUMMY_TARGET_RESPAWN * 30;
                        dummyTarget.entity = undefined;
                    }
                }
            });
        } else {
            if(this.maxDuration != -1){
                this.EndWarmup();
            }
        }
    }

    EndWarmup(): void{
        this.DestroyAllDummyTargets();

        this.alliances.forEach((alliance) => {
            alliance.SetAmethysts(0);
        });

        GameRules.Addon.SetState(CustomGameState.PRE_ROUND);
    }
    
    DestroyAllDummyTargets(): void{
        this.dummyTargets.forEach((dummyTarget) => {
            
            if(dummyTarget.entity){
                dummyTarget.entity.Destroy(true);
            }
        });
    }
}
