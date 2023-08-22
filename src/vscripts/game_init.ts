import "./abilities_meta";
import "./alliances";
import { CustomGameState } from "./clases/game_state";
import Warmup from "./clases/pvp/warmup";
import { reloadable } from "./lib/tstl-utils";
import "./util/custom_entities_legacy";
import "./util/math_legacy";
import "./util/util";
import "./constructors";
import "./libraries/timers";
import PreRound from "./clases/pvp/pre_round";
import Round from "./clases/pvp/round";
import { CustomItems } from "./util/custom_items";
import { ModifierObstacle } from "./modifiers/modifier_obstacle";
import { updateProjectiles } from "./projectiles";
import { ModifierDamageVFX } from "./modifiers/modifier_damage_vfx";
import { ModifierProvidesVision } from "./modifiers/modifier_provides_vision";
import {
    hasBehavior,
    allAbilities,
    direction2D,
    distanceBetweenPoints,
    fullyFaceTowards,
    getAbilityEnergyCost,
    getEnergy,
    giveEnergy,
    isPlayerHero,
    sendOverheadDamageMessage
} from "./util";
import { getPrecacheListAndLock } from "./precache";
import { alliances, findAllianceByTeam, findFirstAliveAlliancePlayer } from "./alliances";
import { Game, MapNames, findPlayerById, getGame, getMode, initStartingStage, setStage } from "./game";
import { Player, players } from "./players";
import { createEntity, entities, findEntityByHandle, removeEntity } from "./entities";
import { initBattleStage, updateBattleState } from "./battle";
import { initAdventureStage, updateAdventureStage } from "./adventure";
import "./abilities";
import "./legends";

declare global {
    interface CDOTAGameRules {
        Addon: GameMode;
    }
}

export interface CustomActionEvent {
    playerId: PlayerID;
    playerIndex: PlayerID;
    payload?: any;
    x?: number;
    y?: number;
    z?: number;
}

enum Custom_ActionTypes {
    MOVEMENT = 0,
    ABILITY = 1
}

enum Custom_ActionModes {
    START = 0,
    STOP = 1
}

export function precacheResources(context: CScriptPrecacheContext) {
    const precacheList = [...getPrecacheListAndLock()];

    const precachedPaths: LuaSet<string> = new LuaSet();

    for (const { type, path } of precacheList) {
        const token = `${type}_${path}`;

        if (!precachedPaths.has(token)) {
            print(`Precaching ${type} ${path}`);

            if (type == "unit") {
                PrecacheUnitByNameSync(path, context);
            } else {
                PrecacheResource(type, path, context);
            }

            precachedPaths.add(token);
        }
    }
}

export function startGame() {
    GameRules.Addon = new GameMode();

    setupEventHooks();
    setupPanoramaEventHooks();
    setupRules();
    setupFilters();

    const mode = GameRules.GetGameModeEntity();
    mode.SetBuybackEnabled(false);
    mode.SetDaynightCycleDisabled(true);
    mode.SetCameraDistanceOverride(1350);
    mode.SetModifierGainedFilter(event => event.name_const != "modifier_fountain_invulnerability", {});
}

function setupEventHooks() {
    ListenToGameEvent("npc_spawned", event => onNPCInGame(event), undefined);
    ListenToGameEvent("entity_killed", event => onEntityKilled(event), undefined);
    ListenToGameEvent("game_rules_state_change", () => onNativeStateChange(GameRules.State_Get()), undefined);
    ListenToGameEvent("dota_player_learned_ability", event => onLearnedAbilityEvent(event), undefined);
    ListenToGameEvent("player_chat", event => onPlayerChat(event), undefined);
    ListenToGameEvent("entity_hurt", event => onEntityHurt(event), undefined);

    print("[AMETHYST] Event hooks set");
}

function onNPCInGame(event: NpcSpawnedEvent) {
    const unit = EntIndexToHScript(event.entindex);
    if (unit === undefined || unit.IsNull()) {
        return false;
    }

    if (unit.GetName() === "npc_dota_thinker" || unit.GetName() === "npc_dota_base") {
        return true;
    }

    if (unit.IsBaseNPC()) {
        const entity = entities.find(entity => entity.handle == unit) ?? createEntity(unit);
        const player = findPlayerById(unit.GetPlayerOwnerID());
        initUnit(unit);

        if (player && !player.entity) {
            player.entity = entity;
        }
    }

    return true;
}

function onEntityKilled(event: EntityKilledEvent): void {
    const killed = EntIndexToHScript(event.entindex_killed) as CDOTA_BaseNPC;

    if (killed.IsRealHero()) {
        if (getMode() == MapNames.pvp) {
            // this.OnHeroKilledPVP(killed);
        }
        if (!isPlayerHero(killed)) {
            // this.SetRespawnTime(killed.GetTeam(), killed as CDOTA_BaseNPC_Hero, 999);
        }
    }

    const entity = findEntityByHandle(killed);

    if (entity) {
        removeEntity(entity);
    }
}

function initUnit(unit: CDOTA_BaseNPC) {
    print("Initializing... ", unit.GetUnitName());
    function isRegularAbility(ability: CDOTABaseAbility) {
        return ability.GetAbilityType() != 2 && ability.GetName() != "special_bonus_attributes";
    }

    for (const ability of allAbilities(unit)) {
        if (isRegularAbility(ability)) {
            ability.SetLevel(1);
        }
    }
}

function setupPanoramaEventHooks() {
    CustomGameEventManager.RegisterListener("updateMousePosition", (_, args) => {
        const position = Vector(args.x, args.y, args.z);
        const playerId = args.playerId as PlayerID;
        const player = findPlayerById(playerId);
        if (player) {
            player.cursorPosition = position;
        }
    });

    CustomGameEventManager.RegisterListener("customAction", (_, event) => {
        const playerId = event.playerIndex as PlayerID;
        const entity = findPlayerById(playerId)?.entity;

        if (entity) {
            const type = event.payload.type;
            const mode = event.payload.mode;

            if (type == Custom_ActionTypes.MOVEMENT) {
                const incoming = event.payload.direction;
                const vector = Vector(incoming["0"], incoming["1"]);
                const direction = mode == Custom_ActionModes.STOP ? vector.__mul(-1) : vector;
                entity.direction = entity.direction.__add(direction);
            }
        }
    });

    CustomGameEventManager.RegisterListener("refundPoints", (_, event) => {
        const playerId = event.playerIndex as PlayerID;
        const player = findPlayerById(playerId);

        if (player) {
            const hero = player.entity?.handle;

            if (hero && hero.IsRealHero()) {
                for (let i = 0; i <= 23; i++) {
                    const ability = hero.GetAbilityByIndex(i);
                    if (ability) {
                        if (ability.GetAbilityType() !== 2) {
                            ability.SetLevel(1); //THIS WILL LEVEL THE STATS TALENTS!
                        }
                    }
                }

                hero.SetAbilityPoints(Constants.upgradePoints);
                CustomEntitiesLegacy.SendDataToClient(hero);
            }
        }

        // if (this.warmup) {
        //     this.warmup.SetDuration(this.warmup.GetDuration() + 10.0);
        // }
    });
}

function setupRules() {
    GameRules.SetSameHeroSelectionEnabled(true);
    GameRules.SetPreGameTime(0.0);
    GameRules.SetGoldPerTick(0);
    GameRules.SetGoldTickTime(0);
    GameRules.SetStartingGold(0);
    GameRules.SetCustomGameSetupAutoLaunchDelay(10);
    GameRules.SetStrategyTime(0.0);
    GameRules.SetShowcaseTime(0.0);
    GameRules.SetUseBaseGoldBountyOnHeroes(false);
    GameRules.GetGameModeEntity().SetLoseGoldOnDeath(false);
    GameRules.SetTimeOfDay(0.5);

    if (getMode() == MapNames.pvp) {
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.GOODGUYS, 1);
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.BADGUYS, 1);
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.CUSTOM_1, 1);
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.CUSTOM_2, 1);
        GameRules.SetHeroRespawnEnabled(false);
    }
    if (getMode() == MapNames.pve) {
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.GOODGUYS, 2);
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.BADGUYS, 2);
        GameRules.SetHeroRespawnEnabled(true);
        GameRules.GetGameModeEntity().SetFixedRespawnTime(5.0);
    }
    print("[AMETHYST] GameRules set");
}

function setupFilters() {
    const mode = GameRules.GetGameModeEntity();
    mode.SetModifyGoldFilter(() => false, {});
    mode.SetExecuteOrderFilter(event => executeOrderFilter(event), {});
    mode.SetModifyExperienceFilter(() => false, {});
    mode.SetHealingFilter(event => healingFilter(event), {});
    mode.SetDamageFilter(event => damageFilter(event), {});
    print("[AMETHYST] Filters set");
}

function executeOrderFilter(event: ExecuteOrderFilterEvent) {
    const orderType = event.order_type;

    if (
        orderType === UnitOrder.CAST_POSITION ||
        orderType === UnitOrder.CAST_TARGET ||
        orderType === UnitOrder.CAST_TARGET_TREE ||
        orderType === UnitOrder.CAST_NO_TARGET
    ) {
        const ability = EntIndexToHScript(event.entindex_ability) as CDOTABaseAbility;
        const caster = EntIndexToHScript(event.units["0"]);

        if (caster?.IsBaseNPC()) {
            const entity = findEntityByHandle(caster);

            if (!entity) {
                return true;
            }

            const energyCost = getAbilityEnergyCost(ability);
            const energy = getEnergy(entity.handle);

            const player = PlayerResource.GetPlayer(event.issuer_player_id_const);

            if (energyCost > 0) {
                if (energyCost > energy && player) {
                    CustomGameEventManager.Send_ServerToPlayer(player, "not_enough_energy", {});
                    return false;
                }

                giveEnergy(caster, -getAbilityEnergyCost(ability), true, false);
            }

            if (orderType === UnitOrder.CAST_POSITION) {
                const point = Vector(event.position_x, event.position_y, event.position_z);
                const currentRange = distanceBetweenPoints(caster.GetAbsOrigin(), point);
                const direction = direction2D(caster.GetAbsOrigin(), point);
                const maxRange = ability.GetCastRange(Vector(0, 0, 0), undefined);

                if (!hasBehavior(ability.GetBehavior(), AbilityBehavior.IMMEDIATE)) {
                    fullyFaceTowards(caster, direction);
                }

                if (currentRange > maxRange) {
                    const newPoint = caster.GetAbsOrigin().__add(direction.__mul(maxRange - 10));
                    event.position_x = newPoint.x;
                    event.position_y = newPoint.y;
                }
            }
        }

        return true;
    }

    if (orderType === UnitOrder.STOP || orderType === UnitOrder.HOLD_POSITION) {
        const caster = EntIndexToHScript(event.units["0"]) as CDOTA_BaseNPC;
        const ability = caster.GetCurrentActiveAbility();
        if (ability) {
            if (ability.GetAbilityType() === 1) {
                return false;
            }
        }
    }
    if (orderType === UnitOrder.HOLD_POSITION) {
        print("YOU ARE HOLDING POSITION; PROBABLY YOU WANT TO STOP INSTEAD");
    }
    if (orderType === UnitOrder.MOVE_TO_POSITION || orderType === UnitOrder.MOVE_TO_TARGET) {
        return false;
    }

    return true;
}

function healingFilter(event: HealingFilterEvent) {
    const target = EntIndexToHScript(event.entindex_target_const);
    if (target?.IsBaseNPC() && target.IsRealHero()) {
        const entity = findEntityByHandle(target);

        if (entity) {
            event.heal = Constants.maxThreshold - entity.threshold;
            entity.threshold = Math.min(entity.threshold + event.heal, Constants.maxThreshold);
        }

        const healingAlliance = findAllianceByTeam(target.GetTeam());
        if (healingAlliance) {
            // Timers.CreateTimer(0.05, function () {
            //     healing_alliance.SendDataToClient();
            // });
        }
    }

    // SendOverheadHealMessage(target, event.heal);
    // Timers.CreateTimer(0.05, function () {
    //     CustomEntitiesLegacy.SendDataToClient(target);
    // });

    return true;
}

function damageFilter(event: DamageFilterEvent) {
    const attacker = EntIndexToHScript(event.entindex_attacker_const);
    const victim = EntIndexToHScript(event.entindex_victim_const);
    //const damage_type = event.damagetype_const;
    const damageAfterReductions = Math.floor(event.damage);
    //const ability = (event.entindex_inflictor_const) ? EntIndexToHScript(event.entindex_inflictor_const) : undefined;

    //Lack of entities handling (illusions error fix)
    if ((attacker && attacker.IsNull()) || (victim && victim.IsNull())) {
        return false;
    }

    if (victim && victim.IsBaseNPC()) {
        ModifierDamageVFX.apply(victim, victim, undefined, {
            duration: 0.1
        });

        // Timers.CreateTimer(0.05, function () {
        //     CustomEntitiesLegacy.SendDataToClient(victim);
        // });

        const victimEntity = findEntityByHandle(victim);

        if (victim.IsRealHero() && victimEntity) {
            victimEntity.threshold = Math.max(0, victimEntity.threshold - damageAfterReductions);

            const victimTeam = victim.GetTeam();
            const victimAlliance = findAllianceByTeam(victimTeam);

            if (victimAlliance) {
                // Timers.CreateTimer(0.05, function () {
                //     victim_alliance.SendDataToClient();
                // });
            }
        }
    }

    return true;
}

function onLearnedAbilityEvent(event: DotaPlayerLearnedAbilityEvent): void {
    const playerId = event.PlayerID;
    const ownerPlayer = findPlayerById(playerId);

    if (ownerPlayer) {
        const hero = ownerPlayer.entity?.handle;

        if (hero) {
            if (!players.some(player => player.entity?.handle.IsRealHero() && player.entity?.handle.GetAbilityPoints() > 0)) {
                // if (this.warmup) {
                //     if (this.warmup.GetDuration() > 3.0) {
                //         this.warmup.SetDuration(3.0);
                //     }
                // }
            }

            CustomEntitiesLegacy.SendDataToClient(hero);
        }
    }
}

function refreshHeroes() {
    for (const player of players) {
        const hero = player.entity?.handle;

        if (hero && !hero.IsNull() && hero.IsAlive()) {
            giveEnergy(hero, Constants.maxEnergy, false, false);
            CustomEntitiesLegacy.SendDataToClient(hero);
        }
    }
}

function onPlayerChat(event: PlayerChatEvent) {
    const playerId = event.playerid;
    const player = findPlayerById(playerId);

    if (event.text == "-unstuck") {
        if (player) {
            const hero = player.entity?.handle;
            if (hero) {
                CustomEntitiesLegacy.SetDirection(hero, 0, 0);
            }
        }
    }

    if (!GameRules.IsCheatMode() && !IsInToolsMode()) {
        return;
    }

    if (event.text == "-refresh") {
        refreshHeroes();
    }

    if (event.text == "-wtf") {
        refreshHeroes();
        // this.wtf = true;
    }

    if (event.text == "-unwtf") {
        // this.wtf = false;
    }

    if (event.text == "-skip") {
        if (getMode() == MapNames.pve) {
            // if (this.run && this.run.stage && this.run.stage.room) {
            //     this.run.stage.room.SkipWave();
            // }
        }
    }

    if (event.text.split(" ")[0] == "-room") {
        if (!event.text.split(" ")[1]) {
            return;
        }
        if (getMode() == MapNames.pve) {
            let room = parseInt(event.text.split(" ")[1], 10);
            if (isNaN(room)) {
                return;
            }
            room = room - 1;

            // if (this.run && this.run.stage && this.run.stage.room) {
            //     if (this.run.stage.totalNpcRooms > room) {
            //         return;
            //     }
            //     this.run.stage.room.SkipRoom();
            // }
        }
    }
}

function onEntityHurt(event: EntityHurtEvent): void {
    if (event.entindex_killed !== undefined) {
        const victim = EntIndexToHScript(event.entindex_killed) as CDOTA_BaseNPC;

        if (event.entindex_attacker !== undefined) {
            sendOverheadDamageMessage(victim, event.damage);
        }

        const entity = findEntityByHandle(victim);

        if (entity) {
            entity.hurt = true;
        }
    }
}

@reloadable
export class GameMode {
    private players: Player[] = [];
    private state = CustomGameState.NONE;
    private wtf = false;

    public warmup: Warmup | undefined;
    public preRound: PreRound | undefined;
    public round: Round | undefined;
    public currentRoom = -1;

    // eslint-disable-next-line @typescript-eslint/no-empty-function
    public static Precache(this: void, context: CScriptPrecacheContext): void {
        PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_oracle.vsndevts", context);
        PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_magnataur.vsndevts", context);
        PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_silencer.vsndevts", context);
        PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_furion.vsndevts", context);
        PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_phoenix.vsndevts", context);
        PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_sven.vsndevts", context);
        PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_abaddon.vsndevts", context);
        PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_zuus.vsndevts", context);
        PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_doombringer.vsndevts", context);
        PrecacheResource("soundfile", "soundevents/game_sounds_items.vsndevts", context);

        PrecacheResource("particle", "particles/units/heroes/hero_chen/chen_hand_of_god.vpcf", context);
        PrecacheResource("particle", "particles/units/heroes/hero_chen/chen_divine_favor_buff.vpcf", context);
        PrecacheResource("particle", "particles/base_attacks/ranged_badguy_persistent_glow_green.vpcf", context);
        PrecacheResource("particle", "particles/units/heroes/hero_wisp/wisp_overcharge_c.vpcf", context);
        PrecacheResource("particle", "models/items/rubick/rubick_arcana/sfm/particles/rubick_arcana_temp_2_rocks_glow.vpcf", context);
        PrecacheResource("particle", "particles/units/heroes/hero_omniknight/omniknight_purification_cast_b.vpcf", context);

        PrecacheResource("particle", "particles/items_fx/arcane_boots_recipient.vpcf", context);
        PrecacheResource("particle", "particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp_magical.vpcf", context);
        PrecacheResource("particle", "particles/units/heroes/hero_abaddon/abaddon_aphotic_shield_explosion.vpcf", context);

        const heroes: any = LoadKeyValues("scripts/npc/npc_heroes_custom.txt");
        for (const key in heroes) {
            const hero = heroes[key];
            PrecacheUnitByNameSync(hero.override_hero, context);
        }
    }

    public Start(): void {
        if (getMode() == MapNames.pvp) {
            this.StartPVPMap();
        }
    }

    StartPVPMap(): void {
        this.CreateBarrels();
        this.SetState(CustomGameState.WARMUP_IN_PROGRESS);
        // this.warmup = new Warmup(alliances, settings.FirstWarmupDuration);

        CustomNetTables.SetTableValue("main", "maxScore", { max_score: Constants.roundsDifferenceToWin });

        // this.RegisterThinker(0.01, () => {
        //     if (this.state == CustomGameState.WARMUP_IN_PROGRESS && this.warmup) {
        //         this.warmup.Update();
        //     }
        //     if (this.state == CustomGameState.PRE_ROUND && this.preRound) {
        //         this.preRound.Update();
        //     }
        //     if (this.state == CustomGameState.ROUND_IN_PROGRESS && this.round) {
        //         this.round.Update();
        //     }
        // });
    }

    IsInWTFMode(): boolean {
        return this.wtf;
    }

    SetState(state: CustomGameState): void {
        this.OnStateEnd(this.state);
        this.state = state;
        CustomNetTables.SetTableValue("main", "gameState", { gameState: state });
    }

    OnStateEnd(state: CustomGameState): void {
        if (state === CustomGameState.ROUND_IN_PROGRESS) {
            this.round = undefined;
            this.warmup = new Warmup(alliances, Constants.warmupDuration);
        } else if (state === CustomGameState.WARMUP_IN_PROGRESS) {
            this.warmup = undefined;
            this.preRound = new PreRound(alliances, 1);
        } else if (state === CustomGameState.PRE_ROUND) {
            this.preRound = undefined;
            this.round = new Round(alliances, Constants.roundDuration);
        }
    }

    CreateBarrels(): CDOTA_BaseNPC[] {
        const barrelEnts = Entities.FindAllByName("wall_spawn");
        const barrels: CDOTA_BaseNPC[] = [];

        barrelEnts.forEach(entity => {
            barrels.push(this.CreateBarrel(entity.GetAbsOrigin()));
        });

        return barrels;
    }

    CreateBarrel(origin: Vector): CDOTA_BaseNPC {
        const fowBlocker = SpawnEntityFromTableSynchronous("point_simple_obstruction", {
            origin: origin,
            block_fow: true
        });
        const barrel = CreateUnitByName("npc_dota_creature_wall", origin, false, undefined, undefined, DotaTeam.NOTEAM);
        ModifierObstacle.apply(barrel, barrel, undefined, {})?.SetFowBlocker(fowBlocker);
        barrel.SetHullRadius(65);
        return barrel;
    }

    public OnPickedUp(item: CDOTA_Item) {
        CustomItems.GetInstance().GetParent(item)?.OnPickedUp();
    }

    OnGameInProgress(): void {
        this.Start();
    }

    IncrementWave(): void {
        this.currentRoom = this.currentRoom + 1;
    }

    OnHeroKilledPVP(): void {
        if (this.round) {
            this.round.heroDied = true;
            this.UpdateCameras();
        }
    }

    UpdateCameras(): void {
        this.players.forEach(player => {
            const hero = player.entity?.handle;
            if (hero && hero.IsRealHero() && !hero.IsAlive() && player.alliance) {
                const aliveAlly = findFirstAliveAlliancePlayer(player.alliance);

                if (aliveAlly) {
                    PlayerResource.SetCameraTarget(hero.GetPlayerID(), aliveAlly);
                    ModifierProvidesVision.apply(aliveAlly, hero, undefined, {});
                } else {
                    const aliveHero = this.FindNextAliveHero();
                    if (aliveHero) {
                        PlayerResource.SetCameraTarget(hero.GetPlayerID(), aliveHero);
                        ModifierProvidesVision.apply(aliveHero, hero, undefined, {});
                    }
                }
            }
        });
    }

    FindNextAliveHero() {
        return this.players.map(player => player.entity).find(entity => entity?.handle?.IsAlive())?.handle;
    }

    SetRespawnTime(team: DotaTeam, victim: CDOTA_BaseNPC_Hero, time: number): void {
        victim.SetTimeUntilRespawn(time);
    }

    public GetCursorPositionForPlayer(playerId: PlayerID): Vector {
        const player = findPlayerById(playerId);

        return player ? player.cursorPosition : Vector(0, 0);
    }

    EndGame(victoryTeam: DotaTeam): void {
        GameRules.SetGameWinner(victoryTeam);
    }

    UpdateProjectiles() {
        // This is neccesary to work with script_reload...
        updateProjectiles();
    }
}

function update() {
    const game = getGame();

    switch (game.stage) {
        case Stage.adventure: {
            updateAdventureStage(game);
            break;
        }
        case Stage.battle: {
            updateBattleState(game);
            break;
        }
    }

    GameRules.Addon.UpdateProjectiles();
}

function waitUntilAllHeroesLoad(game: Game) {
    return new Promise<void>(resolve => {
        Timers.CreateTimer(0, () => {
            if (game.config.players.some(player => player.entity == undefined)) {
                return 0.1;
            } else {
                resolve();
            }
        });
    });
}

async function onNativeStateChange(state: GameState) {
    print(`Native state changed to ${state}`);

    if (state == GameState.CUSTOM_GAME_SETUP) {
        // Need to wait a frame otherwise player in tools doesn't connect
        Timers.CreateTimer(() => {
            setStage(initStartingStage());

            GameRules.GetGameModeEntity().SetContextThink(
                "update_think",
                () => {
                    update();
                    return 0;
                },
                0
            );
        });
    }

    if (state == GameState.GAME_IN_PROGRESS) {
        const game = getGame();

        if (getMode() == MapNames.pvp) {
            setStage(initBattleStage(game.config, 1));
        }

        if (getMode() == MapNames.pve) {
            await waitUntilAllHeroesLoad(game);
            const stage = await initAdventureStage(game.config);
            setStage(stage);
        }

        GameRules.Addon.OnGameInProgress();
    }
}

print("Reload...");
