
import Alliance from '../alliance';
import GameState, { CustomGameState } from '../game_state';

const ADRENALINE_DURATION = 25.0;

export default class PreRound extends GameState{
    radiant_spawn: Vector;
    dire_spawn: Vector;
    
    constructor(alliances: Alliance[], duration: number){
        super(alliances, duration);
        this.radiant_spawn = Entities.FindByName(undefined, 'radiant_spawn')!.GetAbsOrigin();
        this.dire_spawn = Entities.FindByName(undefined, 'dire_spawn')!.GetAbsOrigin();

        this.GetAllPlayers().forEach((player) => {
            const hero = player.hero;
            if(hero){
                hero.AddNewModifier(hero, undefined, 'modifier_restricted', {});
            }
        });
    }

    Update(): void{
        super.Update();
        if(this.time_remaining >= 0){
            this.UpdateGameTimer(math.floor(this.time_remaining/30));
        }
        if(this.time_remaining == 0){
            this.EndPreRound();
        }
    }

    EndPreRound(): void{
        this.GetAllPlayers().forEach((player) => {
            const hero = player.hero;
            if(hero){
                if(player.alliance){
                    const allianceName = player.alliance.name;
                    let target = undefined;

                    if(allianceName == 'DOTA_ALLIANCE_RADIANT'){
                        target = this.radiant_spawn;
                    } else if(allianceName == 'DOTA_ALLIANCE_DIRE'){
                        target = this.dire_spawn;
                    }

                    FindClearSpaceForUnit(hero, target!, true);
                    CustomEntitiesLegacy.Reset(hero);
                    CustomEntitiesLegacy.AutoUpgradeAbilities(hero);
                    hero.RemoveModifierByName('modifier_restricted');
                    hero.AddNewModifier(hero, undefined, 'modifier_adrenaline', { duration: ADRENALINE_DURATION });
                }
            }
        });

        GameRules.Addon.SetState(CustomGameState.ROUND_IN_PROGRESS);
    }
}




