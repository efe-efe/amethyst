import GameState, { CustomGameState } from "../game_state";
// import { ModifierDeathZone } from "../../modifiers/modifier_death_zone";
import { ModifierProvidesVision } from "../../modifiers/modifier_provides_vision";
import { Alliance } from "../../alliances";

export default class Round extends GameState {
    death_zone: CBaseEntity | undefined;
    arrows: ParticleID[] = [];
    ended = false;
    timeOver = false;
    heroDied = false;
    isTryingToEnd = false;
    winner: Alliance | undefined = undefined;
    timeRemianingUntilEnd = Constants.drawTime;
    gemSpawnPoints: Vector[];
    healthEntities: CBaseEntity[];
    manaEntities: CBaseEntity[];
    shieldEntities: CBaseEntity[];
    radiantWarmupSpawn: CBaseEntity;
    direWarmupSpawn: CBaseEntity;

    constructor(alliances: Alliance[], duration: number) {
        super(alliances, duration);

        this.gemSpawnPoints = Entities.FindAllByName("orb_spawn").map(entity => entity.GetAbsOrigin());
        this.healthEntities = Entities.FindAllByName("health_orb");
        this.manaEntities = Entities.FindAllByName("mana_orb");
        this.shieldEntities = Entities.FindAllByName("shield_orb");
        this.radiantWarmupSpawn = Entities.FindByName(undefined, "radiant_warmup_spawn")!;
        this.direWarmupSpawn = Entities.FindByName(undefined, "dire_warmup_spawn")!;

        if (RandomInt(0, 1) === 1) {
            GameRules.SetTimeOfDay(0.0);
        } else {
            GameRules.SetTimeOfDay(0.5);
        }
    }

    Update(): void {
        super.Update();
        if (this.timeRemaining >= 0) {
            this.UpdateGameTimer(math.floor(this.timeRemaining / 30));
        }

        if (this.timeRemaining === 0 && !this.timeOver && !this.infinite) {
            this.timeOver = true;
            this.CreateDeathZone();
        }

        if (this.isTryingToEnd) {
            this.timeRemianingUntilEnd = this.timeRemianingUntilEnd - FrameTime();

            if (this.timeRemianingUntilEnd <= 0) {
                this.winner = this.GetCompetingAlliances()[0];
                this.EndRound();
            }
        }

        if (this.heroDied) {
            this.heroDied = false;

            if (this.CheckEndConditions()) {
                this.isTryingToEnd = true;
            }
        }
    }

    EndRound(): void {
        this.ended = true;

        this.DestroyDeathZone();

        this.GetAllPlayers().forEach(player => {
            const hero = player.entity?.handle;

            if (player.alliance && hero && hero.IsRealHero()) {
                let target = this.radiantWarmupSpawn;

                if (player.alliance.id == AllianceId.dire) {
                    target = this.direWarmupSpawn;
                }

                if (!hero.IsAlive()) {
                    hero.RespawnHero(false, false);
                }

                FindClearSpaceForUnit(hero, target.GetAbsOrigin(), true);
                CustomEntitiesLegacy.Reset(hero);
            }
        });

        let max_score = Constants.roundsDifferenceToWin;
        let allinaces_with_one_point = 0;
        let allinaces_with_two_points = 0;

        if (this.winner) {
            const new_score = this.winner.wins + 1;
            this.winner.wins = new_score;

            if (
                this.winner.wins >= Constants.roundsToWin ||
                this.GetHighestWinsDifference(this.winner) >= Constants.roundsDifferenceToWin
            ) {
                GameRules.Addon.EndGame(this.winner.teams[1]);
                return;
            }
        } else {
            CustomGameEventManager.Send_ServerToAllClients("custom_message", {
                text: "DRAW!"
            });
        }

        this.alliances.forEach(alliance => {
            if (alliance.wins === 1) {
                allinaces_with_one_point = allinaces_with_one_point + 1;
            } else if (alliance.wins > 1) {
                allinaces_with_one_point = allinaces_with_one_point + 1;
                allinaces_with_two_points = allinaces_with_two_points + 1;
            }
        });

        if (allinaces_with_two_points >= 2) {
            max_score = 5;
        } else if (allinaces_with_one_point >= 2) {
            max_score = 4;
        }

        CustomNetTables.SetTableValue("main", "maxScore", {
            max_score
        });
        GameRules.Addon.round = undefined;

        this.GetAllPlayers().forEach(player => {
            const hero = player.entity?.handle;
            const playerId = player.id;
            if (hero) {
                hero.RemoveModifierByName(ModifierProvidesVision.name);
            }
            PlayerResource.SetCameraTarget(playerId, undefined);
        });

        GameRules.Addon.SetState(CustomGameState.WARMUP_IN_PROGRESS);
    }

    GetHighestWinsDifference(alliance: Alliance): number {
        let difference = 0;

        this.alliances.forEach(_alliance => {
            if (_alliance !== alliance) {
                if (_alliance.active) {
                    const _difference = alliance.wins - _alliance.wins;

                    if (_difference > difference) {
                        difference = _difference;
                    }
                }
            }
        });

        return difference;
    }

    GetCompetingAlliances(): Alliance[] {
        const alliances: Alliance[] = [];

        this.GetAllPlayers().forEach(player => {
            const hero = player.entity?.handle;

            if (hero && !hero.IsNull() && hero.IsAlive() && player.alliance) {
                const playerAlliance = player.alliance;
                const alreadyAdded = alliances.filter(alliance => alliance.id === playerAlliance.id).length > 0;

                if (!alreadyAdded) {
                    alliances.push(playerAlliance);
                }
            }
        });

        return alliances;
    }

    CheckEndConditions(): boolean {
        return this.GetCompetingAlliances().length <= 1;
    }

    CreateDeathZone(): void {
        CustomGameEventManager.Send_ServerToAllClients("custom_message", {
            text: "Death Zone has initiated!"
        });
        // this.death_zone = ModifierDeathZone.createThinker(undefined, undefined, this.gemSpawnPoints[this.gem.index], {})[0];
    }

    DestroyDeathZone(): void {
        if (this.death_zone) {
            if (!this.death_zone.IsNull()) {
                this.death_zone.Destroy();
            }
        }
    }
}
