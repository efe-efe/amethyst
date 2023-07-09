import { Alliance } from "../../alliances";
import settings from "../../settings";
import GameState, { CustomGameState } from "../game_state";

export default class PreRun extends GameState {
    constructor(alliances: Alliance[], duration: number) {
        super(alliances, duration);
        //ListenToGameEvent('dota_player_learned_ability', () => this.OnLearnedAbilityEvent(), undefined);
        this.SetDuration(settings.PreStageDuration);
    }

    Update(): void {
        super.Update();
        if (this.timeRemaining >= 0) {
            this.UpdateGameTimer(math.floor(this.timeRemaining / 30));
        }
        if (this.timeRemaining == 0) {
            this.End();
        }
    }

    OnLearnedAbilityEvent(): void {
        let abilitiesReady = true;
        this.GetAllPlayers().forEach(player => {
            const hero = player.entity?.handle;
            if (hero && hero.IsRealHero()) {
                if (hero.GetAbilityPoints() > 0) {
                    abilitiesReady = false;
                }
            }
        });

        if (abilitiesReady) {
            this.SetDuration(settings.PreStageDuration);
        }
    }

    End(): void {
        GameRules.Addon.SetState(CustomGameState.RUN_IN_PROGRESS);
    }
}
