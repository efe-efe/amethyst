import settings from '../settings';
import Alliance from './alliance';
import GameState, { CustomGameState } from './game_state';


export default class PreLevel extends GameState{
    constructor(alliances: Alliance[], duration: number){
        super(alliances, duration);

        const abilitiesReady = this.CheckAbilitiesReady();
        if(abilitiesReady){
            this.GetAllPlayers().forEach((player) => {
                const customNpc = player.customNpc;
                if(customNpc){
                    customNpc.RequestUpgrades();
                }
            });
        }
    }

    Update(): void{
        super.Update();
        if(this.time_remaining >= 0){
            this.UpdateGameTimer(math.floor(this.time_remaining/30));
        }
        if(this.time_remaining == 0){
            this.EndPreLevel();
        }
    }

    CheckAbilitiesReady(): boolean{
        let abilitiesReady = true;
        this.GetAllPlayers().forEach((player) => {
            const hero = player.hero;
            if(hero){
                if(hero.GetAbilityPoints() > 0){
                    abilitiesReady = false;
                }
            }
        });
        return abilitiesReady;
    }

    CheckUpgradesaReady(): boolean{
        let upgradesReady = true;
        this.GetAllPlayers().forEach((player) => {
            const customNpc = player.customNpc;
            if(customNpc){
                if(customNpc.IsUpgrading()){
                    upgradesReady = false;
                }
            }
        });
        return upgradesReady;
    }

    OnAbilityLearned(): void{
        const abilitiesReady = this.CheckAbilitiesReady();
        if(abilitiesReady){
            this.GetAllPlayers().forEach((player) => {
                const customNpc = player.customNpc;
                if(customNpc){
                    customNpc.RequestUpgrades();
                }
            });
        }
    }

    OnHeroUpgrade(): void{
        const upgradesReady = this.CheckAbilitiesReady();
        
        if(upgradesReady){
            this.SetDuration(settings.PreLevelDuration);
        }
    }

    EndPreLevel(): void{
        GameRules.Addon.SetState(CustomGameState.LEVEL_IN_PROGRESS);
    }
}