import { findAllianceDefinitionByUnit } from "./alliance_definitions";
import { addAnimation, removeAnimation } from "./animation";
import { Entity } from "./entities";
import { findPlayerById } from "./game";
import { getUnitShieldPoints } from "./modifiers/modifier_shield";
import { canUnitWalk, fullyFaceTowards, getEnergy, getMaxEnergy, isInDeveloperMode } from "./util";

export function updateEntityData(entity: Entity) {
    const unit = entity.handle;
    const allianceId = findAllianceDefinitionByUnit(unit)?.id ?? AllianceId.none;

    // if (CustomEntitiesLegacy.GetAlliance(unit)) {
    //     allianceName = CustomEntitiesLegacy.GetAlliance(unit).GetName();
    // }

    //TODO: @Refactor Fix the rest
    const data = {
        entityIndex: unit.GetEntityIndex(),
        teamId: unit.GetTeam(),
        playerId: unit.GetPlayerOwnerID(),
        allianceId: allianceId,
        name: unit.GetName(),
        health: unit.GetHealth(),
        maxHealth: unit.GetMaxHealth(),
        shield: getUnitShieldPoints(unit),
        mana: unit.GetMana(),
        maxMana: unit.GetMaxMana(),
        // status: CustomEntitiesLegacy:GetStatus(unit),
        // recast: CustomEntitiesLegacy:GetRecast(unit),
        // stackbars: CustomEntitiesLegacy:GetStackbars(unit),
        // charges: CustomEntitiesLegacy:GetCharges(unit),
        // cooldown: CustomEntitiesLegacy:GetCooldown(unit),
        // abilities: CustomEntitiesLegacy:GetAbilities(unit),
        // maxEnergy: CustomEntitiesLegacy:GetMaxEnergy(unit),
        // energyPerCell: CustomEntitiesLegacy:GetEnergyPerCell(unit),
        heroData: unit.IsRealHero()
            ? {
                  threshold: entity.threshold,
                  energy: getEnergy(entity.handle),
                  maxEnergy: getMaxEnergy()
              }
            : undefined
    };
    CustomNetTables.SetTableValue("units", tostring("_" + entity.handle.GetEntityIndex()), data);
}

export function updateEntityMovement(entity: Entity) {
    // function isAnimating(entity: Entity) {
    // return CustomEntitiesLegacy:HasModifiersFromType(hEntity, MODIFIER_TYPES.ANIMATION)
    //     return false;
    // }

    function moveEntity(entity: Entity, direction: Vector, speed: number) {
        const offset = 70;
        const unit = entity.handle;
        const origin = unit.GetAbsOrigin();
        const futureOrigin = origin.__add(direction.__mul(speed));
        const testOrigin = futureOrigin.__add(direction.__mul(offset));
        futureOrigin.z = GetGroundPosition(futureOrigin, unit).z;
        const normal = CustomEntitiesLegacy.GetNormal(unit, futureOrigin);

        if (isInDeveloperMode()) {
            // DebugDrawLine_vCol(futureOrigin, testOrigin, Vector(255, 0, 0), true, 1.0);
            // DebugDrawLine_vCol(futureOrigin, futureOrigin.__add(normal.__mul(200)), Vector(255, 255, 255), true, 1);
            // DebugDrawCircle(futureOrigin, Vector(255, 0, 0), 5, offset, false, 0.03);
        }

        if (unit.HasModifier("modifier_spectre_special_attack_buff")) {
            unit.SetAbsOrigin(futureOrigin);
            return "success";
        }

        if (GridNav.FindPathLength(origin, futureOrigin) == -1) {
            // if (normal.z <= 0.9) {
            return "wall";
        }

        const trees = GridNav.GetAllTreesAroundPoint(testOrigin, 5, true);
        if (trees.length > 0) {
            return "tree";
        }

        if (!unit.IsPhased()) {
            const units = FindUnitsInRadius(
                unit.GetTeamNumber(),
                testOrigin,
                undefined,
                5,
                UnitTargetTeam.BOTH,
                UnitTargetType.ALL,
                UnitTargetFlags.NONE,
                FindOrder.ANY,
                false
            ).filter(collisionUnit => collisionUnit != unit);

            if (units.some(unit => !unit.IsPhased())) {
                return "unit";
            }
        }

        unit.SetAbsOrigin(futureOrigin);
        return "success";
    }

    const direction = entity.direction;
    const unit = entity.handle;
    const speed = unit.GetIdealSpeed() / 25;

    // if (isAnimating(entity)) {
    //     this.unit.RemoveModifierByName(ModifierHeroMovement.name);
    //     this.unit.RemoveModifierByName(ModifierTowerIdle.name);
    // }

    if (IsInToolsMode() && unit.IsRealHero()) {
        const player = findPlayerById(unit.GetPlayerID());

        if (player) {
            const mouse = player.cursorPosition;
            // DebugDrawLine_vCol(
            //     unit.GetAbsOrigin(),
            //     unit.GetAbsOrigin().__add(unit.GetForwardVector().__mul(500)),
            //     Vector(0, 0, 255),
            //     true,
            //     0.03
            // );
            // DebugDrawLine_vCol(unit.GetAbsOrigin(), mouse, Vector(0, 255, 0), true, 0.03);
        }
    }

    if (direction.x == 0 && direction.y == 0) {
        removeAnimation(unit, GameActivity.DOTA_RUN);
        return;
    }

    if (canUnitWalk(unit)) {
        const output = moveEntity(entity, direction, speed);

        if (output != "success") {
            const alternativeDirections: Vector[] = [];

            if (output == "wall") {
                // alternativeDirections = this.AlternativeDirectionsWalls(direction);
            } else {
                // alternativeDirections = this.AlternativeDirections(direction);
            }

            for (let i = 0; i < alternativeDirections.length; i++) {
                const alternativeDireaction = alternativeDirections[i];
                const newOutput = moveEntity(entity, alternativeDireaction, speed * 0.8);
                if (newOutput === "success") {
                    break;
                }
            }
        }

        if (
            !unit.HasModifier("modifier_casting") &&
            !unit.HasModifier("modifier_mars_counter_countering") &&
            !unit.HasModifier("modifier_spectre_counter_countering")
        ) {
            fullyFaceTowards(unit, direction);
        }

        addAnimation(unit, GameActivity.DOTA_RUN);
        return;
    }

    removeAnimation(unit, GameActivity.DOTA_RUN);

    if (unit.GetUnitName() === "npc_dota_dire_tower") {
        // if (!ModifierTowerIdle.findOne(unit)) {
        //     ModifierTowerIdle.apply(unit, unit, undefined, {});
        // }
    }
    // unit.RemoveModifierByName(ModifierHeroMovement.name);
}

// AlternativeDirectionsWalls(direction: Vector): Vector[] {
//     const directions: Vector[] = [];
//     const collisionDirection = CustomEntitiesLegacy.GetCollisionDirection(this.unit);
//     const angle = VectorToAngles(direction).y;

//     if (Math.IsNorthEast(angle)) {
//         if (collisionDirection === Orientations.DIAGONAL_LEFT) {
//             return directions;
//         }
//         directions.push(Math.NORTH);
//         directions.push(Math.EAST);
//     }
//     if (Math.IsNorthWest(angle)) {
//         if (collisionDirection === Orientations.DIAGONAL_RIGHT) {
//             return directions;
//         }
//         if (collisionDirection === Orientations.DIAGONAL_LEFT) {
//             directions.push(Math.NORTH);
//             directions.push(Math.WEST);
//             return directions;
//         }
//         if (collisionDirection === Orientations.VERTICAL) {
//             directions.push(Math.NORTH);
//             directions.push(Math.WEST);
//             return directions;
//         }
//         directions.push(Math.NORTH);
//         directions.push(Math.WEST);
//     }
//     if (Math.IsSouthEast(angle)) {
//         if (collisionDirection === Orientations.DIAGONAL_RIGHT) {
//             return directions;
//         }
//         if (collisionDirection === Orientations.DIAGONAL_LEFT) {
//             directions.push(Math.SOUTH);
//             directions.push(Math.EAST);
//         }
//         if (collisionDirection === Orientations.HORIZONTAL) {
//             directions.push(Math.EAST);
//             directions.push(Math.SOUTH);
//         }
//         if (collisionDirection === Orientations.VERTICAL) {
//             directions.push(Math.SOUTH);
//             directions.push(Math.EAST);
//         }
//     }
//     if (Math.IsSouthWest(angle)) {
//         if (collisionDirection === Orientations.HORIZONTAL) {
//             directions.push(Math.WEST);
//             directions.push(Math.SOUTH);
//         }
//         if (collisionDirection === Orientations.DIAGONAL_RIGHT) {
//             directions.push(Math.SOUTH_WEST);
//             directions.push(Math.WEST);
//             directions.push(Math.SOUTH);
//         }
//         if (collisionDirection === Orientations.VERTICAL) {
//             directions.push(Math.SOUTH);
//             directions.push(Math.WEST);
//         }
//     }
//     if (Math.IsEast(angle)) {
//         if (collisionDirection === Orientations.DIAGONAL_RIGHT) {
//             directions.push(Math.NORTH_EAST);
//             directions.push(Math.NORTH);
//         }
//         if (collisionDirection === Orientations.DIAGONAL_LEFT) {
//             directions.push(Math.SOUTH_EAST);
//             directions.push(Math.SOUTH);
//         }
//     }
//     if (Math.IsWest(angle)) {
//         if (collisionDirection === Orientations.DIAGONAL_RIGHT) {
//             directions.push(Math.SOUTH_EAST);
//             directions.push(Math.SOUTH);
//         }
//         if (collisionDirection === Orientations.DIAGONAL_LEFT) {
//             directions.push(Math.NORTH_WEST);
//             directions.push(Math.NORTH);
//         }
//         if (collisionDirection === Orientations.HORIZONTAL) {
//             directions.push(Math.SOUTH);
//             directions.push(Math.NORTH);
//         }
//     }
//     if (Math.IsNorth(angle)) {
//         if (collisionDirection === Orientations.DIAGONAL_RIGHT) {
//             directions.push(Math.NORTH_EAST);
//             directions.push(Math.EAST);
//         }
//         if (collisionDirection === Orientations.HORIZONTAL) {
//             return directions;
//         }
//         if (collisionDirection === Orientations.DIAGONAL_LEFT) {
//             directions.push(Math.WEST);
//         }
//         if (collisionDirection === Orientations.VERTICAL) {
//             directions.push(Math.NORTH_WEST);
//             directions.push(Math.WEST);
//         }
//     }
//     if (Math.IsSouth(angle)) {
//         if (collisionDirection === Orientations.HORIZONTAL) {
//             return directions;
//         }
//         if (collisionDirection === Orientations.DIAGONAL_RIGHT) {
//             directions.push(Math.SOUTH_WEST);
//             directions.push(Math.WEST);
//         }
//         if (collisionDirection === Orientations.DIAGONAL_LEFT) {
//             directions.push(Math.SOUTH_EAST);
//             directions.push(Math.EAST);
//         }
//         if (collisionDirection === Orientations.VERTICAL) {
//             directions.push(Math.EAST);
//         }
//     }

//     return directions;
// }
// AlternativeDirections(direction: Vector): Vector[] {
//     const directions = [];
//     const angle = VectorToAngles(direction).y;

//     if (Math.IsNorthEast(angle)) {
//         directions.push(Math.NORTH);
//         directions.push(Math.EAST);
//     }
//     if (Math.IsNorthWest(angle)) {
//         directions.push(Math.NORTH);
//         directions.push(Math.WEST);
//     }
//     if (Math.IsSouthEast(angle)) {
//         directions.push(Math.SOUTH);
//         directions.push(Math.EAST);
//     }
//     if (Math.IsSouthWest(angle)) {
//         directions.push(Math.SOUTH);
//         directions.push(Math.WEST);
//     }
//     if (Math.IsEast(angle) || Math.IsWest(angle)) {
//         if (this.unit.GetAbsOrigin().y < 0) {
//             directions.push(Math.SOUTH);
//             directions.push(Math.NORTH);
//         }

//         if (this.unit.GetAbsOrigin().y > 0) {
//             directions.push(Math.NORTH);
//             directions.push(Math.SOUTH);
//         }
//     }
//     if (Math.IsNorth(angle) || Math.IsSouth(angle)) {
//         if (this.unit.GetAbsOrigin().x < 0) {
//             directions.push(Math.WEST);
//         }
//         if (this.unit.GetAbsOrigin().x > 0) {
//             directions.push(Math.EAST);
//         }
//     }
//     return directions;
// }
