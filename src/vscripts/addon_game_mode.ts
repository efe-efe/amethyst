import "./abilities_meta";
import Alliance from "./clases/alliance";
import { CustomGameState } from "./clases/game_state";
import Warmup from "./clases/pvp/warmup";
import { reloadable } from "./lib/tstl-utils";
import "./wrappers/modifiers";
import "./util/custom_entities_legacy";
import "./util/math_legacy";
import "./util/util";
import "./settings";
import "./constructors";
import "./libraries/timers";
import "./overrides/abilities";
import Player from "./clases/player";
import PreRound from "./clases/pvp/pre_round";
import Round from "./clases/pvp/round";
import CustomNPC, { CustomNonPlayerHeroNPC, CustomPlayerHeroNPC } from "./clases/pve/custom_npc";
import { CustomItems } from "./util/custom_items";
import Pickup, { PickupTypes } from "./clases/pickup";
import settings from "./settings";
import PreRun from "./clases/pve/pre_run";
import { NPCNames } from "./clases/pve/custom_ai";
import Run from "./clases/pve/run";
import { RewardsManager } from "./rewards/rewards";
import { ModifierObstacle } from "./modifiers/modifier_obstacle";
import { updateProjectiles } from "./projectiles";
import { ModifierDamageVFX } from "./modifiers/modifier_damage_vfx";
import { ModifierProvidesVision } from "./modifiers/modifier_provides_vision";
import { abilityHasBehavior, fullyFaceTowards, getAbilityEnergyCost, giveEnergy } from "./util";

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

interface Thinker {
    period: number;
    callback: () => void;
    next: number;
}

enum MapNames {
    "pvp" = "pvp",
    "pve" = "pve"
}

enum Custom_ActionTypes {
    MOVEMENT = 0,
    ABILITY = 1
}

enum Custom_ActionModes {
    START = 0,
    STOP = 1
}

const DOTA_ALIANCE_NO_ALLIANCE = 0;
const DOTA_ALLIANCE_RADIANT = 1;
const DOTA_ALLIANCE_DIRE = 2;
const DOTA_ALLIANCE_LEGION = 3;
const DOTA_ALLIANCE_VOID = 4;

const THINK_PERIOD = 0.01;

@reloadable
export class GameMode {
    private players: Player[] = [];
    private units: (CustomPlayerHeroNPC | CustomNonPlayerHeroNPC | CustomNPC)[] = [];
    private state = CustomGameState.NONE;
    private thinkers: Thinker[] = [];
    private wtf = false;

    public alliances: Alliance[] = [];
    public warmup: Warmup | undefined;
    public preRound: PreRound | undefined;
    public preRun: PreRun | undefined;
    public round: Round | undefined;
    public run: Run | undefined;
    public max_treshold = 30;
    public currentRoom = -1;

    constructor() {
        this.SetupEventHooks();
        this.SetupPanoramaEventHooks();
        this.SetupRules();
        this.SetupFilters();

        const mode = GameRules.GetGameModeEntity();
        mode.SetBuybackEnabled(false);
        mode.SetDaynightCycleDisabled(true);
        mode.SetCameraDistanceOverride(1350);
    }

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

    public static Activate(this: void): void {
        GameRules.Addon = new GameMode();
    }

    public Start(): void {
        this.alliances.push(new Alliance(DOTA_ALIANCE_NO_ALLIANCE, []));
        this.alliances.push(new Alliance(DOTA_ALLIANCE_RADIANT, [DotaTeam.GOODGUYS, DotaTeam.BADGUYS]));
        this.alliances.push(new Alliance(DOTA_ALLIANCE_DIRE, [DotaTeam.CUSTOM_1, DotaTeam.CUSTOM_2, DotaTeam.NEUTRALS]));
        this.alliances.push(new Alliance(DOTA_ALLIANCE_LEGION, [DotaTeam.CUSTOM_3, DotaTeam.CUSTOM_4]));
        this.alliances.push(new Alliance(DOTA_ALLIANCE_VOID, [DotaTeam.CUSTOM_5, DotaTeam.CUSTOM_6]));

        if (this.getMode() == "pvp") {
            this.StartPVPMap();
        }
        if (this.getMode() == "pve") {
            this.StartPVEMap();
        }
    }

    StartPVPMap(): void {
        this.CreateBarrels();
        this.SetState(CustomGameState.WARMUP_IN_PROGRESS);
        this.warmup = new Warmup(this.alliances, settings.FirstWarmupDuration);

        const tableName = "main" as never;
        const data = { max_score: settings.RoundsDifferenceToWin } as never;
        CustomNetTables.SetTableValue(tableName, "maxScore", data);

        this.RegisterThinker(0.01, () => {
            if (this.state == CustomGameState.WARMUP_IN_PROGRESS && this.warmup) {
                this.warmup.Update();
            }
            if (this.state == CustomGameState.PRE_ROUND && this.preRound) {
                this.preRound.Update();
            }
            if (this.state == CustomGameState.ROUND_IN_PROGRESS && this.round) {
                this.round.Update();
            }
        });
    }

    StartPVEMap(): void {
        this.SetState(CustomGameState.PRE_RUN);
        this.preRun = new PreRun(this.alliances, -1);

        this.RegisterThinker(0.01, () => {
            if (this.state == CustomGameState.RUN_IN_PROGRESS && this.run) {
                this.run.Update();
            }
            if (this.state == CustomGameState.PRE_RUN && this.preRun) {
                this.preRun.Update();
            }
        });
    }

    OnThink(): number {
        if (GameRules.IsGamePaused()) {
            return THINK_PERIOD;
        }
        const now = Time();

        if (GameRules.State_Get() >= GameState.CUSTOM_GAME_SETUP) {
            this.thinkers.forEach(thinker => {
                if (now >= thinker.next) {
                    thinker.next = math.max(thinker.next + thinker.period, now);
                    thinker.callback();
                }
            });
        }

        return THINK_PERIOD;
    }

    SetupRules(): void {
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

        if (this.getMode() == "pvp") {
            this.SetupRulesPVP();
        }
        if (this.getMode() == "pve") {
            this.SetupRulesPVE();
        }
        print("[AMETHYST] GameRules set");
    }

    SetupRulesPVP(): void {
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.GOODGUYS, 1);
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.BADGUYS, 1);
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.CUSTOM_1, 1);
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.CUSTOM_2, 1);
        GameRules.SetHeroRespawnEnabled(false);
    }

    SetupRulesPVE(): void {
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.GOODGUYS, 2);
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.BADGUYS, 2);
        GameRules.SetHeroRespawnEnabled(true);
        GameRules.GetGameModeEntity().SetFixedRespawnTime(5.0);
    }

    SetupEventHooks(): void {
        ListenToGameEvent("npc_spawned", event => this.OnNPCInGame(event), undefined);
        ListenToGameEvent("game_rules_state_change", () => onNativeStateChange(GameRules.State_Get()), undefined);
        ListenToGameEvent("dota_player_learned_ability", event => this.OnLearnedAbilityEvent(event), undefined);
        ListenToGameEvent("player_chat", event => this.OnPlayerChat(event), undefined);
        ListenToGameEvent("entity_killed", event => this.OnEntityKilled(event), undefined);
        ListenToGameEvent("entity_hurt", event => this.OnEntityHurt(event), undefined);
        print("[AMETHYST] Event hooks set");
    }

    SetupPanoramaEventHooks(): void {
        CustomGameEventManager.RegisterListener("updateMousePosition", (eventSourceIndex, args) => {
            const position = Vector(args.x, args.y, args.z);
            const playerId = args.playerId as PlayerID;
            const player = this.FindPlayerById(playerId);
            if (player) {
                player.UpdateCursorPosition(position);
            }
        });

        CustomGameEventManager.RegisterListener("customAction", (eventSourceIndex, event) => {
            const playerId = event.playerIndex as PlayerID;
            const player = this.FindPlayerById(playerId);

            if (player) {
                const customNpc = player.customNpc;
                const hero = player.hero;

                const type = event.payload.type;
                const mode = event.payload.mode;

                if (type == Custom_ActionTypes.MOVEMENT && hero) {
                    const currentDirection = CustomEntitiesLegacy.GetRawDirection(hero);
                    const incomingDirection = event.payload.direction;
                    let vector = Vector(incomingDirection["0"], incomingDirection["1"], 0);

                    if (mode == Custom_ActionModes.STOP) {
                        vector = vector.__mul(-1);
                    }

                    const newDirection = currentDirection.__add(vector);
                    newDirection.z = hero.GetForwardVector().z;
                    CustomEntitiesLegacy.SetDirection(hero, newDirection.x, newDirection.y);
                }

                if (type == Custom_ActionTypes.ABILITY && hero) {
                    if (mode == Custom_ActionModes.STOP) {
                        const ability = EntIndexToHScript(event.payload.abilityEntityIndex as EntityIndex);
                        if (customNpc && ability) {
                            customNpc.ReleaseAbility(ability.GetName());
                        }
                    }
                }
            }
        });

        CustomGameEventManager.RegisterListener("refundPoints", (eventSourceIndex, event) => {
            const playerId = event.playerIndex as PlayerID;
            const player = this.FindPlayerById(playerId);

            if (player) {
                const hero = player.hero;

                if (hero) {
                    for (let i = 0; i <= 23; i++) {
                        const ability = hero.GetAbilityByIndex(i);
                        if (ability) {
                            if (ability.GetAbilityType() !== 2) {
                                ability.SetLevel(1); //THIS WILL LEVEL THE STATS TALENTS!
                            }
                        }
                    }

                    hero.SetAbilityPoints(settings.AbilityPoints);
                    CustomEntitiesLegacy.SendDataToClient(hero);
                }
            }

            if (this.warmup) {
                this.warmup.SetDuration(this.warmup.GetDuration() + 10.0);
            }
        });

        CustomGameEventManager.RegisterListener("swapRF", (eventSourceIndex, event) => {
            const playerId = event.playerIndex as PlayerID;
            const player = this.FindPlayerById(playerId);

            if (player) {
                const hero = player.hero;
                if (hero) {
                    const ability_name_one = hero.GetAbilityByIndex(5)?.GetName();
                    const ability_name_two = hero.GetAbilityByIndex(6)?.GetName();

                    if (ability_name_one && ability_name_two) {
                        hero.SwapAbilities(ability_name_one, ability_name_two, true, true);
                    }
                }
            }
        });
    }

    SetupFilters(): void {
        const mode = GameRules.GetGameModeEntity();
        mode.SetModifyGoldFilter(() => false, this);
        mode.SetExecuteOrderFilter(this.ExecuteOrderFilter, this);
        mode.SetModifyExperienceFilter(this.ModifyExperienceFilter, this);
        mode.SetHealingFilter(this.HealingFilter, this);
        mode.SetDamageFilter(this.DamageFilter, this);
        print("[AMETHYST] Filters set");
    }

    IsInWTFMode(): boolean {
        return this.wtf;
    }

    public RegisterThinker(period: number, callback: () => void): void {
        const thinker: Thinker = {
            period,
            callback,
            next: Time() + period
        };

        this.thinkers.push(thinker);
    }

    FindAllianceByTeam(team: DotaTeam): Alliance | undefined {
        let found = undefined;

        this.alliances.forEach(alliance => {
            alliance.teams.forEach(allianceTeam => {
                if (allianceTeam === team) {
                    found = alliance;
                }
            });
        });

        return found;
    }

    RegisterPlayer(hero: CDOTA_BaseNPC_Hero, customNpc: CustomPlayerHeroNPC): boolean {
        const team = hero.GetTeamNumber();
        const playerID = hero.GetPlayerOwnerID();
        const userID = playerID + 1;

        if (playerID == -1) {
            hero.Destroy();
            print(
                "ERROR: TRYING TO CREATE AN UNIT ON AN INVALID PLAYER: \n\t playerID: " +
                    playerID +
                    "\n\t hero: " +
                    hero.GetName() +
                    "\n\t team: " +
                    team
            );
            return false;
        } else {
            let player = this.FindPlayerById(playerID);
            if (!player) {
                player = new Player(playerID, userID);
                this.players.push(player);
                const alliance = this.FindAllianceByTeam(team);

                if (!alliance) {
                    print(`ERROR: THE PLAYER ${playerID} IN TEAM ${team} IS NOT PART OF ANY ALLIANCE!`);
                    return false;
                }

                player.SetTeam(team);
                player.SetAlliance(alliance);
                player.SetHero(hero);
                player.SetCustomNPC(customNpc);

                alliance.AddPlayer(player);
            }

            return true;
        }
    }

    SetState(state: CustomGameState): void {
        this.OnStateEnd(this.state);
        this.state = state;
        const tableName = "main" as never;
        const data = { gameState: state } as never;
        CustomNetTables.SetTableValue(tableName, "gameState", data);
    }

    OnStateEnd(state: CustomGameState): void {
        if (state === CustomGameState.ROUND_IN_PROGRESS) {
            this.round = undefined;
            this.warmup = new Warmup(this.alliances, settings.WarmupDuration);
        } else if (state === CustomGameState.WARMUP_IN_PROGRESS) {
            this.warmup = undefined;
            this.preRound = new PreRound(this.alliances, 1);
        } else if (state === CustomGameState.PRE_ROUND) {
            this.preRound = undefined;
            this.round = new Round(this.alliances, settings.RoundDuration);
        } else if (state === CustomGameState.PRE_RUN) {
            this.preRun = undefined;
            this.run = new Run(this.alliances, [
                {
                    possibleNPCs: [
                        NPCNames.DIRE_ZOMBIE_RANGE,
                        NPCNames.DIRE_ZOMBIE_MEELE_MEGA,
                        NPCNames.DIRE_ZOMBIE_RANGE_MEGA,
                        NPCNames.FLYING_SKULL,
                        NPCNames.DIRE_TOWER,
                        NPCNames.QUEEN
                    ]
                },
                {
                    possibleNPCs: [
                        NPCNames.RADIANT_ZOMBIE_RANGE_MEGA,
                        NPCNames.RADIANT_ZOMBIE_MEELE_MEGA,
                        NPCNames.FLYING_SKULL,
                        NPCNames.QUEEN
                    ]
                }
            ]);
        } else if (state === CustomGameState.RUN_IN_PROGRESS) {
            this.run = undefined;
            this.EndGame(DotaTeam.GOODGUYS);
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

    ModifyExperienceFilter(): boolean {
        return false;
    }

    ExecuteOrderFilter(this: this, event: ExecuteOrderFilterEvent): boolean {
        const orderType = event.order_type;

        if (
            orderType === UnitOrder.CAST_POSITION ||
            orderType === UnitOrder.CAST_TARGET ||
            orderType === UnitOrder.CAST_TARGET_TREE ||
            orderType === UnitOrder.CAST_NO_TARGET
        ) {
            const ability = EntIndexToHScript(event.entindex_ability) as CDOTA_Ability_Lua;
            const caster = EntIndexToHScript(event.units["0"]) as CDOTA_BaseNPC;
            const energyCost = getAbilityEnergyCost(ability);
            const energy = CustomEntitiesLegacy.GetEnergy(caster);

            const player = PlayerResource.GetPlayer(event.issuer_player_id_const);
            if (energyCost > energy && player) {
                CustomGameEventManager.Send_ServerToPlayer(player, "not_enough_energy", {} as never);
                return false;
            }

            if (orderType === UnitOrder.CAST_POSITION) {
                const point = Vector(event.position_x, event.position_y, event.position_z);
                const current_range = point.__sub(caster.GetAbsOrigin()).Length2D();
                const direction = point.__sub(caster.GetAbsOrigin()).Normalized();
                const max_range = ability.GetCastRange(Vector(0, 0, 0), undefined);

                if (!abilityHasBehavior(ability, AbilityBehavior.IMMEDIATE)) {
                    fullyFaceTowards(caster, direction);
                }

                if (current_range > max_range) {
                    const new_point = caster.GetAbsOrigin().__add(direction.__mul(max_range - 10));
                    event.position_x = new_point.x;
                    event.position_y = new_point.y;
                }

                return true;
            }
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

    HealingFilter(this: this, event: HealingFilterEvent): boolean {
        const target = EntIndexToHScript(event.entindex_target_const) as CDOTA_BaseNPC;
        //const ability = (event.entindex_inflictor_const) ? EntIndexToHScript(event.entindex_inflictor_const) : undefined;

        if (target.IsRealHero()) {
            const new_treshold = CustomEntitiesLegacy.GetTreshold(target) + event.heal;
            if (new_treshold > this.max_treshold) {
                event.heal = this.max_treshold - CustomEntitiesLegacy.GetTreshold(target);
                CustomEntitiesLegacy.SetTreshold(target, this.max_treshold);
            } else {
                CustomEntitiesLegacy.SetTreshold(target, new_treshold);
            }

            const healing_team = target.GetTeam();
            const healing_alliance = this.FindAllianceByTeam(healing_team);

            if (healing_alliance) {
                Timers.CreateTimer(0.05, function () {
                    healing_alliance.SendDataToClient();
                });
            }
        }

        SendOverheadHealMessage(target, event.heal);
        Timers.CreateTimer(0.05, function () {
            CustomEntitiesLegacy.SendDataToClient(target);
        });
        /*
        const sourceIndex = event.entindex_healer_const;
        let healingReductionPct = 0;
        if(target.healing_reduction_pct){
            healingReductionPct = target.healing_reduction_pct;
        }

        let reduction =  1 - healing_reduction_pct/100;
        if(reduction <= 0){
            reduction = 0.1;
        }
        event.heal = math.floor(event.heal * reduction);
        */

        /*
        if(event.entindex_healer_const){
            healer_index = event.entindex_healer_const;
        }

        const healer;
        if(healer_index){
            healer = EntIndexToHScript(healer_index);
        } else {
            healer = target;
        }
        */
        return true;
    }

    DamageFilter(event: DamageFilterEvent): boolean {
        const attacker = EntIndexToHScript(event.entindex_attacker_const);
        const victim = EntIndexToHScript(event.entindex_victim_const);
        //const damage_type = event.damagetype_const;
        const damage_after_reductions = math.floor(event.damage);
        //const ability = (event.entindex_inflictor_const) ? EntIndexToHScript(event.entindex_inflictor_const) : undefined;

        //Lack of entities handling (illusions error fix)
        if ((attacker && attacker.IsNull()) || (victim && victim.IsNull())) {
            return false;
        }

        if (victim && victim.IsBaseNPC()) {
            ModifierDamageVFX.apply(victim, victim, undefined, {
                duration: 0.1
            });
            Timers.CreateTimer(0.05, function () {
                CustomEntitiesLegacy.SendDataToClient(victim);
            });

            if (victim.IsRealHero()) {
                CustomEntitiesLegacy.SetTreshold(victim, CustomEntitiesLegacy.GetTreshold(victim) - damage_after_reductions);
                if (CustomEntitiesLegacy.GetTreshold(victim) < 0) {
                    CustomEntitiesLegacy.SetTreshold(victim, 0);
                }

                const victim_team = victim.GetTeam();
                const victim_alliance = this.FindAllianceByTeam(victim_team);

                if (victim_alliance) {
                    Timers.CreateTimer(0.05, function () {
                        victim_alliance.SendDataToClient();
                    });
                }
            }
        }

        return true;
    }

    OnPlayerChat(event: PlayerChatEvent): void {
        const playerId = event.playerid;
        const player = this.FindPlayerById(playerId);

        if (event.text == "-unstuck") {
            if (player) {
                const hero = player.hero;
                if (hero) {
                    CustomEntitiesLegacy.SetDirection(hero, 0, 0);
                }
            }
        }

        if (!GameRules.IsCheatMode() && !IsInToolsMode()) {
            return;
        }

        if (event.text == "-refresh") {
            this.RefreshHeroes();
        }

        if (event.text == "-wtf") {
            this.RefreshHeroes();
            this.wtf = true;
        }

        if (event.text == "-unwtf") {
            this.wtf = false;
        }

        if (this.getMode() == "pve") {
            if (!player) {
                return;
            }

            const customNpc = player.customNpc;

            if (!customNpc) {
                return;
            }

            if (event.text == "-favor") {
                RewardsManager.OfferFavorsForHero(customNpc);
            }

            if (event.text == "-shard") {
                RewardsManager.ClaimShards(customNpc);
            }

            if (event.text == "-tome") {
                RewardsManager.ClaimKnowledge(customNpc);
            }

            if (event.text == "-item") {
                RewardsManager.ClaimItems(customNpc);
            }

            if (event.text == "-reward") {
                const rewards = RewardsManager.GenerateRewards(customNpc, {
                    amount: 3
                });
                RewardsManager.OfferRewardsForHero(customNpc, rewards);
            }

            if (event.text == "-vitality") {
                RewardsManager.ClaimVitality(customNpc);
            }
        }

        if (event.text == "-skip") {
            if (this.getMode() == "pve") {
                if (this.run && this.run.stage && this.run.stage.room) {
                    this.run.stage.room.SkipWave();
                }
            }
        }

        if (event.text.split(" ")[0] == "-room") {
            if (!event.text.split(" ")[1]) {
                return;
            }
            if (this.getMode() == "pve") {
                let room = parseInt(event.text.split(" ")[1], 10);
                if (isNaN(room)) {
                    return;
                }
                room = room - 1;

                if (this.run && this.run.stage && this.run.stage.room) {
                    if (this.run.stage.totalNpcRooms > room) {
                        return;
                    }
                    this.run.stage.room.SkipRoom();
                }
            }
        }
    }

    OnLearnedAbilityEvent(event: DotaPlayerLearnedAbilityEvent): void {
        const playerId = event.PlayerID;
        const player = this.FindPlayerById(playerId);

        if (player) {
            const hero = player.hero;

            if (hero) {
                let ready = true;
                this.players.forEach(_player => {
                    const _hero = _player.hero;
                    if (_hero) {
                        if (_hero.GetAbilityPoints() > 0) {
                            ready = false;
                        }
                    }
                });

                if (ready) {
                    if (this.warmup) {
                        if (this.warmup.GetDuration() > 3.0) {
                            this.warmup.SetDuration(3.0);
                        }
                    }
                }

                CustomEntitiesLegacy.SendDataToClient(hero);
            }
        }
    }

    OnGameInProgress(): void {
        this.Start();
    }

    OnNPCInGame(event: NpcSpawnedEvent): boolean {
        const npc = EntIndexToHScript(event.entindex) as CDOTA_BaseNPC;
        if (npc === undefined || npc.IsNull()) {
            return false;
        }

        if (npc.GetName() === "npc_dota_thinker" || npc.GetName() === "npc_dota_base") {
            return true;
        }

        if (CustomEntitiesLegacy.IsInitialized(npc)) {
            return true;
        }

        const customNpc = this.RegisterUnit(npc);

        if (npc.IsRealHero()) {
            const mode = this.getMode();
            if (mode == "pvp") {
                return this.RegisterPlayer(npc, customNpc as CustomPlayerHeroNPC);
            }
            if (mode == "pve" && npc.GetTeamNumber() !== DotaTeam.CUSTOM_1) {
                return this.RegisterPlayer(npc, customNpc as CustomPlayerHeroNPC);
            }
        }

        return true;
    }

    IsPlayerHero(hero: CDOTA_BaseNPC): boolean {
        const playerID = hero.GetPlayerOwnerID();
        return playerID !== -1;
    }

    IncrementWave(): void {
        this.currentRoom = this.currentRoom + 1;
    }

    getMode() {
        return GetMapName() === MapNames.pvp ? MapNames.pvp : GetMapName() === MapNames.pve ? MapNames.pve : "none";
    }

    RegisterUnit(unit: CDOTA_BaseNPC): CustomPlayerHeroNPC | CustomNonPlayerHeroNPC | CustomNPC {
        let customNpc = undefined;

        if (unit.IsRealHero()) {
            if (this.IsPlayerHero(unit)) {
                customNpc = new CustomPlayerHeroNPC(unit);
            } else {
                customNpc = new CustomNonPlayerHeroNPC(unit);
            }
        } else {
            customNpc = new CustomNPC(unit);
        }
        this.units.push(customNpc);
        return customNpc;
    }

    RemoveUnit(unit: CDOTA_BaseNPC): void {
        this.units = this.units.filter(unitEntity => unitEntity.GetUnit() !== unit);
    }

    OnEntityKilled(event: EntityKilledEvent): void {
        const killed = EntIndexToHScript(event.entindex_killed) as CDOTA_BaseNPC;

        if (killed.IsRealHero()) {
            if (this.getMode() == "pvp") {
                this.OnHeroKilledPVP(killed);
            }
            if (!this.IsPlayerHero(killed)) {
                this.SetRespawnTime(killed.GetTeam(), killed as CDOTA_BaseNPC_Hero, 999);
                this.RemoveUnit(killed);
            }
        } else {
            this.RemoveUnit(killed);
        }
    }

    OnHeroKilledPVP(killed: CDOTA_BaseNPC): void {
        if (this.round) {
            this.round.heroDied = true;
            this.CreateDeathOrb(killed);
            this.UpdateCameras();
        }
    }

    OnEntityHurt(event: EntityHurtEvent): void {
        if (event.entindex_killed !== undefined) {
            const victim = EntIndexToHScript(event.entindex_killed) as CDOTA_BaseNPC;
            if (event.entindex_attacker !== undefined) {
                SendOverheadDamageMessage(victim, event.damage);
            }
            CustomEntitiesLegacy.SetBeenHurt(victim, true);
        }
    }

    RefreshHeroes(): void {
        this.players.forEach(player => {
            if (player.hero && !player.hero.IsNull() && player.hero.IsAlive()) {
                giveEnergy(player.hero, CustomEntitiesLegacy.GetMaxEnergy(player.hero), false, false);
                CustomEntitiesLegacy.SendDataToClient(player.hero);
            }
        });
    }

    UpdateCameras(): void {
        this.players.forEach(player => {
            const hero = player.hero;
            if (hero && !hero.IsAlive() && player.alliance) {
                const aliveAlly = this.FindNextAliveAlly(player.alliance);

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

    FindNextAliveAlly(alliance: Alliance) {
        return alliance.players.find(player => player.hero?.IsAlive())?.hero;
    }

    FindNextAliveHero() {
        return this.players.map(player => player.hero).find(hero => hero?.IsAlive());
    }

    FindPlayerById(playerId: PlayerID): Player | undefined {
        return this.players.filter(player => player.GetId() === playerId)[0];
    }

    SetRespawnTime(team: DotaTeam, victim: CDOTA_BaseNPC_Hero, time: number): void {
        victim.SetTimeUntilRespawn(time);
    }

    public GetCursorPositionForPlayer(playerId: PlayerID): Vector {
        const player = this.FindPlayerById(playerId);

        if (player) {
            return player.GetCursorPosition();
        }

        return Vector(0, 0);
    }

    CreateDeathOrb(hero: CDOTA_BaseNPC): void {
        const current_mana = hero.GetMana();
        const origin = hero.GetAbsOrigin();
        const mana_given = NearestValue([25, 50, 75, 100], current_mana);
        const entity = new Pickup(PickupTypes.DEATH, hero.GetOrigin(), mana_given / 100 + 0.25);

        this.round?.pickupWrappers.push({
            origin,
            type: PickupTypes.DEATH,
            timer: -1,
            entity: entity
        });

        entity.GetItem()?.SetCurrentCharges(mana_given);
        entity.GetItem()?.SetPurchaser(hero);
    }

    EndGame(victoryTeam: DotaTeam): void {
        GameRules.SetGameWinner(victoryTeam);
    }

    UpdateProjectiles() {
        // This is neccesary to work with script_reload...
        updateProjectiles();
    }

    // eslint-disable-next-line @typescript-eslint/no-empty-function
    public Reload(): void {}
}

Object.assign(getfenv(), {
    Activate: GameMode.Activate,
    Precache: GameMode.Precache
});

if (GameRules.Addon !== undefined) {
    GameRules.Addon.Reload();
}

function update() {
    GameRules.Addon.UpdateProjectiles();
    GameRules.Addon.OnThink();
}

function onNativeStateChange(state: GameState) {
    print(`Native state changed to ${state}`);

    if (state == GameState.CUSTOM_GAME_SETUP) {
        // Need to wait a frame otherwise player in tools doesn't connect
        Timers.CreateTimer(() => {
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

    if (state === GameState.GAME_IN_PROGRESS) {
        GameRules.Addon.OnGameInProgress();
    }
}
