import UnitEntity from './unit_entity';

const DEBUG = false;

const EAST = Vector(1, 0, 0);
const WEST = Vector(-1, 0, 0);
const NORTH = Vector(0, 1, 0);
const SOUTH = Vector(0, -1, 0);

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

const NORTH_EAST = Vector(1, 1, 0).Normalized();
const NORTH_WEST = Vector(-1, 1, 0).Normalized();
const SOUTH_EAST = Vector(1, -1, 0).Normalized();
const SOUTH_WEST = Vector(-1, -1, 0).Normalized();

export default class Hero extends UnitEntity{
    constructor(unit: CDOTA_BaseNPC){
        super({ unit });
    }

    Move(direction: Vector, speed: number): CollisionTypes{
        const offset = 70;
        const origin = this.unit.GetAbsOrigin();
        const futureOrigin = origin.__add(direction.__mul(speed));
        const testOrigin = futureOrigin.__add(direction.__mul(offset));
        futureOrigin.z = GetGroundPosition(futureOrigin, this.unit).z;
        const normal = CustomEntities.GetNormal(this.unit, futureOrigin);

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
        
            units.forEach((unit) => {
                if(unit !== this.unit){
                    if(!unit.IsPhased()){
                        return CollisionTypes.UNIT;
                    }
                }
            });
        }

        if(!CustomEntities.IsAnimating(this.unit)){
            if(!this.unit.HasModifier('modifier_hero_movement')){
                this.unit.AddNewModifier(this.unit, undefined, 'modifier_hero_movement', {});
            }
        }

        this.unit.SetAbsOrigin(futureOrigin);
        return CollisionTypes.SUCCESS;
    }
    
    IsEast(angle: number): boolean{
        return angle > 345 || angle <= 15;
    }

    IsNorthEast(angle: number): boolean{
        return angle > 15 && angle <= 75;
    }

    IsNorth(angle: number): boolean{
        return angle > 75 && angle <= 105;
    }

    IsNorthWest(angle: number): boolean{
        return angle > 105 && angle <= 165;
    }

    IsWest(angle: number): boolean{
        return angle > 165 && angle <= 195;
    }

    IsSouthWest(angle: number): boolean{
        return angle > 195 && angle <= 255;
    }

    IsSouth(angle: number): boolean{
        return angle > 255 && angle <= 285;
    }

    IsSouthEast(angle: number): boolean{
        return angle > 285 && angle <= 345;
    }

    AlternativeDirectionsWalls(direction: Vector): Vector[]{
        const directions: Vector[] = [];
        const collisionDirection = CustomEntities.GetCollisionDirection(this.unit);
        const angle = VectorToAngles(direction).y;

        if(this.IsNorthEast(angle)){
            if(collisionDirection === Orientations.DIAGONAL_LEFT){
                return directions;
            }
            directions.push(NORTH);
            directions.push(EAST);
        } 
        if(this.IsNorthWest(angle)){
            if(collisionDirection === Orientations.DIAGONAL_RIGHT){
                return directions;
            }
            if(collisionDirection === Orientations.DIAGONAL_LEFT){
                directions.push(NORTH);
                directions.push(WEST);
                return directions;
            }
            if(collisionDirection === Orientations.VERTICAL){
                directions.push(NORTH);
                directions.push(WEST);
                return directions;
            }
            directions.push(NORTH);
            directions.push(WEST);
        } 
        if(this.IsSouthEast(angle)){
            if(collisionDirection === Orientations.DIAGONAL_RIGHT){
                return directions;
            }
            if(collisionDirection === Orientations.DIAGONAL_LEFT){
                directions.push(SOUTH);
                directions.push(EAST);
            }
            if(collisionDirection === Orientations.HORIZONTAL){
                directions.push(EAST);
                directions.push(SOUTH);
            }
            if(collisionDirection === Orientations.VERTICAL){
                directions.push(SOUTH);
                directions.push(EAST);
            }
        } 
        if(this.IsSouthWest(angle)){
            if(collisionDirection === Orientations.HORIZONTAL){
                directions.push(WEST);
                directions.push(SOUTH);
            }
            if(collisionDirection === Orientations.DIAGONAL_RIGHT){
                directions.push(SOUTH_WEST);
                directions.push(WEST);
                directions.push(SOUTH);
            }
            if(collisionDirection === Orientations.VERTICAL){
                directions.push(SOUTH);
                directions.push(WEST);
            }
        } 
        if(this.IsEast(angle)){
            if(collisionDirection === Orientations.DIAGONAL_RIGHT){
                directions.push(NORTH_EAST);
                directions.push(NORTH);
            }
            if(collisionDirection === Orientations.DIAGONAL_LEFT){
                directions.push(SOUTH_EAST);
                directions.push(SOUTH);
            }
        }
        if(this.IsWest(angle)){
            if(collisionDirection === Orientations.DIAGONAL_RIGHT){
                directions.push(SOUTH_EAST);
                directions.push(SOUTH);
            }
            if(collisionDirection === Orientations.DIAGONAL_LEFT){
                directions.push(NORTH_WEST);
                directions.push(NORTH);
            }
            if(collisionDirection === Orientations.HORIZONTAL){
                directions.push(SOUTH);
                directions.push(NORTH);
            }
        } 
        if(this.IsNorth(angle)){
            if(collisionDirection === Orientations.DIAGONAL_RIGHT){
                directions.push(NORTH_EAST);
                directions.push(EAST);
            }
            if(collisionDirection === Orientations.HORIZONTAL){
                return directions;
            }
            if(collisionDirection === Orientations.DIAGONAL_LEFT){
                directions.push(WEST);
            }
            if(collisionDirection === Orientations.VERTICAL){
                directions.push(NORTH_WEST);
                directions.push(WEST);
            }
        }
        if(this.IsSouth(angle)){
            if(collisionDirection === Orientations.HORIZONTAL){
                return directions;
            }
            if(collisionDirection === Orientations.DIAGONAL_RIGHT){
                directions.push(SOUTH_WEST);
                directions.push(WEST);
            }
            if(collisionDirection === Orientations.DIAGONAL_LEFT){
                directions.push(SOUTH_EAST);
                directions.push(EAST);
            }
            if(collisionDirection === Orientations.VERTICAL){
                directions.push(EAST);
            }
        }

        return directions;
    }

    AlternativeDirections(direction: Vector): Vector[]{
        const directions = [];
        const angle = VectorToAngles(direction).y;

        if(this.IsNorthEast(angle)){
            directions.push(NORTH);
            directions.push(EAST);
        } 
        if(this.IsNorthWest(angle)){
            directions.push(NORTH);
            directions.push(WEST);
        } 
        if(this.IsSouthEast(angle)){
            directions.push(SOUTH);
            directions.push(EAST);
        } 
        if(this.IsSouthWest(angle)){
            directions.push(SOUTH);
            directions.push(WEST);
        } 
        if(this.IsEast(angle) || this.IsWest(angle)){
            if(this.unit.GetAbsOrigin().y < 0){
                directions.push(SOUTH);
                directions.push(NORTH);
            }
            
            if(this.unit.GetAbsOrigin().y > 0){
                directions.push(NORTH);
                directions.push(SOUTH);
            }
        } 
        if(this.IsNorth(angle) || this.IsSouth(angle)){
            if(this.unit.GetAbsOrigin().x < 0){
                directions.push(WEST);
            }
            if(this.unit.GetAbsOrigin().x > 0){
                directions.push(EAST);
            }
        }
        return directions;
    }

    Update(): void{
        const direction = CustomEntities.GetDirection(this.unit).Normalized();
        const speed = (this.unit.GetIdealSpeed()/25);

        
        if(CustomEntities.IsAnimating(this.unit)){
            this.unit.RemoveModifierByName('modifier_hero_movement');
        }

        if((direction.x !== 0 || direction.y !== 0) && CustomEntities.CanWalk(this.unit)){
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
                CustomEntities.FullyFaceTowards(this.unit, direction);
            }
        } else {
            this.unit.RemoveModifierByName('modifier_hero_movement');
        }

        if(this.unit.IsAlive()){
            this.PickupItems();
        }
        
        if(IsInToolsMode() && DEBUG){
            const player = GameRules.Addon.FindPlayerById((this.unit as CDOTA_BaseNPC_Hero).GetPlayerID());

            if(player){
                const mouse = player.GetCursorPosition();
                DebugDrawLine_vCol(this.unit.GetAbsOrigin(), this.unit.GetAbsOrigin().__add(this.unit.GetForwardVector().__mul(500)), Vector(0,0,255), true, 0.03);
                DebugDrawLine_vCol(this.unit.GetAbsOrigin(), mouse, Vector(0,255,0), true, 0.03);
            }
        }
    }

    PickupItems(): void{
        const dropItems = Entities.FindAllByClassnameWithin('dota_item_drop', this.unit.GetAbsOrigin(), this.unit.GetHullRadius() * 2.5);
        dropItems.forEach((drop) => {
            const item = (drop as CDOTA_Item_Physical).GetContainedItem();
            const owner = item.GetPurchaser();
            
            //Only pickup items owned by teammates
            if(!owner || (owner && CustomEntities.Allies(this.unit, owner) && this.unit !== owner)){
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
	CustomEntities.SendDataToClient(this.GetParent())
}

OnAbilityFullyCast(params)
	if(IsServer()){
		if(params.unit !== this.GetParent()){
			return
		}

		if(!GameRules.Addon:IsInWTFMode()){
			CustomEntities.GiveEnergy(params.unit, -params.ability:GetEnergyCost())
		}
	}
}

GetDisableAutoAttack()						return true	}
GetModifierIgnoreMovespeedLimit(params)		return 1	}
*/