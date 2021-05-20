import UnitEntity from './unit_entity';
import Math from '../util/math';
import customEntities from '../util/custom_entities';

const DEBUG = false;

enum CollisionTypes {
    SUCCESS = 0,
    UNIT,
    WALL,
    TREE,
}

enum Orientations {
    NONE = 0,
    DIAGONAL_LEFT,
    DIAGONAL_RIGHT,
    HORIZONTAL,
    VERTICAL,
}
export default class CustomNPC extends UnitEntity{
    constructor(unit: CDOTA_BaseNPC){
        CustomEntitiesLegacy.Initialize(unit, !unit.IsRealHero()); //Need this for SetParent bullshit
        super({ unit });
        this.LevelAllAbilities(1);
        if(this.unit.IsRealHero()){
            this.unit.SetAbilityPoints(2);
        }
        customEntities.Disarm(this.unit);
        customEntities.IgnoreMSLimit(this.unit);
    }
    LevelAllAbilities(level: number): void{
        for(let i = 0; i <= 23; i++){
            const ability = this.unit.GetAbilityByIndex(i);
            if(ability){
                if(CustomAbilitiesLegacy.IsNotTalentNorAttribute(ability)){
                    ability.SetLevel(level);
                }
            }
        }
    }
    Move(direction: Vector, speed: number): CollisionTypes{
        const offset = 70;
        const origin = this.unit.GetAbsOrigin();
        const futureOrigin = origin.__add(direction.__mul(speed));
        const testOrigin = futureOrigin.__add(direction.__mul(offset));
        futureOrigin.z = GetGroundPosition(futureOrigin, this.unit).z;
        const normal = CustomEntitiesLegacy.GetNormal(this.unit, futureOrigin);

        if(IsInToolsMode() && DEBUG){
            DebugDrawLine_vCol(futureOrigin, testOrigin, Vector(255,0,0), true, 1.0);
            DebugDrawLine_vCol(futureOrigin, futureOrigin.__add(normal.__mul(200)), Vector(255,255,255), true, 1);
            DebugDrawCircle(futureOrigin, Vector(255,0,0), 5, offset, false, 0.03);
        }

        if(this.unit.HasModifier('modifier_spectre_special_attack_buff')){
            this.unit.SetAbsOrigin(futureOrigin);
            return CollisionTypes.SUCCESS;
        }
        
        const trees = GridNav.GetAllTreesAroundPoint(testOrigin, 5, true);
        
        if(normal.z <= 0.9){
            return CollisionTypes.WALL;
        }
        if(trees.length > 0){
            return CollisionTypes.TREE;
        }

        if(!this.unit.IsPhased()){
            const units = FindUnitsInRadius(
                this.unit.GetTeamNumber(),
                testOrigin,
                undefined,
                5,
                UnitTargetTeam.BOTH,
                UnitTargetType.ALL,
                UnitTargetFlags.NONE,
                FindOrder.ANY,
                false
            );

            for(let i = 0; i < units.length; i++){
                const unit = units[i];
                if(unit !== this.unit){
                    if(!unit.IsPhased()){
                        return CollisionTypes.UNIT;
                    }
                }
            }
        }

        if(!CustomEntitiesLegacy.IsAnimating(this.unit)){
            if(!this.unit.HasModifier('modifier_hero_movement')){
                this.unit.AddNewModifier(this.unit, undefined, 'modifier_hero_movement', {});
            }
        }

        this.unit.SetAbsOrigin(futureOrigin);
        return CollisionTypes.SUCCESS;
    }
    AlternativeDirectionsWalls(direction: Vector): Vector[]{
        const directions: Vector[] = [];
        const collisionDirection = CustomEntitiesLegacy.GetCollisionDirection(this.unit);
        const angle = VectorToAngles(direction).y;

        if(Math.IsNorthEast(angle)){
            if(collisionDirection === Orientations.DIAGONAL_LEFT){
                return directions;
            }
            directions.push(Math.NORTH);
            directions.push(Math.EAST);
        } 
        if(Math.IsNorthWest(angle)){
            if(collisionDirection === Orientations.DIAGONAL_RIGHT){
                return directions;
            }
            if(collisionDirection === Orientations.DIAGONAL_LEFT){
                directions.push(Math.NORTH);
                directions.push(Math.WEST);
                return directions;
            }
            if(collisionDirection === Orientations.VERTICAL){
                directions.push(Math.NORTH);
                directions.push(Math.WEST);
                return directions;
            }
            directions.push(Math.NORTH);
            directions.push(Math.WEST);
        } 
        if(Math.IsSouthEast(angle)){
            if(collisionDirection === Orientations.DIAGONAL_RIGHT){
                return directions;
            }
            if(collisionDirection === Orientations.DIAGONAL_LEFT){
                directions.push(Math.SOUTH);
                directions.push(Math.EAST);
            }
            if(collisionDirection === Orientations.HORIZONTAL){
                directions.push(Math.EAST);
                directions.push(Math.SOUTH);
            }
            if(collisionDirection === Orientations.VERTICAL){
                directions.push(Math.SOUTH);
                directions.push(Math.EAST);
            }
        } 
        if(Math.IsSouthWest(angle)){
            if(collisionDirection === Orientations.HORIZONTAL){
                directions.push(Math.WEST);
                directions.push(Math.SOUTH);
            }
            if(collisionDirection === Orientations.DIAGONAL_RIGHT){
                directions.push(Math.SOUTH_WEST);
                directions.push(Math.WEST);
                directions.push(Math.SOUTH);
            }
            if(collisionDirection === Orientations.VERTICAL){
                directions.push(Math.SOUTH);
                directions.push(Math.WEST);
            }
        } 
        if(Math.IsEast(angle)){
            if(collisionDirection === Orientations.DIAGONAL_RIGHT){
                directions.push(Math.NORTH_EAST);
                directions.push(Math.NORTH);
            }
            if(collisionDirection === Orientations.DIAGONAL_LEFT){
                directions.push(Math.SOUTH_EAST);
                directions.push(Math.SOUTH);
            }
        }
        if(Math.IsWest(angle)){
            if(collisionDirection === Orientations.DIAGONAL_RIGHT){
                directions.push(Math.SOUTH_EAST);
                directions.push(Math.SOUTH);
            }
            if(collisionDirection === Orientations.DIAGONAL_LEFT){
                directions.push(Math.NORTH_WEST);
                directions.push(Math.NORTH);
            }
            if(collisionDirection === Orientations.HORIZONTAL){
                directions.push(Math.SOUTH);
                directions.push(Math.NORTH);
            }
        } 
        if(Math.IsNorth(angle)){
            if(collisionDirection === Orientations.DIAGONAL_RIGHT){
                directions.push(Math.NORTH_EAST);
                directions.push(Math.EAST);
            }
            if(collisionDirection === Orientations.HORIZONTAL){
                return directions;
            }
            if(collisionDirection === Orientations.DIAGONAL_LEFT){
                directions.push(Math.WEST);
            }
            if(collisionDirection === Orientations.VERTICAL){
                directions.push(Math.NORTH_WEST);
                directions.push(Math.WEST);
            }
        }
        if(Math.IsSouth(angle)){
            if(collisionDirection === Orientations.HORIZONTAL){
                return directions;
            }
            if(collisionDirection === Orientations.DIAGONAL_RIGHT){
                directions.push(Math.SOUTH_WEST);
                directions.push(Math.WEST);
            }
            if(collisionDirection === Orientations.DIAGONAL_LEFT){
                directions.push(Math.SOUTH_EAST);
                directions.push(Math.EAST);
            }
            if(collisionDirection === Orientations.VERTICAL){
                directions.push(Math.EAST);
            }
        }

        return directions;
    }
    AlternativeDirections(direction: Vector): Vector[]{
        const directions = [];
        const angle = VectorToAngles(direction).y;

        if(Math.IsNorthEast(angle)){
            directions.push(Math.NORTH);
            directions.push(Math.EAST);
        } 
        if(Math.IsNorthWest(angle)){
            directions.push(Math.NORTH);
            directions.push(Math.WEST);
        } 
        if(Math.IsSouthEast(angle)){
            directions.push(Math.SOUTH);
            directions.push(Math.EAST);
        } 
        if(Math.IsSouthWest(angle)){
            directions.push(Math.SOUTH);
            directions.push(Math.WEST);
        } 
        if(Math.IsEast(angle) || Math.IsWest(angle)){
            if(this.unit.GetAbsOrigin().y < 0){
                directions.push(Math.SOUTH);
                directions.push(Math.NORTH);
            }
            
            if(this.unit.GetAbsOrigin().y > 0){
                directions.push(Math.NORTH);
                directions.push(Math.SOUTH);
            }
        } 
        if(Math.IsNorth(angle) || Math.IsSouth(angle)){
            if(this.unit.GetAbsOrigin().x < 0){
                directions.push(Math.WEST);
            }
            if(this.unit.GetAbsOrigin().x > 0){
                directions.push(Math.EAST);
            }
        }
        return directions;
    }
    Update(): void{
        const direction = CustomEntitiesLegacy.GetDirection(this.unit).Normalized();
        const speed = (this.unit.GetIdealSpeed()/25);

        if(CustomEntitiesLegacy.IsAnimating(this.unit)){
            this.unit.RemoveModifierByName('modifier_hero_movement');
        }

        if((direction.x !== 0 || direction.y !== 0) && CustomEntitiesLegacy.CanWalk(this.unit)){
            const output = this.Move(direction, speed);
            if(output !== CollisionTypes.SUCCESS){
                let alternativeDirections: Vector[] = [];
                
                if(output === CollisionTypes.WALL){
                    alternativeDirections = this.AlternativeDirectionsWalls(direction);
                } else {
                    alternativeDirections = this.AlternativeDirections(direction);
                }	

                for(let i = 0; i < alternativeDirections.length; i++){
                    const alternativeDireaction = alternativeDirections[i]; 
                    const newOutput = this.Move(alternativeDireaction, speed * 0.8);
                    if(newOutput === CollisionTypes.SUCCESS){
                        break;
                    }
                }
            }
    
            if(	!this.unit.HasModifier('modifier_casting') && 
                !this.unit.HasModifier('modifier_mars_counter_countering') && 
                !this.unit.HasModifier('modifier_spectre_counter_countering')
            ){ 
                CustomEntitiesLegacy.FullyFaceTowards(this.unit, direction);
            }
        } else {
            this.unit.RemoveModifierByName('modifier_hero_movement');
        }

        if(IsInToolsMode() && DEBUG){
            if((this.unit as CDOTA_BaseNPC_Hero).GetPlayerID){
                const player = GameRules.Addon.FindPlayerById((this.unit as CDOTA_BaseNPC_Hero).GetPlayerID());

                if(player){
                    const mouse = player.GetCursorPosition();
                    DebugDrawLine_vCol(this.unit.GetAbsOrigin(), this.unit.GetAbsOrigin().__add(this.unit.GetForwardVector().__mul(500)), Vector(0,0,255), true, 0.03);
                    DebugDrawLine_vCol(this.unit.GetAbsOrigin(), mouse, Vector(0,255,0), true, 0.03);
                }
            }
        }
    }
    OnDeath(params: { killer: CDOTA_BaseNPC }): void{
        super.OnDeath(params);
        this.Destroy(false);
    }
}

export class CustomHeroNPC extends CustomNPC{
    constructor(unit: CDOTA_BaseNPC){
        super(unit);
        customEntities.HideHealthBar(this.unit);
        customEntities.SetUseEnergy(this.unit);
    }
}
export class CustomPlayerHeroNPC extends CustomHeroNPC{
    constructor(unit: CDOTA_BaseNPC){
        super(unit);
        customEntities.HideHealthBar(this.unit);
        customEntities.SetUseEnergy(this.unit);

        if(GameRules.Addon.IsPVE()){
            this.LevelAllAbilities(0);
            this.unit.GetAbilityByIndex(0)?.SetLevel(1);
            this.unit.GetAbilityByIndex(6)?.SetLevel(1);
        }
    }
    
    Update(): void{
        super.Update();
        if(this.unit.IsAlive()){
            this.PickupItems();
        }
    }

    PickupItems(): void{
        const dropItems = Entities.FindAllByClassnameWithin('dota_item_drop', this.unit.GetAbsOrigin(), this.unit.GetHullRadius() * 2.5);
        dropItems.forEach((drop) => {
            const item = (drop as CDOTA_Item_Physical).GetContainedItem();
            const owner = item.GetPurchaser();
            
            //Only pickup items owned by teammates
            if(!owner || (owner && CustomEntitiesLegacy.Allies(this.unit, owner) && this.unit !== owner)){
                this.unit.AddItem(item);
                item.OnSpellStart();

                GameRules.Addon.OnPickedUp(item);
                UTIL_Remove(drop);
            }

        });
    }
}

/*
CheckState()
	return { 
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true 
	} 
}

DeclareFunctions()
    return {
		MODIFIER_EVENT_ON_SPENT_MANA,
		MODIFIER_PROPERTY_DISABLE_AUTOATTACK,
		MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
		MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
    }
}

OnSpentMana(event)
	CustomEntitiesLegacy.SendDataToClient(this.GetParent())
}

OnAbilityFullyCast(params)
	if(IsServer()){
		if(params.unit !== this.GetParent()){
			return
		}

		if(!GameRules.Addon:IsInWTFMode()){
			CustomEntitiesLegacy.GiveEnergy(params.unit, -params.ability:GetEnergyCost())
		}
	}
}

GetDisableAutoAttack()						return true	}
GetModifierIgnoreMovespeedLimit(params)		return 1	}
*/