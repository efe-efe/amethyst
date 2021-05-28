import settings from '../../settings';
import Alliance from '../alliance';
import GameState, { CustomGameState } from '../game_state';

export default class PreRun extends GameState{
    constructor(alliances: Alliance[], duration: number){
        super(alliances, duration);
    }

    Update(): void{
        super.Update();
        if(this.time_remaining >= 0){
            this.UpdateGameTimer(math.floor(this.time_remaining/30));
        }
        if(this.time_remaining == 0){
            this.End();
        }
    }

    OnAbilityLearned(): void{
        let abilitiesReady = true;
        this.GetAllPlayers().forEach((player) => {
            const hero = player.hero;
            if(hero){
                if(hero.GetAbilityPoints() > 0){
                    abilitiesReady = false;
                }
            }
        });
        
        if(abilitiesReady){
            this.SetDuration(settings.PreStageDuration);
        }
    }

    End(): void{
        GameRules.Addon.SetState(CustomGameState.RUN_IN_PROGRESS);
    }
}