/* eslint-disable @typescript-eslint/no-non-null-assertion */
import UnitEntity from './unit_entity';

enum CustomNPCState {
    IDLE = 0,
    WANDERING,
    RESTING,
}

enum CustomNPCBehavior {
    FOLLOWER = 0,
    WANDERER,
}

interface CustomNPCAbilityRequirements {
    cooldownReady?: boolean;
    phaseReady?: boolean;
    targetInCastRange?: boolean;
    targetInRadius?: boolean;
}

interface CustomNPCAbility {
    ability: CDOTABaseAbility;
    priority: number;
    requirements: CustomNPCAbilityRequirements;
    cast(ability: CDOTABaseAbility, target: CDOTA_BaseNPC | undefined): void;
    orderType: UnitOrder;
}

interface CustomNPCAbilityFactoryOptions {
    ability: CDOTABaseAbility;
    orderType: UnitOrder;
    requirements?: CustomNPCAbilityRequirements;
}

interface CustomNPCOptions {
    followRange?: number;
    minFollowRange?: number;
    restTime?: number;
    behavior?: CustomNPCBehavior;
}

export class CustomNPC extends UnitEntity{
    state = CustomNPCState.IDLE ;
    abilities: CustomNPCAbility[] = [];
    followRange: number;
    minFollowRange: number;
    restTime: number;
    remainingRestTime = 0;
    rangeOfAction = 3000;
    restDirection: Vector | undefined;
    behavior: CustomNPCBehavior;
    originalPosition: Vector;
    targetPosition: Vector | undefined;

    constructor(origin: Vector, name: string, options: CustomNPCOptions){
        super({properties: {
            origin,
            name, 
            team: DotaTeam.CUSTOM_1,
        }});
        this.restTime = options.restTime || 1.0;
        this.followRange = options.followRange || 2500;
        this.minFollowRange = options.minFollowRange || 0;
        this.behavior = options.behavior || CustomNPCBehavior.FOLLOWER;
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

    IsAbilityReady(ability: CDOTABaseAbility): boolean{
        return ability.IsCooldownReady() && !ability.IsInAbilityPhase();
    }

    AbilityFactory(options: CustomNPCAbilityFactoryOptions): CustomNPCAbility{
        const npcAbility: CustomNPCAbility = {
            ability: options.ability,
            orderType: options.orderType,
            priority: this.abilities.length + 1,
            cast: (ability: CDOTABaseAbility, target: CDOTA_BaseNPC) => {
                ExecuteOrderFromTable({
                    OrderType: options.orderType,
                    UnitIndex: this.GetUnit().GetEntityIndex(),
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
        return npcAbility;
    }

    AddAbility(npcAbility: CustomNPCAbility): void{
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
        
        let abilityToExecute: CustomNPCAbility | undefined = undefined; 
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
            abilityToExecute = abilityToExecute as CustomNPCAbility;
            abilityToExecute.cast(abilityToExecute.ability, abilityTarget);
            this.StartRest(this.restTime);
            return true;
        } else {
            return false;
        }
    }

    Follow(origin: Vector): boolean{
        const target = this.FindEnemy(this.followRange);
        if(!target){
            return false;
        }
        const distance = CustomEntitiesLegacy.GetDistance(this.unit, target);
        let direction = Vector(0,0);

        if(target.IsAlive() && distance > this.minFollowRange){
            direction = (target.GetAbsOrigin().__sub(origin)).Normalized();
        }
        
        CustomEntitiesLegacy.SetDirection(this.unit, direction.x, direction.y);
        return true;
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

    Update(): void{
        const origin = this.unit.GetAbsOrigin();

        if(this.remainingRestTime > 0){
            this.remainingRestTime = this.remainingRestTime - 1;
        } 
        if(!this.Cast()){
            if(this.behavior === CustomNPCBehavior.WANDERER){
                if(this.state === CustomNPCState.WANDERING && this.targetPosition){
                    if(!this.MoveTowards(origin, this.targetPosition)){
                        this.state = CustomNPCState.IDLE;
                        this.ClearTargetPosition();
                        this.StopMoving();
                    }
                } else {
                    this.state = CustomNPCState.WANDERING;
                    this.PickTargetPosition(origin);
                }
            } else {
                this.Follow(origin);
            }
        } else {
            this.remainingRestTime = 1.0 * 30;
            this.ClearTargetPosition();
            this.StopMoving();
        }
        /*
        if(this.remainingRestTime > 0){
            this.remainingRestTime = this.remainingRestTime - 1;

            if(this.state !== CustomNPCState.RESTING){
                this.state = CustomNPCState.RESTING;
            }

            if(this.wanderer){
                if(this.restDirection == undefined){
                    this.restDirection = Vector(RandomFloat(-1.0, 1.0), RandomFloat(-1.0, 1.0));
                    CustomEntitiesLegacy.SetDirection(this.unit, this.restDirection.x, this.restDirection.y);
                }
            }

            return;
        } else {
            this.restDirection = undefined;
        }

        if(this.unit.HasModifier('modifier_casting') || CustomEntitiesLegacy.IsChanneling(this.unit)){
            this.state = CustomNPCState.CASTING;
        } else { 
            this.state = CustomNPCState.READY;
        }

        if(this.state == CustomNPCState.READY){
            let direction = Vector(0,0);

            if(this.backToCenter){
                if((this.unit.GetAbsOrigin().__sub(Vector(0,0,0))).Length2D() < 10){
                    direction = Vector(0,0);
                } else {
                    direction = (Vector(0,0,0).__sub(this.unit.GetAbsOrigin())).Normalized();
                }
            } else {
                direction = Vector(RandomFloat(-1.0, 1.0), RandomFloat(-1.0, 1.0));
            }

            const target = this.FindEnemy(this.followRange);
            if(target){
                const distance = CustomEntitiesLegacy.GetDistance(this.unit, target);

                if(target.IsAlive() && distance > this.minFollowRange){
                    direction = (target.GetAbsOrigin().__sub(this.unit.GetAbsOrigin())).Normalized();
                } else {
                    direction = Vector(0,0);
                }
            }

            if(!CustomEntitiesLegacy.IsDisplacing(this.unit)){
                let abilityToExecute: CustomNPCAbility | undefined = undefined; 
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
                    abilityToExecute = abilityToExecute as CustomNPCAbility;
                    abilityToExecute.cast(abilityToExecute.ability, abilityTarget);
                    this.StartRest(this.restTime);
                }
            }

            if(this.wanderer){
                CustomEntitiesLegacy.SetDirection(this.unit, direction.x, direction.y);
            }
        }
    */
    }
}
export class DireZombie extends CustomNPC{
    constructor(origin: Vector){    
        super(origin, 'dire_zombie', {
            minFollowRange: 500,
            behavior: CustomNPCBehavior.WANDERER,
        });
        
        this.AddAbility(this.AbilityFactory({
            ability: this.unit.FindAbilityByName('dire_zombie_attack')!,
            orderType: UnitOrder.CAST_POSITION,
            requirements: {
                targetInCastRange: true
            }
        }));
    }
}
export class Centaur extends CustomNPC{
    constructor(origin: Vector){    
        super(origin, 'npc_dota_hero_centaur', {});
        
        this.AddAbility(this.AbilityFactory({
            ability: this.unit.FindAbilityByName('centaur_axe_attack')!,
            orderType: UnitOrder.CAST_POSITION,
            requirements: {
                targetInRadius: true
            }
        }));
        this.AddAbility(this.AbilityFactory({
            ability: this.unit.FindAbilityByName('centaur_range_attack')!,
            orderType: UnitOrder.CAST_POSITION,
            requirements: {
                targetInCastRange: true,
            }
        }));
        this.AddAbility(this.AbilityFactory({
            ability: this.unit.FindAbilityByName('centaur_short_attack')!,
            orderType: UnitOrder.CAST_NO_TARGET,
            requirements: {
                targetInRadius: true
            }
        }));
        this.AddAbility(this.AbilityFactory({
            ability: this.unit.FindAbilityByName('centaur_charge')!,
            orderType: UnitOrder.CAST_POSITION,
            requirements: {
                targetInCastRange: true,
            }
        }));
        this.AddAbility(this.AbilityFactory({
            ability: this.unit.FindAbilityByName('centaur_rage')!,
            orderType: UnitOrder.CAST_NO_TARGET,
        }));
    }
}
export class Queen extends CustomNPC{
    constructor(origin: Vector){    
        super(origin, 'npc_dota_hero_queenofpain', {
            minFollowRange: 500
        });
        
        this.AddAbility(this.AbilityFactory({
            ability: this.unit.FindAbilityByName('queen_scream')!,
            orderType: UnitOrder.CAST_NO_TARGET,
        }));
        this.AddAbility(this.AbilityFactory({
            ability: this.unit.FindAbilityByName('queen_dodge')!,
            orderType: UnitOrder.CAST_NO_TARGET,
        }));
        this.AddAbility(this.AbilityFactory({
            ability: this.unit.FindAbilityByName('queen_blink')!,
            orderType: UnitOrder.CAST_POSITION,
            requirements: {
                targetInCastRange: true,
            }
        }));
        this.AddAbility(this.AbilityFactory({
            ability: this.unit.FindAbilityByName('queen_daggers')!,
            orderType: UnitOrder.CAST_NO_TARGET,
        }));
        this.AddAbility(this.AbilityFactory({
            ability: this.unit.FindAbilityByName('queen_attack')!,
            orderType: UnitOrder.CAST_POSITION,
            requirements: {
                targetInCastRange: true,
            }
        }));
        this.AddAbility(this.AbilityFactory({
            ability: this.unit.FindAbilityByName('queen_wave')!,
            orderType: UnitOrder.CAST_POSITION,
            requirements: {
                targetInCastRange: true
            }
        }));
    }
}
