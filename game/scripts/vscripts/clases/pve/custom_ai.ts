/* eslint-disable @typescript-eslint/no-non-null-assertion */
enum CustomAIState {
    IDLE = 0,
    WANDERING,
    RESTING,
}

enum CustomAIBehavior {
    FOLLOWER = 0,
    WANDERER,
    STATIC,
}

export enum CustomAITier {
    BASIC = 1,
    MID,
    HIGH,
    BOSS,
}

export enum NPCNames {
    DIRE_ZOMBIE = 0,
    DIRE_ZOMBIE_RAGER,
    DIRE_ZOMBIE_MEELE,
    RADIANT_ZOMBIE_HEALER,
    RADIANT_ZOMBIE_MEELE,
    FLYING_SKULL,
    DIRE_TOWER,
    QUEEN,
    CENTAUR,
}
interface CustomAIAbilityRequirements {
    cooldownReady?: boolean;
    phaseReady?: boolean;
    targetInCastRange?: boolean;
    targetInRadius?: boolean;
}

interface CustomAIAbility {
    ability: CDOTABaseAbility;
    priority: number;
    requirements: CustomAIAbilityRequirements;
    cast(ability: CDOTABaseAbility, target: CDOTA_BaseNPC | undefined): void;
    orderType: UnitOrder;
}

interface CustomAIRegisterAbilityOptions {
    ability: CDOTABaseAbility;
    orderType: UnitOrder;
    requirements?: CustomAIAbilityRequirements;
}

interface CustomAIOptions {
    followRange?: number;
    minFollowRange?: number;
    restTime?: number;
    behavior?: CustomAIBehavior;
}

export class CustomAI{
    state = CustomAIState.IDLE ;
    abilities: CustomAIAbility[] = [];
    followRange: number;
    tauntedFollowRange: number;
    tauntedDuration = 3.0;
    tauntedRemainingDuration = 0.0;
    minFollowRange: number;
    restTime: number;
    remainingRestTime = 0;
    rangeOfAction = 3000;
    restDirection: Vector | undefined;
    behavior: CustomAIBehavior;
    originalPosition: Vector;
    targetPosition: Vector | undefined;
    unit: CDOTA_BaseNPC;
    followTarget: CDOTA_BaseNPC | undefined;

    constructor(name: string, origin: Vector, options: CustomAIOptions){
        this.unit = CreateUnitByName(
            name,
            origin,
            true,
            undefined,
            undefined,
            DotaTeam.CUSTOM_1
        );

        this.restTime = options.restTime || 1.0;
        this.followRange = options.followRange || 2500;
        this.tauntedFollowRange = this.followRange * 1.5;
        this.minFollowRange = options.minFollowRange || 0;
        this.behavior = options.behavior || CustomAIBehavior.FOLLOWER;
        this.originalPosition = origin;
    }

    FindEnemy(radius: number): CDOTA_BaseNPC | undefined{
        const units = FindUnitsInRadius(
            this.unit.GetTeamNumber(),
            this.unit.GetAbsOrigin(),
            undefined,
            radius,
            UnitTargetTeam.ENEMY, 
            UnitTargetType.HERO + UnitTargetType.BASIC, 
            UnitTargetFlags.NO_INVIS,
            FindOrder.ANY,
            false
        );

        if(units.length > 0) {
            return units[0];
        } else {
            return undefined;
        }
    }

    UpdateTarget(): void{
        const followRange = (this.tauntedRemainingDuration > 0) ? this.tauntedFollowRange : this.followRange;

        if(this.followTarget){
            if(CustomEntitiesLegacy.GetDistance(this.unit, this.followTarget) <= followRange && !this.followTarget.IsInvisible()){
                return;
            } else {
                this.followTarget = undefined;
            }
        } else {
            this.followTarget = this.FindEnemy(followRange);
        }
    }

    Follow(origin: Vector): boolean{
        this.UpdateTarget();

        if(!this.followTarget || !this.followTarget.IsAlive()){
            return false;
        }
        const distance = CustomEntitiesLegacy.GetDistance(this.unit, this.followTarget);
        let direction = Vector(0,0);

        if(this.followTarget.IsAlive() && distance > this.minFollowRange){
            direction = (this.followTarget.GetAbsOrigin().__sub(origin)).Normalized();
        }
        
        CustomEntitiesLegacy.SetDirection(this.unit, direction.x, direction.y);
        return true;
    }

    IsAbilityReady(ability: CDOTABaseAbility): boolean{
        return ability.IsCooldownReady() && !ability.IsInAbilityPhase();
    }

    RegisterAbility(options: CustomAIRegisterAbilityOptions): void{
        const npcAbility: CustomAIAbility = {
            ability: options.ability,
            orderType: options.orderType,
            priority: this.abilities.length + 1,
            cast: (ability: CDOTABaseAbility, target: CDOTA_BaseNPC) => {
                ExecuteOrderFromTable({
                    OrderType: options.orderType,
                    UnitIndex: this.unit.GetEntityIndex(),
                    AbilityIndex: ability.GetEntityIndex(),
                    Position: target && target.GetAbsOrigin() || undefined,
                }); 
            },
            requirements: (options.requirements) ? {
                ...options.requirements,
                cooldownReady: (options.requirements.cooldownReady !== undefined) ? options.requirements.cooldownReady : true,
                phaseReady: (options.requirements.phaseReady !== undefined) ? options.requirements.phaseReady : true,
            } : {
                cooldownReady: true,
                phaseReady: true,
            }
        };
        this.abilities.push(npcAbility);
    }

    StartRest(restTime: number): void{
        this.remainingRestTime = restTime * 30;
    }

    BackToOrigin(origin: Vector): boolean{
        const distanceFromOrigin = (this.originalPosition.__sub(origin)).Length2D();

        if(this.rangeOfAction > distanceFromOrigin){
            return false;
        }

        const direction = (this.originalPosition.__sub(origin)).Normalized();
        CustomEntitiesLegacy.SetDirection(this.unit, direction.x, direction.y);
        return true;
    }

    Cast(): boolean{
        if(CustomEntitiesLegacy.IsDisplacing(this.unit) || CustomEntitiesLegacy.IsCasting(this.unit) || CustomEntitiesLegacy.IsChanneling(this.unit) || this.remainingRestTime > 0){
            return false;
        }
        
        let abilityToExecute: CustomAIAbility | undefined = undefined; 
        let abilityTarget: CDOTA_BaseNPC | undefined = undefined;
        this.abilities.forEach((npcAbility) => {
            const ability = npcAbility.ability;

            if(npcAbility.requirements){
                if(npcAbility.requirements.cooldownReady){
                    if(!npcAbility.ability.IsCooldownReady()){
                        return false;
                    }
                }
                if(npcAbility.requirements.phaseReady){
                    if(npcAbility.ability.IsInAbilityPhase()){
                        return false;
                    }
                }
                if(npcAbility.requirements.targetInCastRange){
                    abilityTarget = this.FindEnemy(ability.GetCastRange(Vector(0,0,0), undefined));
                    if(!abilityTarget){
                        return false;
                    }
                }
                if(npcAbility.requirements.targetInRadius){
                    abilityTarget = this.FindEnemy(ability.GetSpecialValueFor('radius'));
                    if(!abilityTarget){
                        return false;
                    }
                }
            }
            if(abilityToExecute == undefined){
                abilityToExecute = npcAbility;
            }
            if(npcAbility.priority > abilityToExecute.priority){
                abilityToExecute = npcAbility;
            }
        });

        if(abilityToExecute){
            abilityToExecute = abilityToExecute as CustomAIAbility;
            abilityToExecute.cast(abilityToExecute.ability, abilityTarget);
            this.StartRest(this.restTime);
            return true;
        } else {
            return false;
        }
    }

    StopMoving(): void{
        CustomEntitiesLegacy.SetDirection(this.unit, 0, 0);
    }

    MoveTowards(origin: Vector, point: Vector): boolean{
        const distance = (point.__sub(origin)).Length2D();

        if(distance < 10){
            return false;
        } else {
            const direction = (point.__sub(origin)).Normalized();
            CustomEntitiesLegacy.SetDirection(this.unit, direction.x, direction.y);
            return true;
        }
    }

    PickTargetPosition(origin: Vector): void{
        const worldLimits = 1500;
        const x = Clamp(origin.x + RandomInt(-400, 400), worldLimits, -worldLimits);
        const y = Clamp(origin.y + RandomInt(-400, 400), worldLimits, -worldLimits);
        this.targetPosition = Vector(x, y);
    }

    ClearTargetPosition(): void{
        this.targetPosition = undefined;
    }

    OnHurt(): void{
        this.tauntedRemainingDuration = this.tauntedDuration * 30;
    }

    Update(): void{
        const origin = this.unit.GetAbsOrigin();

        if(this.tauntedRemainingDuration > 0){
            this.tauntedRemainingDuration = this.tauntedRemainingDuration - 1;
        } 
        if(this.remainingRestTime > 0){
            this.remainingRestTime = this.remainingRestTime - 1;
        } 
        if(!this.Cast()){
            if(this.behavior === CustomAIBehavior.STATIC){
                return;
            }
            if(this.behavior === CustomAIBehavior.WANDERER){
                if(this.state === CustomAIState.WANDERING && this.targetPosition){
                    if(!this.MoveTowards(origin, this.targetPosition)){
                        this.state = CustomAIState.IDLE;
                        this.ClearTargetPosition();
                        this.StopMoving();
                    }
                } else {
                    this.state = CustomAIState.WANDERING;
                    this.PickTargetPosition(origin);
                }
            } else {
                if(!this.Follow(origin)){
                    this.StopMoving();
                }
            }
        } else {
            this.remainingRestTime = 1.0 * 30;
            this.ClearTargetPosition();
            this.StopMoving();
        }
    }
}

export const CustomAIMeta: {
    [key: number]: {
        factory: (origin: Vector) => CustomAI,
        tier?: number,
    }
} = {
    [NPCNames.QUEEN]: {
        factory: (origin: Vector): CustomAI => {
            const ai = new CustomAI('npc_dota_hero_queenofpain', origin, {
                minFollowRange: 500,
            });

            ai.RegisterAbility({
                ability: ai.unit.FindAbilityByName('queen_scream')!,
                orderType: UnitOrder.CAST_NO_TARGET,
            });
            ai.RegisterAbility({
                ability: ai.unit.FindAbilityByName('queen_dodge')!,
                orderType: UnitOrder.CAST_NO_TARGET,
            });
            ai.RegisterAbility({
                ability: ai.unit.FindAbilityByName('queen_blink')!,
                orderType: UnitOrder.CAST_POSITION,
                requirements: {
                    targetInCastRange: true,
                }
            });
            ai.RegisterAbility({
                ability: ai.unit.FindAbilityByName('queen_daggers')!,
                orderType: UnitOrder.CAST_NO_TARGET,
            });
            ai.RegisterAbility({
                ability: ai.unit.FindAbilityByName('queen_attack')!,
                orderType: UnitOrder.CAST_POSITION,
                requirements: {
                    targetInCastRange: true,
                }
            });
            ai.RegisterAbility({
                ability: ai.unit.FindAbilityByName('queen_wave')!,
                orderType: UnitOrder.CAST_POSITION,
                requirements: {
                    targetInCastRange: true
                }
            });
            return ai;
        },
        tier: CustomAITier.BOSS,
    },
    [NPCNames.CENTAUR]: {
        factory: (origin: Vector): CustomAI => {
            const ai = new CustomAI('npc_dota_hero_centaur', origin, {});

            ai.RegisterAbility({
                ability: ai.unit.FindAbilityByName('centaur_axe_attack')!,
                orderType: UnitOrder.CAST_POSITION,
                requirements: {
                    targetInRadius: true
                }
            });
            ai.RegisterAbility({
                ability: ai.unit.FindAbilityByName('centaur_range_attack')!,
                orderType: UnitOrder.CAST_POSITION,
                requirements: {
                    targetInCastRange: true,
                }
            });
            ai.RegisterAbility({
                ability: ai.unit.FindAbilityByName('centaur_short_attack')!,
                orderType: UnitOrder.CAST_NO_TARGET,
                requirements: {
                    targetInRadius: true
                }
            });
            ai.RegisterAbility({
                ability: ai.unit.FindAbilityByName('centaur_charge')!,
                orderType: UnitOrder.CAST_POSITION,
                requirements: {
                    targetInCastRange: true,
                }
            });
            ai.RegisterAbility({
                ability: ai.unit.FindAbilityByName('centaur_rage')!,
                orderType: UnitOrder.CAST_NO_TARGET,
            });
            return ai;
        },
        tier: CustomAITier.BOSS,
    },
    [NPCNames.RADIANT_ZOMBIE_HEALER]: {
        factory: (origin: Vector): CustomAI => {
            const ai = new CustomAI('radiant_zombie_healer', origin, {
                behavior: CustomAIBehavior.WANDERER,
            });

            ai.RegisterAbility({
                ability: ai.unit.FindAbilityByName('radiant_zombie_heal_aura')!,
                orderType: UnitOrder.CAST_NO_TARGET,
            });
            ai.RegisterAbility({
                ability: ai.unit.FindAbilityByName('dire_zombie_attack')!,
                orderType: UnitOrder.CAST_POSITION,
                requirements: {
                    targetInCastRange: true
                }
            });
            return ai;
        },
        tier: CustomAITier.MID,
    },
    [NPCNames.DIRE_ZOMBIE]: {
        factory: (origin: Vector): CustomAI => {
            const ai = new CustomAI('dire_zombie', origin, {
                behavior: CustomAIBehavior.WANDERER,
            });

            ai.RegisterAbility({
                ability: ai.unit.FindAbilityByName('dire_zombie_attack')!,
                orderType: UnitOrder.CAST_POSITION,
                requirements: {
                    targetInCastRange: true
                }
            });
            return ai;
        },
        tier: CustomAITier.BASIC,
    },
    [NPCNames.DIRE_ZOMBIE_RAGER]: {
        factory: (origin: Vector): CustomAI => {
        const ai = new CustomAI('dire_zombie_rager', origin, {
            behavior: CustomAIBehavior.WANDERER,
        });

        ai.RegisterAbility({
            ability: ai.unit.FindAbilityByName('dire_zombie_rage_aura')!,
            orderType: UnitOrder.CAST_NO_TARGET,
        });
        ai.RegisterAbility({
            ability: ai.unit.FindAbilityByName('dire_zombie_attack')!,
            orderType: UnitOrder.CAST_POSITION,
            requirements: {
                targetInCastRange: true
            }
        });
        return ai;
        },
        tier: CustomAITier.MID,
    },
    [NPCNames.DIRE_ZOMBIE_MEELE]: {
        factory: (origin: Vector): CustomAI => {
        const ai = new CustomAI('dire_zombie_meele', origin, {
            followRange: 1500,
            minFollowRange: 200,
            behavior: CustomAIBehavior.FOLLOWER,
        });

        ai.RegisterAbility({
            ability: ai.unit.FindAbilityByName('dire_zombie_attack_meele')!,
            orderType: UnitOrder.CAST_POSITION,
            requirements: {
                targetInCastRange: true
            }
        });

        ai.unit.AddNewModifier(ai.unit, undefined, 'modifier_generic_meele_npc', {});
        ai.unit.SetHullRadius(95);
        return ai;
        },
        tier: CustomAITier.MID,
    },
    [NPCNames.RADIANT_ZOMBIE_MEELE]: {
        factory: (origin: Vector): CustomAI => {
        const ai = new CustomAI('radiant_zombie_meele', origin, {
            followRange: 1500,
            minFollowRange: 200,
            behavior: CustomAIBehavior.FOLLOWER,
        });

        ai.RegisterAbility({
            ability: ai.unit.FindAbilityByName('dire_zombie_attack_meele')!,
            orderType: UnitOrder.CAST_POSITION,
            requirements: {
                targetInCastRange: true
            }
        });

        ai.unit.AddNewModifier(ai.unit, undefined, 'modifier_generic_meele_npc', {});
        ai.unit.SetHullRadius(95);
        return ai;
        },
        tier: CustomAITier.BASIC,
    },
    [NPCNames.FLYING_SKULL]: {
        factory: (origin: Vector): CustomAI => {
        const ai = new CustomAI('flying_skull', origin, {
            followRange: 1000,
            minFollowRange: 450,
            behavior: CustomAIBehavior.FOLLOWER,
        });

        ai.RegisterAbility({
            ability: ai.unit.FindAbilityByName('flying_skull_dash')!,
            orderType: UnitOrder.CAST_POSITION,
            requirements: {
                targetInCastRange: true
            }
        });

        return ai;
        },
        tier: CustomAITier.BASIC,
    },
    [NPCNames.DIRE_TOWER]: {
        factory: (origin: Vector): CustomAI => {
        const ai = new CustomAI('dire_tower', origin, {
            behavior: CustomAIBehavior.STATIC,
        });

        ai.RegisterAbility({
            ability: ai.unit.FindAbilityByName('dire_tower_attack')!,
            orderType: UnitOrder.CAST_POSITION,
            requirements: {
                targetInCastRange: true
            }
        });
        ai.unit.SetHullRadius(100);
        return ai;
        },
        tier: CustomAITier.HIGH,
    }
};