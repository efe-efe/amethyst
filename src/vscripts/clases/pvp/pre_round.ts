import { CustomModifier } from "../../abilities/framework/custom_modifier";
import { registerModifier } from "../../lib/dota_ts_adapter";
import { ModifierAdrenaline } from "../../modifiers/modifier_adrenaline";
import Alliance from "../alliance";
import GameState, { CustomGameState } from "../game_state";

const ADRENALINE_DURATION = 25.0;

@registerModifier({ customNameForI18n: "modifier_restricted" })
class ModifierRestricted extends CustomModifier<undefined> {
    IsHidden() {
        return true;
    }

    IsDebuff() {
        return false;
    }

    IsPurgable() {
        return false;
    }

    RemoveOnDeath() {
        return false;
    }

    CheckState() {
        return {
            [ModifierState.COMMAND_RESTRICTED]: true
        };
    }
}

export default class PreRound extends GameState {
    radiant_spawn: Vector;
    dire_spawn: Vector;

    constructor(alliances: Alliance[], duration: number) {
        super(alliances, duration);
        this.radiant_spawn = Entities.FindByName(undefined, "radiant_spawn")!.GetAbsOrigin();
        this.dire_spawn = Entities.FindByName(undefined, "dire_spawn")!.GetAbsOrigin();

        this.GetAllPlayers().forEach(player => {
            const hero = player.hero;
            if (hero) {
                ModifierRestricted.apply(hero, hero, undefined, {});
            }
        });
    }

    Update(): void {
        super.Update();
        if (this.timeRemaining >= 0) {
            this.UpdateGameTimer(math.floor(this.timeRemaining / 30));
        }
        if (this.timeRemaining == 0) {
            this.EndPreRound();
        }
    }

    EndPreRound(): void {
        this.GetAllPlayers().forEach(player => {
            const hero = player.hero;
            if (hero) {
                if (player.alliance) {
                    const allianceName = player.alliance.name;
                    let target = undefined;

                    if (allianceName == "DOTA_ALLIANCE_RADIANT") {
                        target = this.radiant_spawn;
                    } else if (allianceName == "DOTA_ALLIANCE_DIRE") {
                        target = this.dire_spawn;
                    }

                    FindClearSpaceForUnit(hero, target!, true);
                    CustomEntitiesLegacy.Reset(hero);
                    CustomEntitiesLegacy.AutoUpgradeAbilities(hero);
                    hero.RemoveModifierByName("modifier_restricted");
                    ModifierAdrenaline.apply(hero, hero, undefined, {
                        duration: ADRENALINE_DURATION
                    });
                }
            }
        });

        GameRules.Addon.SetState(CustomGameState.ROUND_IN_PROGRESS);
    }
}
