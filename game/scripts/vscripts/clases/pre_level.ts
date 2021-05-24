import settings from '../settings';
import Alliance from './alliance';
import GameState, { CustomGameState } from './game_state';


export default class PreLevel extends GameState{
    ready = false;

    constructor(alliances: Alliance[], duration: number){
        super(alliances, duration);
    }

    Update(): void{
        super.Update();
        if(this.time_remaining >= 0){
            this.UpdateGameTimer(math.floor(this.time_remaining/30));
        }
        if(this.time_remaining == 0){
            this.EndPreLevel();
        }

        if(this.ready && this.time_remaining < 0){
            this.GetAllPlayers().forEach((player) => {
                const customNpc = player.customNpc;
                if(customNpc){
                    customNpc.RequestUpgrades();
                }
            });
            this.SetDuration(settings.PreLevelDuration);
        }
    }

    OnAbilityLearned(): void{
        let ready = true;
        this.GetAllPlayers().forEach((player) => {
            const hero = player.hero;
            if(hero){
                if(hero.GetAbilityPoints() > 0){
                    ready = false;
                }
            }
        });

        this.ready = ready;
    }

    EndPreLevel(): void{
        GameRules.Addon.SetState(CustomGameState.LEVEL_IN_PROGRESS);
    }
}