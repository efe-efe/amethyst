
import Alliance from "../alliance";
import GameState, { CustomGameState } from "../game_state";
import GemWrapper, { GemTypes } from "../gem";
import Pickup, { PickupTypes } from "../pickup";
import settings from "../../settings";

interface PickupWrapper {
    origin: Vector;
    type: PickupTypes;
    timer: number;
    entity: Pickup | undefined,
}

interface Gem {
    index: number;
    type: number;
    entity: undefined | GemWrapper;
    number: number,
}

export default class Round extends GameState{
    death_zone: CBaseEntity | undefined;
    pickupWrappers: PickupWrapper[] = [];
    arrows: ParticleID[] = [];
    ended = false;
    timeOver = false;
    heroDied = false;
    isTryingToEnd = false;
    winner: Alliance | undefined = undefined;
    timeRemianingUntilEnd = settings.DrawTime;
    gemSpawnPoints: Vector[];
    healthEntities: CBaseEntity[];
    manaEntities: CBaseEntity[];
    shieldEntities: CBaseEntity[];
    radiantWarmupSpawn: CBaseEntity;
    direWarmupSpawn: CBaseEntity;
    gem: Gem;

    constructor(alliances: Alliance[], duration: number){
        super(alliances, duration);

        this.gemSpawnPoints = Entities.FindAllByName("orb_spawn").map((entity) => entity.GetAbsOrigin());
        this.healthEntities = Entities.FindAllByName("health_orb");
        this.manaEntities = Entities.FindAllByName("mana_orb");
        this.shieldEntities = Entities.FindAllByName("shield_orb");
        this.radiantWarmupSpawn = Entities.FindByName(undefined, "radiant_warmup_spawn")!;
        this.direWarmupSpawn = Entities.FindByName(undefined, "dire_warmup_spawn")!;

        this.AddPickups(this.healthEntities, PickupTypes.HEALTH);
        this.AddPickups(this.manaEntities, PickupTypes.MANA);
        this.AddPickups(this.shieldEntities, PickupTypes.SHIELD);

        this.gem = {
            index: RandomInt(0, 2),
            type: RandomInt(GemTypes.AMETHYST, GemTypes.EMERALD),
            entity: undefined,
            number: 0,
        };

        if(RandomInt(0, 1) === 1){
            GameRules.SetTimeOfDay(0.0);
        } else{
            GameRules.SetTimeOfDay(0.5);
        }
    }

    AddPickups(spawnEntities: CBaseEntity[], type: PickupTypes): void{
        spawnEntities.forEach((entity) => {
            this.pickupWrappers.push({
                origin: entity.GetAbsOrigin(),
                type: type,
                timer: settings.PickupsCreationTime * 30,
                entity: undefined,
            });
        });
    }

    SpawnArrows(): void{
        if(this.gem.entity){
            const color = this.gem.entity.GetColor();

            this.gemSpawnPoints.forEach((point, i) => {
                if(i !== this.gem.index){ 
                    const direction = (this.gemSpawnPoints[this.gem.index].__sub(point)).Normalized();
                    const efx = ParticleManager.CreateParticle("particles/gem_finder.vpcf", ParticleAttachment.WORLDORIGIN, undefined);
                    ParticleManager.SetParticleControl(efx, 0, point);
                    ParticleManager.SetParticleControl(efx, 2, point.__add(direction.__mul(Vector(128, 128, 0))));
                    ParticleManager.SetParticleControl(efx, 60, color);
                    ParticleManager.SetParticleControl(efx, 61, Vector(1, 0, 0));
                    this.arrows.push(efx); 
                }
            });
        }
    }

    Update(): void{
        super.Update();
        if(this.timeRemaining >= 0){
            this.UpdateGameTimer(math.floor(this.timeRemaining/30));
        }

        if(this.timeRemaining === 0 && !this.timeOver){
            if(this.maxDuration !== -1){
                this.timeOver = true;
                this.CreateDeathZone();
            }
        }

        if(!this.ended){
            if(!this.gem.entity){
                this.CreateGemAndArrows();
            } else {
                if(!this.gem.entity.Alive()){
                    this.gem.entity = undefined;
                    this.CleanArrows();
                } else {
                    this.gem.entity.Update();
                }
            }

            this.pickupWrappers.forEach((pickup) => {
                if(pickup.timer !== -1){
                    if(!pickup.entity){
                        if(pickup.timer === 0){
                            pickup.entity = new Pickup(pickup.type, pickup.origin, undefined);
                        } else { 
                            pickup.timer = pickup.timer - 1;
                        }
                    } else {
                        if(!pickup.entity.Alive()){
                            pickup.timer = settings.PickupsCreationTime * 30;
                            pickup.entity = undefined;
                        }
                    }
                }
            });
        } else {
            return;
        }

        if(this.isTryingToEnd){
            this.timeRemianingUntilEnd = this.timeRemianingUntilEnd - FrameTime();

            if(this.timeRemianingUntilEnd <= 0){
                this.winner = this.GetCompetingAlliances()[0];
                this.EndRound();
            }
        }

        if(this.heroDied){
            this.heroDied = false;

            if(this.CheckEndConditions()){
                this.isTryingToEnd = true;
            }
        }
    }

    CreateGem(): void{
        this.gem.type = RandomIntWithExeption(GemTypes.AMETHYST, GemTypes.EMERALD, this.gem.type);
        if(!this.timeOver){
            this.gem.index = RandomIntWithExeption(0, this.gemSpawnPoints.length - 1, this.gem.index);
        }
        const time = (this.gem.number === 0) ? settings.GemSpawnTime : settings.GemRespawnTime;
        const origin = this.gemSpawnPoints[this.gem.index];
        this.gem.number = this.gem.number + 1;
        this.gem.entity = new GemWrapper(time, origin, this.gem.type);
    }

    CleanArrows(): void{
        this.arrows.forEach((arrow) => {
            ParticleManager.DestroyParticle(arrow, false);
            ParticleManager.ReleaseParticleIndex(arrow);
        });

        this.arrows = [];
    }
    
    CreateGemAndArrows(): void{
        this.CreateGem();
        this.SpawnArrows();
    }

    DestroyGem(): void{
        if(this.gem.entity){
            this.gem.entity.Destroy(true);
            this.gem.entity = undefined;
        } 
    }
    
    EndRound(): void{  
        this.ended = true;

        this.DestroyAllPickups();
        this.DestroyDeathZone();
        this.DestroyGem();
        this.CleanArrows();

        this.GetAllPlayers().forEach((player) => {
            if(player.alliance && player.hero){
                let target = this.radiantWarmupSpawn;

                if(player.alliance.name == "DOTA_ALLIANCE_DIRE"){
                    target = this.direWarmupSpawn;
                }

                if(!player.hero.IsAlive()){
                    player.hero.RespawnHero(false, false);
                }

                FindClearSpaceForUnit(player.hero, target.GetAbsOrigin(), true);
                CustomEntitiesLegacy.Reset(player.hero);
            }
        });

        let max_score = settings.RoundsDifferenceToWin;
        let allinaces_with_one_point = 0;
        let allinaces_with_two_points = 0;

        this.DestroyAllPickups();//Remove death orbs

        if(this.winner){
            const new_score = this.winner.GetScore() + 1;
            this.winner.SetScore(new_score);

            if(this.winner.GetScore() >= settings.RoundsToWin || this.GetHighestWinsDifference(this.winner) >= settings.RoundsDifferenceToWin){
                GameRules.Addon.EndGame(this.winner.teams[1]);
                return;
            }
        } else {
            CustomGameEventManager.Send_ServerToAllClients("custom_message", { text: "DRAW!" } as never);
        }

        this.alliances.forEach((alliance) => {
            if(alliance.GetScore() === 1){
                allinaces_with_one_point = allinaces_with_one_point + 1;
            } else if(alliance.GetScore() > 1){
                allinaces_with_one_point = allinaces_with_one_point + 1;
                allinaces_with_two_points = allinaces_with_two_points + 1;
            }
        });

        if(allinaces_with_two_points >= 2){
            max_score = 5;
        } else if(allinaces_with_one_point >= 2){
            max_score = 4;
        }

        const tableName = "main" as never;
        CustomNetTables.SetTableValue(tableName, "maxScore", { max_score } as never);
        GameRules.Addon.round = undefined;

        this.GetAllPlayers().forEach((player) => {
            const hero = player.hero;
            const playerId = player.GetId();
            if(hero){
                CustomEntitiesLegacy.SafeDestroyModifier(hero, "modifier_generic_provides_vision");
            }
            PlayerResource.SetCameraTarget(playerId, undefined);
        });

        GameRules.Addon.SetState(CustomGameState.WARMUP_IN_PROGRESS);
    }

    GetHighestWinsDifference(alliance: Alliance): number{
        let difference = 0;

        this.alliances.forEach((_alliance) => {
            if(_alliance !== alliance){
                if(_alliance.IsActive()){
                    const _difference = alliance.wins - _alliance.wins;

                    if(_difference > difference){
                        difference = _difference;
                    }
                }
            }
        });

        return difference;
    }

    GetCompetingAlliances(): Alliance[]{
        const alliances: Alliance[] = [];

        this.GetAllPlayers().forEach((player) => {
            if(player.hero && !player.hero.IsNull() && player.hero.IsAlive() && player.alliance){
                const playerAlliance = player.alliance;
                const alreadyAdded = alliances.filter(alliance => alliance.name === playerAlliance.name).length > 0;
                
                if(!alreadyAdded){
                    alliances.push(playerAlliance);
                }
            }
        });

        return alliances;
    }

    CheckEndConditions(): boolean{
        return this.GetCompetingAlliances().length <= 1;
    }

    CreateDeathZone(): void{
        const tableName = "custom_message" as never;
        CustomGameEventManager.Send_ServerToAllClients(tableName, { text: "Death Zone has initiated!" } as never);
        this.death_zone = CreateModifierThinker(
            undefined,
            undefined,
            "modifier_death_zone",
            {},
            this.gemSpawnPoints[this.gem.index],
            DotaTeam.NOTEAM,
            false
        ) as CBaseEntity; 
    }

    DestroyDeathZone(): void{
        if(this.death_zone){
            if(!this.death_zone.IsNull()){
                this.death_zone.Destroy();
            }
        }
    }

    DestroyAllPickups(): void{
        this.pickupWrappers.forEach((pickup) => {
            if(pickup.entity){
                pickup.entity.Destroy();
            }
        });
        this.pickupWrappers = [];
    }
}
