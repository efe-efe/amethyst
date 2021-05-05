import Alliance from './alliance';
import GameState, { CustomGameState } from './game_state';


export default class PreWave extends GameState{
    constructor(alliances: Alliance[], duration: number){
        super(alliances, duration);
    }

    Update(): void{
        super.Update();
        if(this.time_remaining >= 0){
            this.UpdateGameTimer(math.floor(this.time_remaining/30));
        }
        if(this.time_remaining == 0){
            this.EndWave();
        }
    }

    EndWave(): void{
        GameRules.Addon.SetState(CustomGameState.WAVE_IN_PROGRESS);
    }
}