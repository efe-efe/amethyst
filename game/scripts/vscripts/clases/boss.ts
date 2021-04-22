import UnitEntity from './unit_entity';

enum CustomNPCState {
    READY = 0,
    CASTING = 1,
    RESTING = 2,
}

interface CustomNPCAbility {
    ability: CDOTABaseAbility;
    priority: number;
    requirements: any;
    cast?(ability: CDOTABaseAbility, target: CDOTA_BaseNPC): void;
    orderType: UnitOrder;
}

class CustomNPC extends UnitEntity{
    state = CustomNPCState.READY;
    abilities: CustomNPCAbility[] = [];
    followRange = 750;
    abilitiesRange = 2500;
    wanderer = true;
    backToCenter = true;
    restTime: number;
    remainingRestTime = 0;
    restDirection: Vector | undefined;
    unit: CDOTA_BaseNPC;

    constructor(origin: Vector, name: string, restTime = 1.0){
        super(origin, name, DotaTeam.CUSTOM_1);
        this.unit = this.GetUnit();
        this.restTime = restTime;
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

    RegisterAbility(npcAbility: CustomNPCAbility): void{
        npcAbility.cast = (ability: CDOTABaseAbility, target: CDOTA_BaseNPC) => {
            ExecuteOrderFromTable({
                OrderType: npcAbility.orderType,
                UnitIndex: this.GetUnit().GetEntityIndex(),
                AbilityIndex: ability.GetEntityIndex(),
                Position: target && target.GetAbsOrigin() || undefined,
            }); 
        };
        this.abilities.push(npcAbility);
    }

    StartRest(restTime: number): void{
        this.remainingRestTime = restTime * 30;
    }

    Update(){
        if(this.remainingRestTime > 0){
            this.remainingRestTime = this.remainingRestTime - 1;

            if(this.state !== CustomNPCState.RESTING){
                this.state = CustomNPCState.RESTING;
            }

            if(this.wanderer){
                if(this.restDirection == undefined){
                    this.restDirection = Vector(RandomFloat(-1.0, 1.0), RandomFloat(-1.0, 1.0));
                    CustomEntities.SetDirection(this.unit, this.restDirection.x, this.restDirection.y);
                }
            }

            return;
        } else {
            this.restDirection = undefined;
        }

        if(this.unit.HasModifier('modifier_casting') || CustomEntities.IsChanneling(this.unit)){
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

            let target = this.FindEnemy(this.followRange);

            if(target){
                const distance = CustomEntities.GetDistance(this.unit, target);

                if(target.IsAlive() && distance > 250){
                    direction = (target.GetAbsOrigin().__sub(this.unit.GetAbsOrigin())).Normalized();
                }
            }

            if(!CustomEntities.IsDisplacing(this.unit)){
                target = this.FindEnemy(this.abilitiesRange);

                let abilityToExecute: CustomNPCAbility | undefined = undefined; 
                this.abilities.forEach((npcAbility) => {
                    if(npcAbility.requirements(npcAbility.ability, target)){
                        if(abilityToExecute == undefined){
                            abilityToExecute = npcAbility;
                        }
                        if(npcAbility.priority > abilityToExecute.priority){
                            abilityToExecute = npcAbility;
                        }
                    }
                });
                if(abilityToExecute){
                    abilityToExecute.cast(abilityToExecute.ability, target);
                    this.StartRest(this.restTime);
                }
            }

            if(this.wanderer){
                CustomEntities.SetDirection(this.unit, direction.x, direction.y);
            }
        }
    }
}

export class Centaur extends CustomNPC{
    constructor(origin: Vector){    
        super(origin, 'npc_dota_hero_centaur', 1.0);
        
        this.RegisterAbility({
            ability: this.unit.FindAbilityByName('centaur_short_attack')!,
            priority: 3,
            orderType: UnitOrder.CAST_NO_TARGET,
            requirements: (ability: CDOTABaseAbility, target: CDOTA_BaseNPC) => {
                if(target){
                    const distance = CustomEntities.GetDistance(this.unit, target);
                    return (target && CustomEntities.GetDistance(this.unit, target) <= ability.GetSpecialValueFor('radius') && this.IsAbilityReady(ability));
                } else {
                    return false;
                }
            },
        });
        this.RegisterAbility({
            ability: this.unit.FindAbilityByName('centaur_range_attack')!,
            priority : 1,
            orderType: UnitOrder.CAST_POSITION,
            requirements: (ability: CDOTABaseAbility, target: CDOTA_BaseNPC) => {
                return (target && this.IsAbilityReady(ability));
            },
        });
        this.RegisterAbility({
            ability: this.unit.FindAbilityByName('centaur_charge')!,
            priority : 4,
            orderType: UnitOrder.CAST_POSITION,
            requirements: (ability: CDOTABaseAbility, target: CDOTA_BaseNPC) => {
                return (target && this.IsAbilityReady(ability));
            },
        });
        this.RegisterAbility({
            ability: this.unit.FindAbilityByName('centaur_rage')!,
            priority : 5,
            orderType: UnitOrder.CAST_NO_TARGET,
            requirements: (ability: CDOTABaseAbility) => {
                return this.IsAbilityReady(ability); 
            },
        });
        this.RegisterAbility({
            ability: this.unit.FindAbilityByName('centaur_axe_attack')!,
            priority : 2,
            orderType: UnitOrder.CAST_POSITION,
            requirements: (ability: CDOTABaseAbility, target: CDOTA_BaseNPC) => {
                if(target){
                    const distance = CustomEntities.GetDistance(this.unit, target);
                    return CustomEntities.GetDistance(this.unit, target) <= ability.GetSpecialValueFor('radius') && this.IsAbilityReady(ability);
                } else {
                    return false;
                }
            },
        });
    }
}

export class Queen extends CustomNPC{
    constructor(origin: Vector){    
        super(origin, 'npc_dota_hero_queenofpain', 1.0);
        
        this.RegisterAbility({
            ability: this.unit.FindAbilityByName('queen_dodge')!,
            priority : 0,
            orderType: UnitOrder.CAST_NO_TARGET,
            requirements: (ability: CDOTABaseAbility) => {
                return this.IsAbilityReady(ability); 
            },
        });
        this.RegisterAbility({
            ability: this.unit.FindAbilityByName('queen_wave')!,
            priority : 1,
            orderType: UnitOrder.CAST_POSITION,
            requirements: (ability: CDOTABaseAbility, target: CDOTA_BaseNPC) => {
                return (target && this.IsAbilityReady(ability));
            },
        });
        this.RegisterAbility({
            ability: this.unit.FindAbilityByName('queen_blink')!,
            priority : 2,
            orderType: UnitOrder.CAST_POSITION,
            requirements: (ability: CDOTABaseAbility, target: CDOTA_BaseNPC) => {
                return (target && this.IsAbilityReady(ability));
            },
        });
        this.RegisterAbility({
            ability: this.unit.FindAbilityByName('queen_daggers')!,
            priority : 3,
            orderType: UnitOrder.CAST_NO_TARGET,
            requirements: (ability: CDOTABaseAbility) => {
                return this.IsAbilityReady(ability); 
            },
        });
        this.RegisterAbility({
            ability: this.unit.FindAbilityByName('queen_scream')!,
            priority : 4,
            orderType: UnitOrder.CAST_NO_TARGET,
            requirements: (ability: CDOTABaseAbility) => {
                return this.IsAbilityReady(ability); 
            },
        });
        this.RegisterAbility({
            ability: this.unit.FindAbilityByName('queen_attack')!,
            priority : 5,
            orderType: UnitOrder.CAST_POSITION,
            requirements: (ability: CDOTABaseAbility, target: CDOTA_BaseNPC) => {
                return (target && this.IsAbilityReady(ability));
            },
        });
    }
}
