import Alliance from './clases/alliance';
import { CustomGameState } from './clases/game_state';
import Warmup from './clases/warmup';
import { reloadable } from './lib/tstl-utils';
import './wrappers/abilities';
import './wrappers/modifiers';
import './util/custom_abilities';
import './util/custom_entities_legacy';
import './util/math';
import './util/util';
import './settings';
import './constructors';
import './abilities_meta';
import './libraries/timers';
import './libraries/projectiles';
import './overrides/abilities';
import Player from './clases/player';
import PreRound from './clases/pre_round';
import Round from './clases/round';
import Hero from './clases/hero';
import { CustomItems } from './util/custom_items';
import Pickup, { PickupTypes } from './clases/pickup';
import Wave, { WaveGroup, NPCNames } from './clases/wave';
import settings from './settings';
import PreWave from './clases/pre_wave';

declare global {
    interface CDOTAGamerules {
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

const Custom_MapNames = {
    ['PVP']: 'pvp',
    ['PVE']: 'pve',
};

enum Custom_ActionTypes {
    MOVEMENT = 0,
    ABILITY = 1,
} 

enum Custom_ActionModes {
    START = 0,
    STOP = 1,
}

const DOTA_ALLIANCE_RADIANT = 1;
const DOTA_ALLIANCE_DIRE = 2;
const DOTA_ALLIANCE_LEGION = 3;
const DOTA_ALLIANCE_VOID = 4;

const THINK_PERIOD = 0.01;

@reloadable
export class GameMode{
    private players: Player[] = [];
    private heroes: Hero[] = [];
    private state = CustomGameState.NONE;
    private thinkers: Thinker[] = [];
    private wtf = false;
    private units: CDOTA_BaseNPC[] = [];

    public alliances: Alliance[] = [];
    public warmup: Warmup | undefined;
    public pre_round: PreRound | undefined;
    public waveGroups: WaveGroup[] = [];
    public wave: Wave | undefined;
    public pre_wave: PreWave | undefined;
    public round: Round | undefined;
    public max_treshold = 30;
    public currentWave = 0;

    constructor(){
        GameRules.GetGameModeEntity().SetContextThink('OnThink', () => { return this.OnThink(); }, THINK_PERIOD);
        
        this.SetupEventHooks();
        this.SetupPanoramaEventHooks();
        this.SetupRules();
        this.LinkModifiers();
        this.SetupFilters();
       
        const mode = GameRules.GetGameModeEntity();
        mode.SetBuybackEnabled(false);
        mode.SetDaynightCycleDisabled(true);
        mode.SetCameraDistanceOverride(1350);
    }

    // eslint-disable-next-line @typescript-eslint/no-empty-function
    public static Precache(this: void, context: CScriptPrecacheContext): void{
        PrecacheResource('soundfile', 'soundevents/game_sounds_heroes/game_sounds_oracle.vsndevts', context);
        PrecacheResource('soundfile', 'soundevents/game_sounds_heroes/game_sounds_magnataur.vsndevts', context);
        PrecacheResource('soundfile', 'soundevents/game_sounds_heroes/game_sounds_silencer.vsndevts', context);
        PrecacheResource('soundfile', 'soundevents/game_sounds_heroes/game_sounds_furion.vsndevts', context);
        PrecacheResource('soundfile', 'soundevents/game_sounds_heroes/game_sounds_phoenix.vsndevts', context);
        PrecacheResource('soundfile', 'soundevents/game_sounds_heroes/game_sounds_sven.vsndevts', context);
        PrecacheResource('soundfile', 'soundevents/game_sounds_heroes/game_sounds_abaddon.vsndevts', context);
        PrecacheResource('soundfile', 'soundevents/game_sounds_heroes/game_sounds_zuus.vsndevts', context);
        PrecacheResource('soundfile', 'soundevents/game_sounds_heroes/game_sounds_doombringer.vsndevts', context);
        PrecacheResource('soundfile', 'soundevents/game_sounds_items.vsndevts', context);

        PrecacheResource('particle', 'particles/units/heroes/hero_chen/chen_hand_of_god.vpcf', context);
        PrecacheResource('particle', 'particles/units/heroes/hero_chen/chen_divine_favor_buff.vpcf', context);
        PrecacheResource('particle', 'particles/base_attacks/ranged_badguy_persistent_glow_green.vpcf', context);
        PrecacheResource('particle', 'particles/units/heroes/hero_wisp/wisp_overcharge_c.vpcf', context);
        PrecacheResource('particle', 'models/items/rubick/rubick_arcana/sfm/particles/rubick_arcana_temp_2_rocks_glow.vpcf', context);
        PrecacheResource('particle', 'particles/units/heroes/hero_omniknight/omniknight_purification_cast_b.vpcf', context);
        
        PrecacheResource('particle', 'particles/items_fx/arcane_boots_recipient.vpcf', context);
        PrecacheResource('particle', 'particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp_magical.vpcf', context);
        PrecacheResource('particle', 'particles/units/heroes/hero_abaddon/abaddon_aphotic_shield_explosion.vpcf', context);

        const heroes: any = LoadKeyValues('scripts/npc/npc_heroes_custom.txt');
        for(const key in heroes){
            const hero = heroes[key];
            PrecacheUnitByNameSync(hero.override_hero, context);
        }
    }

    public static Activate(this: void): void{
        GameRules.Addon = new GameMode();
    }

    public Start(): void{
        this.alliances.push(new Alliance(DOTA_ALLIANCE_RADIANT, [DotaTeam.GOODGUYS, DotaTeam.BADGUYS]));
        this.alliances.push(new Alliance(DOTA_ALLIANCE_DIRE, [DotaTeam.CUSTOM_1, DotaTeam.CUSTOM_2, DotaTeam.NEUTRALS]));
        this.alliances.push(new Alliance(DOTA_ALLIANCE_LEGION, [DotaTeam.CUSTOM_3, DotaTeam.CUSTOM_4]));
        this.alliances.push(new Alliance(DOTA_ALLIANCE_VOID, [DotaTeam.CUSTOM_5, DotaTeam.CUSTOM_6]));

        if(this.IsPVP()){
            this.StartPVPMap();
        } else if(this.IsPVE()){
            this.StartPVEMap();
        }

        this.RegisterThinker(0.01, () => {
            CustomGameEventManager.Send_ServerToAllClients('get_mouse_position', {} as never);
            this.heroes.forEach(hero => {
                hero.Update();
            });
        });
    }
    
    StartPVPMap(): void{
        this.CreateBarrels();
        this.SetState(CustomGameState.WARMUP_IN_PROGRESS);
        this.warmup = new Warmup(this.alliances, settings.FirstWarmupDuration);

        const tableName = 'main' as never;
        const data = { max_score: settings.RoundsDifferenceToWin } as never;
        CustomNetTables.SetTableValue(tableName, 'maxScore', data);
        
        this.RegisterThinker(0.01, () => {
            if(this.state == CustomGameState.WARMUP_IN_PROGRESS && this.warmup){
                this.warmup.Update();
            }
            if(this.state == CustomGameState.PRE_ROUND && this.pre_round){
                this.pre_round.Update();
            }

            if(this.state == CustomGameState.ROUND_IN_PROGRESS && this.round){
                this.round.Update();
            }
        });
    }

    StartPVEMap(): void{
        this.SetState(CustomGameState.WAVE_IN_PROGRESS);
        this.waveGroups = [
            {
                name: NPCNames.DIRE_ZOMBIE,
                ammount: 10,
            },
            {
                name: NPCNames.QUEEN,
                ammount: 1,
            },
            {
                name: NPCNames.DIRE_ZOMBIE,
                ammount: 40,
            },
            {
                name: NPCNames.CENTAUR,
                ammount: 1,
            },
        ];

        this.wave = new Wave(this.alliances, -1, [this.waveGroups[this.currentWave]]);
        
        this.RegisterThinker(0.01, () => {
            if(this.state == CustomGameState.WAVE_IN_PROGRESS && this.wave){
                this.wave.Update();
            }
            if(this.state == CustomGameState.PRE_WAVE && this.pre_wave){
                this.pre_wave.Update();
            }
        });
    }

    OnThink(): number {
        if(GameRules.IsGamePaused()){
            return THINK_PERIOD;
        }
        const now = Time();

        if(GameRules.State_Get() >= GameState.CUSTOM_GAME_SETUP){
            this.thinkers.forEach((thinker) => {
                if(now >= thinker.next){
                    thinker.next = math.max(thinker.next + thinker.period, now);
                    thinker.callback();
                }
            });
        }

        return THINK_PERIOD;
    }

    SetupRules(): void{
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

        if(this.IsPVP()){
            this.SetupRulesPVP();
        } else if(this.IsPVE()){
            this.SetupRulesPVE();
        }
        print('[AMETHYST] GameRules set');
    }
    
    SetupRulesPVP(): void{
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.GOODGUYS, 1);
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.BADGUYS, 1);
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.CUSTOM_1, 1);
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.CUSTOM_2, 1);
        GameRules.SetHeroRespawnEnabled(false);
    }

    SetupRulesPVE(): void{
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.GOODGUYS, 2);
        GameRules.SetCustomGameTeamMaxPlayers(DotaTeam.BADGUYS, 2);
        GameRules.SetHeroRespawnEnabled(true);
        GameRules.GetGameModeEntity().SetFixedRespawnTime(5.0);
    }
    
    SetupEventHooks(): void{
        ListenToGameEvent('npc_spawned', (event) => this.OnNPCInGame(event), undefined);
        ListenToGameEvent('game_rules_state_change',  () => this.OnGameRulesStateChange(), undefined);
        ListenToGameEvent('dota_player_learned_ability', (event) => this.OnLearnedAbilityEvent(event), undefined);
        ListenToGameEvent('player_chat', (event) => this.OnPlayerChat(event), undefined);
        ListenToGameEvent('entity_killed', (event) => this.OnEntityKilled(event), undefined);
        ListenToGameEvent('entity_hurt', (event) => this.OnEntityHurt(event), undefined);

        print('[AMETHYST] Event hooks set');
    }

    SetupPanoramaEventHooks(): void{
        CustomGameEventManager.RegisterListener<CustomActionEvent>('update_mouse_position', (eventSourceIndex, args) => {
            const position = Vector(args.x, args.y, args.z);
            const playerId = args.playerId;
            const player = this.FindPlayerById(playerId);
            if(player){
                player.UpdateCursorPosition(position);
            }
        });
            
        CustomGameEventManager.RegisterListener('key_released', (eventSourceIndex, args) => {
            //const unit = EntIndexToHScript(args.entityIndex)
        });

        CustomGameEventManager.RegisterListener<CustomActionEvent>('custom_action', (eventSourceIndex, event) => {
            const playerId = event.playerIndex;
            const player = this.FindPlayerById(playerId);

            if(player){
                const hero = player.hero;

                const type = event.payload.type;
                const mode = event.payload.mode;
                
                if(type == Custom_ActionTypes.MOVEMENT && hero){
                    const currentDirection = CustomEntitiesLegacy.GetRawDirection(hero);
                    const incomingDirection = event.payload.direction;
                    let vector = Vector(incomingDirection['0'], incomingDirection['1'], 0);

                    if(mode == Custom_ActionModes.STOP){
                        vector = vector.__mul(-1);
                    }

                    const newDirection = currentDirection.__add(vector);
                    newDirection.z = hero.GetForwardVector().z;
                    CustomEntitiesLegacy.SetDirection(hero, newDirection.x, newDirection.y);
                }
            }
        });

        CustomGameEventManager.RegisterListener<CustomActionEvent>('refund_points', (eventSourceIndex, event) => {
            const playerId = event.playerIndex;
            const player = this.FindPlayerById(playerId);

            if(player){
                const hero = player.hero;

                if(hero){
                    for(let i = 0; i <= 23; i++){
                        const ability = hero.GetAbilityByIndex(i);
                        if(ability){
                            if(ability.GetAbilityType() !== 2){
                                ability.SetLevel(1); //THIS WILL LEVEL THE STATS TALENTS!
                            }
                        }
                    }

                    hero.SetAbilityPoints(settings.AbilityPoints);
                    CustomEntitiesLegacy.SendDataToClient(hero);
                }
            }

            if(this.warmup){
                this.warmup.SetDuration(this.warmup.GetDuration() + 10.0);
            }
        });

        CustomGameEventManager.RegisterListener<CustomActionEvent>('swap_r_f', (eventSourceIndex, event) => {
            const playerId = event.playerIndex;
            const player = this.FindPlayerById(playerId);

            if(player){
                const hero = player.hero;
                if(hero){
                    const ability_name_one = hero.GetAbilityByIndex(5)!.GetName();
                    const ability_name_two = hero.GetAbilityByIndex(6)!.GetName();
                    hero.SwapAbilities(ability_name_one, ability_name_two, true, true);
                }
            }
        });
    }

    SetupFilters(): void{
        const mode = GameRules.GetGameModeEntity();
        mode.SetModifyGoldFilter(this.ModifyGoldFilter, this);
        mode.SetExecuteOrderFilter(this.ExecuteOrderFilter, this);
        mode.SetModifyExperienceFilter(this.ModifyExperienceFilter, this);
        mode.SetHealingFilter(this.HealingFilter, this);
        mode.SetDamageFilter(this.DamageFilter, this);
        print('[AMETHYST] Filters set');
    }
   
    LinkModifiers(): void{
        LinkLuaModifier('modifier_death_zone',                      'modifiers/modifier_death_zone.lua', LuaModifierMotionType.NONE);
        LinkLuaModifier('wall_base',                                'modifiers/wall_base.lua', LuaModifierMotionType.NONE);
        LinkLuaModifier('modifier_adrenaline',                      'modifiers/modifier_adrenaline.lua', LuaModifierMotionType.NONE);
        LinkLuaModifier('radius_marker_thinker',                    'modifiers/radius_marker_thinker.lua', LuaModifierMotionType.NONE);
        LinkLuaModifier('modifier_ruby',                            'modifiers/modifier_ruby.lua', LuaModifierMotionType.NONE);
        LinkLuaModifier('modifier_ruby_attack',                     'modifiers/modifier_ruby.lua', LuaModifierMotionType.NONE);
        LinkLuaModifier('modifier_sapphire',                        'modifiers/modifier_sapphire.lua', LuaModifierMotionType.NONE);
        LinkLuaModifier('modifier_emerald',                         'modifiers/modifier_emerald.lua', LuaModifierMotionType.NONE);
        LinkLuaModifier('modifier_amethyst',                        'modifiers/modifier_amethyst.lua', LuaModifierMotionType.NONE);
        LinkLuaModifier('modifier_miss',                            'modifiers/modifier_miss.lua', LuaModifierMotionType.NONE);
        LinkLuaModifier('modifier_restricted',                      'modifiers/modifier_restricted.lua', LuaModifierMotionType.NONE);

        LinkLuaModifier('modifier_generic_silence',                 'abilities/generic/modifier_generic_silence', LuaModifierMotionType.NONE);
        LinkLuaModifier('modifier_generic_fading_slow',             'abilities/generic/modifier_generic_fading_slow', LuaModifierMotionType.NONE);
        LinkLuaModifier('modifier_generic_fading_haste',            'abilities/generic/modifier_generic_fading_haste', LuaModifierMotionType.NONE);
        LinkLuaModifier('modifier_generic_stunned',                 'abilities/generic/modifier_generic_stunned', LuaModifierMotionType.NONE);
        LinkLuaModifier('modifier_generic_provides_vision',         'abilities/generic/modifier_generic_provides_vision', LuaModifierMotionType.NONE);
        LinkLuaModifier('modifier_generic_knockback',               'abilities/generic/modifier_generic_knockback', LuaModifierMotionType.BOTH);
        LinkLuaModifier('modifier_generic_root',                    'abilities/generic/modifier_generic_root', LuaModifierMotionType.NONE);
        LinkLuaModifier('modifier_generic_invencible',              'abilities/generic/modifier_generic_invencible', LuaModifierMotionType.NONE);
        LinkLuaModifier('modifier_generic_confuse',                 'abilities/generic/modifier_generic_confuse', LuaModifierMotionType.NONE);
        LinkLuaModifier('modifier_generic_sleep',                   'abilities/generic/modifier_generic_sleep', LuaModifierMotionType.NONE);
        LinkLuaModifier('modifier_generic_fear',                    'abilities/generic/modifier_generic_fear', LuaModifierMotionType.NONE);
        
        LinkLuaModifier('modifier_visible',                         'abilities/base/modifier_visible', LuaModifierMotionType.NONE);
        LinkLuaModifier('modifier_casting',                         'abilities/base/modifier_casting', LuaModifierMotionType.NONE);
        LinkLuaModifier('modifier_damage_fx',                       'abilities/base/modifier_damage_fx', LuaModifierMotionType.NONE);
        LinkLuaModifier('modifier_hero_base',                       'abilities/base/modifier_hero_base', LuaModifierMotionType.NONE);
        LinkLuaModifier('modifier_shield',                          'abilities/base/modifier_shield', LuaModifierMotionType.NONE);
        LinkLuaModifier('modifier_hide_bar',                        'abilities/base/modifier_hide_bar', LuaModifierMotionType.NONE);
        LinkLuaModifier('modifier_hidden',                          'abilities/base/modifier_hidden', LuaModifierMotionType.NONE);
        LinkLuaModifier('modifier_banish',                          'abilities/base/modifier_banish', LuaModifierMotionType.NONE);
        LinkLuaModifier('modifier_hero_movement',                   'abilities/base/modifier_hero_movement', LuaModifierMotionType.NONE);
        
        LinkLuaModifier('modifier_mount',                          'abilities/heroes/common/mount/modifier_mount.lua', LuaModifierMotionType.NONE);
    
        print('[AMETHYST] Useful modifiers linked');
    }

    IsInWTFMode(): boolean{
        return this.wtf;
    }

    public RegisterThinker(period: number, callback: () => void): void{
        const thinker: Thinker = {
            period,
            callback,
            next: Time() + period,
        };

        this.thinkers.push(thinker);
    }

    FindAllianceByTeam(team: DotaTeam): Alliance | undefined{
        let found = undefined;

        this.alliances.forEach((alliance) => {
            alliance.teams.forEach((allianceTeam) => {
                if(allianceTeam === team){
                    found = alliance;
                }
            });
        });

        return found;
    }

    RegisterPlayer(hero: CDOTA_BaseNPC_Hero): boolean{
        const team = hero.GetTeamNumber();
        const playerID = hero.GetPlayerOwnerID();
        const userID = playerID + 1;

        if(playerID == -1){
            hero.Destroy();
            print('ERROR: TRYING TO CREATE AN UNIT ON AN INVALID PLAYER: \n\t playerID: ' + playerID + '\n\t hero: ' + hero.GetName() + '\n\t team: ' + team);
            return false;
        } else {
            let player = this.FindPlayerById(playerID);
            if(!player){
                player = new Player(playerID, userID);
                this.players.push(player);
                const alliance = this.FindAllianceByTeam(team);

                if(!alliance){ 
                    print('ERROR: THE PLAYER TEAM IS NOT PART OF ANY ALLIANCE!');
                    return false;
                }

                player.SetTeam(team);
                player.SetAlliance(alliance);
                player.SetHero(hero);

                alliance.AddPlayer(player);
            }

            return true;
        }
    }
    
    public RegisterUnit(unit: CDOTA_BaseNPC): void{
        this.units.push(unit);
    }
    
    SetState(state: CustomGameState): void{
        this.OnStateEnd(this.state);
        this.state = state;
        const tableName = 'main' as never;
        const data = { gameState: state } as never;
        CustomNetTables.SetTableValue(tableName, 'gameState', data);
    }

    OnStateEnd(state: CustomGameState): void{
        if(state === CustomGameState.ROUND_IN_PROGRESS){
            this.round = undefined;
            this.warmup = new Warmup(this.alliances, settings.WarmupDuration);
        }
        else if(state === CustomGameState.WARMUP_IN_PROGRESS){
            this.warmup = undefined;
            this.pre_round = new PreRound(this.alliances, settings.PreRoundDuration);
        }
        else if(state === CustomGameState.PRE_ROUND){
            this.pre_round = undefined;
            this.round = new Round(this.alliances, settings.RoundDuration);    
        }
        else if(state === CustomGameState.PRE_WAVE){
            this.pre_wave = undefined;
            this.IncrementWave();

            const waveGroup = this.waveGroups[this.currentWave];
            if(waveGroup){
                this.wave = new Wave(this.alliances, -1, [waveGroup]);
            } else {
                this.EndGame(0);
            }
        }
        else if(state === CustomGameState.WAVE_IN_PROGRESS){
            this.wave = undefined;
            this.pre_wave = new PreWave(this.alliances, settings.PreRoundDuration);    
        }
    }

    CreateBarrels(): CDOTA_BaseNPC[]{
        const barrelEnts = Entities.FindAllByName('wall_spawn');
        const barrels: CDOTA_BaseNPC[] = [];

        barrelEnts.forEach((entity) => {
            barrels.push(this.CreateBarrel(entity.GetAbsOrigin()));
        });

        return barrels;
    }

    CreateBarrel(origin: Vector): CDOTA_BaseNPC{
        const fowBlocker = SpawnEntityFromTableSynchronous('point_simple_obstruction', { origin: origin, block_fow: true});
        const barrel = CreateUnitByName(
            'npc_dota_creature_wall',
            origin,
            false,
            undefined,
            undefined,
            DotaTeam.NOTEAM
        );
        barrel.Attribute_SetIntValue('barrel', 1);
        barrel.SetHullRadius(65);
        barrel.AddNewModifier(barrel, undefined, 'wall_base', { fow_blocker: fowBlocker.GetEntityIndex() });
        return barrel;
    }

    public OnPickedUp(item: CDOTA_Item): void{
        const parent = CustomItems.GetInstance().GetParent(item);
        if(parent){
            parent.OnPickedUp();
        }
    }

    ModifyExperienceFilter(): boolean{
        return false;
    }

    ExecuteOrderFilter(this: this, event: ExecuteOrderFilterEvent): boolean{
        const orderType = event.order_type;

        if (orderType === UnitOrder.CAST_POSITION || 
            orderType === UnitOrder.CAST_TARGET || 
            orderType === UnitOrder.CAST_TARGET_TREE || 
            orderType === UnitOrder.CAST_NO_TARGET
        ){
            const ability = EntIndexToHScript(event.entindex_ability) as CDOTA_Ability_Lua;
            const caster = EntIndexToHScript(event.units['0']) as CDOTA_BaseNPC;
            const energyCost = CustomAbilities.GetEnergyCost(ability);
            const energy = CustomEntitiesLegacy.GetEnergy(caster);

            if(energyCost > energy){ 
                CustomGameEventManager.Send_ServerToAllClients('not_enough_energy', {} as never);
                return false;
            }

            if(orderType === UnitOrder.CAST_POSITION){
                const point = Vector(
                    event.position_x,
                    event.position_y,
                    event.position_z
                );
                const current_range = (point.__sub(caster.GetAbsOrigin())).Length2D();
                const direction = (point.__sub(caster.GetAbsOrigin())).Normalized();
                const max_range = ability.GetCastRange(Vector(0,0,0), undefined);

                if(!CustomAbilities.HasBehavior(ability, AbilityBehavior.IMMEDIATE)){
                    CustomEntitiesLegacy.FullyFaceTowards(caster, direction);
                }

                if(current_range > max_range){
                    const new_point = caster.GetAbsOrigin().__add(direction.__mul(max_range - 10));
                    event.position_x = new_point.x;
                    event.position_y = new_point.y;
                }

                return true;
            }
        }

        if(orderType === UnitOrder.STOP || orderType === UnitOrder.HOLD_POSITION){
            const caster = EntIndexToHScript(event.units['0']) as CDOTA_BaseNPC;
            const ability = caster.GetCurrentActiveAbility() as CDOTA_Ability_Lua;
            if(ability){
                if(ability.GetAbilityType() === 1){
                    return false;
                }
            }
        }
        if(orderType === UnitOrder.HOLD_POSITION){
            print('YOU ARE HOLDING POSITION; PROBABLY YOU WANT TO STOP INSTEAD');
        }
        if(orderType === UnitOrder.MOVE_TO_POSITION || orderType === UnitOrder.MOVE_TO_TARGET){
            return false;
        }
    
        return true;
    }

    ModifyGoldFilter(): boolean{
        return false;
    }

    HealingFilter(this: this, event: HealingFilterEvent): boolean{
        const target = EntIndexToHScript(event.entindex_target_const) as CDOTA_BaseNPC;
        //const ability = (event.entindex_inflictor_const) ? EntIndexToHScript(event.entindex_inflictor_const) : undefined;

        if(target.IsRealHero()){
            const new_treshold = CustomEntitiesLegacy.GetTreshold(target) + event.heal;
            if(new_treshold > this.max_treshold){
                event.heal = this.max_treshold - CustomEntitiesLegacy.GetTreshold(target);
                CustomEntitiesLegacy.SetTreshold(target, this.max_treshold);
            } else {
                CustomEntitiesLegacy.SetTreshold(target, new_treshold);
            }
            
            SendOverheadHealMessage(target, event.heal);
            Timers.CreateTimer(0.05, function(){
                CustomEntitiesLegacy.SendDataToClient(target);
            });
            
            const healing_team = target.GetTeam();
            const healing_alliance = this.FindAllianceByTeam(healing_team);

            if(healing_alliance){
                Timers.CreateTimer(0.05, function(){
                    healing_alliance.SendDataToClient();
                });
            }
        }
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

    DamageFilter(event: DamageFilterEvent): boolean{
        const attacker = EntIndexToHScript(event.entindex_attacker_const) as CDOTA_BaseNPC;
        const victim = EntIndexToHScript(event.entindex_victim_const) as CDOTA_BaseNPC;
        //const damage_type = event.damagetype_const;
        const damage_after_reductions = math.floor(event.damage);
        //const ability = (event.entindex_inflictor_const) ? EntIndexToHScript(event.entindex_inflictor_const) : undefined;

        //Lack of entities handling (illusions error fix)
        if((attacker && attacker.IsNull()) || (victim && victim.IsNull())){
            return false;
        }
        
        if(victim && victim.IsRealHero()){
            CustomEntitiesLegacy.SetTreshold(victim, CustomEntitiesLegacy.GetTreshold(victim) - damage_after_reductions);
            if(CustomEntitiesLegacy.GetTreshold(victim) < 0){
                CustomEntitiesLegacy.SetTreshold(victim, 0);
            }

            victim.AddNewModifier(victim, undefined, 'modifier_damage_fx', { duration: 0.1 });
            Timers.CreateTimer(0.05, function(){
                CustomEntitiesLegacy.SendDataToClient(victim);
            });
            
            const victim_team = victim.GetTeam();
            const victim_alliance = this.FindAllianceByTeam(victim_team);

            if(victim_alliance){
                Timers.CreateTimer(0.05, function(){
                    victim_alliance.SendDataToClient();
                });
            }
        }
        
        return true;
    }


    OnGameRulesStateChange(): void{
        const state = GameRules.State_Get();

        if(state === GameState.GAME_IN_PROGRESS){
            this.OnGameInProgress();
        }
    }
    
    OnPlayerChat(event: PlayerChatEvent): void{
        if(event.text == '-unstuck'){
            const playerId = event.playerid;
            const player = this.FindPlayerById(playerId);
            
            if(player){
                const hero = player.hero;
                if(hero){
                    CustomEntitiesLegacy.SetDirection(hero, 0,0);
                }
            }
        }

        if(!GameRules.IsCheatMode() && !IsInToolsMode()){
            return;
        }

        if(event.text == '-refresh'){
            this.RefreshHeroes();
        }

        if(event.text == '-wtf'){
            this.RefreshHeroes();
            this.wtf = true;
        }

        if(event.text == '-unwtf'){
            this.wtf = false;
        }

        if(event.text == '-skip'){
            if(this.IsPVE()){
                if(this.wave){
                    this.wave.npcs.forEach((npc) => {
                        if(npc.GetUnit().IsAlive()){
                            npc.GetUnit().ForceKill(false);
                        }
                    });
                }
            }
        }
    }
    
    OnLearnedAbilityEvent(event: DotaPlayerLearnedAbilityEvent): void{
        const playerId = event.PlayerID;
        const player = this.FindPlayerById(playerId);
        
        if(player){
            const hero = player.hero;

            if(hero){
                let ready = true;
                this.players.forEach((_player) => {
                    const _hero = _player.hero;
                    if(_hero){
                        if(_hero.GetAbilityPoints() > 0){
                            ready = false;
                        }
                    }
                });

                if(ready){
                    if(this.warmup){
                        if(this.warmup.GetDuration() > 3.0){
                            this.warmup.SetDuration(3.0);
                        }
                    }
                }

                CustomEntitiesLegacy.SendDataToClient(hero);
            }
        }
    }

    OnGameInProgress(): void{
        this.Start();
    }

    OnNPCInGame(event: NpcSpawnedEvent): boolean{
        const npc = EntIndexToHScript(event.entindex) as CDOTA_BaseNPC;
        if(npc === undefined || npc.IsNull()){ 
            return false;
        }

        if(!CustomEntitiesLegacy.IsInitialized(npc)){
            if(!(npc.GetName() === 'npc_dota_thinker')){
                if(npc.IsRealHero()){
                    this.heroes.push(new Hero(npc));
                    CustomEntitiesLegacy.Initialize(npc);
                    if(this.IsPVP()){
                        return this.OnHeroInGamePVP(npc);
                    } else if(this.IsPVE()){
                        return this.OnHeroInGamePVE(npc);
                    }
                } else {
                    if(this.IsPVP()){
                        CustomEntitiesLegacy.Initialize(npc);
                        return true;//this.OnNPCInGamePVP(npc);
                    } else if(this.IsPVE()){
                        CustomEntitiesLegacy.Initialize(npc, true);
                        return true;//return this.OnNPCInGamePVE(npc);
                    }
                }
            }
        }

        return true;
    }

    IncrementWave(): void{
        this.currentWave = this.currentWave + 1;
    }

    IsPVP(): boolean{
        return GetMapName() === Custom_MapNames.PVP;
    }

    IsPVE(): boolean{
        return GetMapName() === Custom_MapNames.PVE;
    }

    OnHeroInGamePVE(hero: CDOTA_BaseNPC_Hero): boolean{
        if(hero.GetTeamNumber() !== DotaTeam.CUSTOM_1){
            if(!this.RegisterPlayer(hero)){
                return false;
            }
        }
        return true;
    }

    OnHeroInGamePVP(hero: CDOTA_BaseNPC_Hero): boolean{
        if(!this.RegisterPlayer(hero)){
            return false;
        }
        return true;
    }

    OnEntityKilled(event: EntityKilledEvent): void{
        const killed = EntIndexToHScript(event.entindex_killed) as CDOTA_BaseNPC;

        if(GetMapName() == Custom_MapNames.PVE){
            //this.OnEntityKilledPVE(killed)
        }

        const parent = CustomEntitiesLegacy.GetParent(killed);
        if(parent){
            const killer = EntIndexToHScript(event.entindex_attacker);
            parent.OnDeath({ killer });
            if(this.IsPVE() && this.wave){ //This will trigger when summoned units dies :()
                this.wave.aliveNpcs = this.wave.aliveNpcs - 1;
            }
        } else {
            if(killed.IsRealHero()){
                if(this.IsPVP()){
                    this.OnEntityKilledPVP(killed);
                }
            }
        }
    }

    OnEntityKilledPVE(killed: CDOTA_BaseNPC): void{
        /*
        if(killed.GetParentEntity){
            const entity = killed.GetParentEntity();
            
            if(instanceof(entity, Boss)){
                if(instanceof(entity, Centaur)){
                    this.boss = Queen(Vector(150, 0, 128));
                } else if(instanceof(entity, Queen)){
                    this.boss = Centaur(Vector(150, 0, 128));
                }
            }
            this.SetRespawnTime(killed.GetTeam(), killed, 999)
        }
        */
    }
    
    OnEntityKilledPVP(killed: CDOTA_BaseNPC): void{
        if(this.round){
            this.round.hero_died = true;
            this.CreateDeathOrb(killed);
            this.UpdateCameras();
        }
    }
    
    OnEntityHurt(event: EntityHurtEvent): void{
        if(event.entindex_attacker !== undefined && event.entindex_killed !== undefined){
            const victim = EntIndexToHScript(event.entindex_killed) as CDOTA_BaseNPC;
            SendOverheadDamageMessage(victim, event.damage);
        }
    }
    
    RefreshHeroes(): void{
        this.players.forEach((player) => {
            if(player.hero && !player.hero.IsNull() && player.hero.IsAlive()){
                CustomEntitiesLegacy.GiveEnergy(player.hero, CustomEntitiesLegacy.GetMaxEnergy(player.hero));
                CustomEntitiesLegacy.SendDataToClient(player.hero);
            }
        });
    }

    UpdateCameras(): void{
        this.players.forEach((player) => {
            const hero = player.hero;
            if (hero && !hero.IsAlive() && player.alliance){
                const aliveAlly = this.FindNextAliveAlly(player.alliance);

                if(aliveAlly){
                    PlayerResource.SetCameraTarget(hero.GetPlayerID(), aliveAlly);
                    aliveAlly.AddNewModifier(hero, undefined, 'modifier_generic_provides_vision', {});
                } else {
                    const aliveHero = this.FindNextAliveHero();
                    if(aliveHero){
                        PlayerResource.SetCameraTarget(hero.GetPlayerID(), aliveHero);
                        aliveHero.AddNewModifier(hero, undefined, 'modifier_generic_provides_vision', {});
                    }
                }
            }
        });
    }

    FindNextAliveAlly(alliance: Alliance): CDOTA_BaseNPC_Hero | undefined{
        const player = alliance.players.filter((_player) => _player.hero && _player.hero.IsAlive())[0];
        if(player){
            return player.hero;
        }
        return undefined;
    }

    FindNextAliveHero(): CDOTA_BaseNPC_Hero | undefined{
        const player = this.players.filter((player) => player.hero && player.hero.IsAlive())[0];
        if(player){
            return player.hero;
        }
        return undefined;
    }

    FindPlayerById(playerId: PlayerID): Player | undefined{
        return this.players.filter((player) => player.GetId() === playerId)[0];
    }

    SetRespawnTime(team: DotaTeam, victim: CDOTA_BaseNPC_Hero, time: number): void{
        victim.SetTimeUntilRespawn(time);
    }

    public GetCursorPositionForPlayer(playerId: PlayerID): Vector{
        const player = this.FindPlayerById(playerId);

        if(player){
            return player.GetCursorPosition();
        }

        return Vector(0,0);
    }
        
    CreateDeathOrb(hero: CDOTA_BaseNPC): void{
        const current_mana = hero.GetMana();
        const origin = hero.GetAbsOrigin();
        const mana_given = NearestValue([25, 50, 75, 100], current_mana);
        const entity = new Pickup(PickupTypes.DEATH, hero.GetOrigin(), (mana_given/100) + 0.25);

        this.round!.pickupWrappers.push({
            origin,
            type: PickupTypes.DEATH,
            timer: -1,
            entity: entity
        });

        entity.GetItem()!.SetCurrentCharges(mana_given);
        entity.GetItem()!.SetPurchaser(hero);
    }

    EndGame(victoryTeam: DotaTeam): void{
        GameRules.SetGameWinner(victoryTeam);
    }

    // eslint-disable-next-line @typescript-eslint/no-empty-function
    public Reload(): void{
    }
}

Object.assign(getfenv(), {
    Activate: GameMode.Activate,
    Precache: GameMode.Precache,
});

if (GameRules.Addon) {
    GameRules.Addon.Reload();
}