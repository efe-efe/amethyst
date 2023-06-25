import UnitEntity from "../unit_entity";
import Math from "../../util/math";
import customEntities from "../../util/custom_entities";
import { Upgrade } from "../../upgrades/common";
import { Reward } from "../../rewards/rewards";
import { CustomEvents } from "../../custom_events";
import { registerModifier } from "../../lib/dota_ts_adapter";
import { CustomModifier } from "../../abilities/framework/custom_modifier";
import { ModifierBase } from "../../modifiers/modifier_base";
import { ModifierHeroMovement } from "../../modifiers/modifier_hero_movement";
import { ModifierTowerIdle } from "../../modifiers/modifier_tower_idle";
import { ModifierVisible } from "../../modifiers/modifier_visible";
import { fullyFaceTowards, isRegularAbility } from "../../util";

const DEBUG = false;

enum CollisionTypes {
    SUCCESS = 0,
    UNIT,
    WALL,
    TREE
}

enum Orientations {
    NONE = 0,
    DIAGONAL_LEFT,
    DIAGONAL_RIGHT,
    HORIZONTAL,
    VERTICAL
}

interface HeroUpgrade extends Upgrade {
    level: number;
}

@registerModifier({ customNameForI18n: "modifier_combine_util" })
class ModifierCombineUtilVFX extends CustomModifier<undefined> {
    particleId?: ParticleID;

    OnCreated() {
        if (IsServer()) {
            this.particleId = EFX("particles/items5_fx/repair_kit_overhead.vpcf", ParticleAttachment.OVERHEAD_FOLLOW, this.parent, {
                cp2: {
                    ent: this.parent,
                    attach: ParticleAttachment.OVERHEAD_FOLLOW
                },
                release: false
            });
        }
    }

    OnDestroy() {
        if (IsServer() && this.particleId) {
            ParticleManager.DestroyParticle(this.particleId, false);
            ParticleManager.ReleaseParticleIndex(this.particleId);
        }
    }
}
export default class CustomNPC extends UnitEntity {
    constructor(unit: CDOTA_BaseNPC) {
        ModifierBase.apply(unit, unit, undefined, {});
        CustomEntitiesLegacy.Initialize(unit, !unit.IsRealHero()); //Need this for SetParent bullshit
        ModifierVisible.apply(unit, unit, undefined, {});
        super({ unit });
        customEntities.Disarm(this.unit);
        customEntities.IgnoreMSLimit(this.unit);
        customEntities.HideHealthBar(this.unit);
    }
    LevelAllAbilities(level: number): void {
        for (let i = 0; i <= 23; i++) {
            const ability = this.unit.GetAbilityByIndex(i);
            if (ability) {
                if (isRegularAbility(ability)) {
                    ability.SetLevel(level);
                }
            }
        }
    }
    Move(direction: Vector, speed: number): CollisionTypes {
        const offset = 70;
        const origin = this.unit.GetAbsOrigin();
        const futureOrigin = origin.__add(direction.__mul(speed));
        const testOrigin = futureOrigin.__add(direction.__mul(offset));
        futureOrigin.z = GetGroundPosition(futureOrigin, this.unit).z;
        const normal = CustomEntitiesLegacy.GetNormal(this.unit, futureOrigin);

        if (IsInToolsMode() && DEBUG) {
            DebugDrawLine_vCol(futureOrigin, testOrigin, Vector(255, 0, 0), true, 1.0);
            DebugDrawLine_vCol(futureOrigin, futureOrigin.__add(normal.__mul(200)), Vector(255, 255, 255), true, 1);
            DebugDrawCircle(futureOrigin, Vector(255, 0, 0), 5, offset, false, 0.03);
        }

        if (this.unit.HasModifier("modifier_spectre_special_attack_buff")) {
            this.unit.SetAbsOrigin(futureOrigin);
            return CollisionTypes.SUCCESS;
        }

        const trees = GridNav.GetAllTreesAroundPoint(testOrigin, 5, true);

        if (normal.z <= 0.9) {
            return CollisionTypes.WALL;
        }
        if (trees.length > 0) {
            return CollisionTypes.TREE;
        }

        if (!this.unit.IsPhased()) {
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

            for (let i = 0; i < units.length; i++) {
                const unit = units[i];
                if (unit !== this.unit) {
                    if (!unit.IsPhased()) {
                        return CollisionTypes.UNIT;
                    }
                }
            }
        }

        if (!CustomEntitiesLegacy.IsAnimating(this.unit)) {
            if (!ModifierHeroMovement.findOne(this.unit)) {
                ModifierHeroMovement.apply(this.unit, this.unit, undefined, {});
            }
        }

        this.unit.SetAbsOrigin(futureOrigin);
        return CollisionTypes.SUCCESS;
    }
    AlternativeDirectionsWalls(direction: Vector): Vector[] {
        const directions: Vector[] = [];
        const collisionDirection = CustomEntitiesLegacy.GetCollisionDirection(this.unit);
        const angle = VectorToAngles(direction).y;

        if (Math.IsNorthEast(angle)) {
            if (collisionDirection === Orientations.DIAGONAL_LEFT) {
                return directions;
            }
            directions.push(Math.NORTH);
            directions.push(Math.EAST);
        }
        if (Math.IsNorthWest(angle)) {
            if (collisionDirection === Orientations.DIAGONAL_RIGHT) {
                return directions;
            }
            if (collisionDirection === Orientations.DIAGONAL_LEFT) {
                directions.push(Math.NORTH);
                directions.push(Math.WEST);
                return directions;
            }
            if (collisionDirection === Orientations.VERTICAL) {
                directions.push(Math.NORTH);
                directions.push(Math.WEST);
                return directions;
            }
            directions.push(Math.NORTH);
            directions.push(Math.WEST);
        }
        if (Math.IsSouthEast(angle)) {
            if (collisionDirection === Orientations.DIAGONAL_RIGHT) {
                return directions;
            }
            if (collisionDirection === Orientations.DIAGONAL_LEFT) {
                directions.push(Math.SOUTH);
                directions.push(Math.EAST);
            }
            if (collisionDirection === Orientations.HORIZONTAL) {
                directions.push(Math.EAST);
                directions.push(Math.SOUTH);
            }
            if (collisionDirection === Orientations.VERTICAL) {
                directions.push(Math.SOUTH);
                directions.push(Math.EAST);
            }
        }
        if (Math.IsSouthWest(angle)) {
            if (collisionDirection === Orientations.HORIZONTAL) {
                directions.push(Math.WEST);
                directions.push(Math.SOUTH);
            }
            if (collisionDirection === Orientations.DIAGONAL_RIGHT) {
                directions.push(Math.SOUTH_WEST);
                directions.push(Math.WEST);
                directions.push(Math.SOUTH);
            }
            if (collisionDirection === Orientations.VERTICAL) {
                directions.push(Math.SOUTH);
                directions.push(Math.WEST);
            }
        }
        if (Math.IsEast(angle)) {
            if (collisionDirection === Orientations.DIAGONAL_RIGHT) {
                directions.push(Math.NORTH_EAST);
                directions.push(Math.NORTH);
            }
            if (collisionDirection === Orientations.DIAGONAL_LEFT) {
                directions.push(Math.SOUTH_EAST);
                directions.push(Math.SOUTH);
            }
        }
        if (Math.IsWest(angle)) {
            if (collisionDirection === Orientations.DIAGONAL_RIGHT) {
                directions.push(Math.SOUTH_EAST);
                directions.push(Math.SOUTH);
            }
            if (collisionDirection === Orientations.DIAGONAL_LEFT) {
                directions.push(Math.NORTH_WEST);
                directions.push(Math.NORTH);
            }
            if (collisionDirection === Orientations.HORIZONTAL) {
                directions.push(Math.SOUTH);
                directions.push(Math.NORTH);
            }
        }
        if (Math.IsNorth(angle)) {
            if (collisionDirection === Orientations.DIAGONAL_RIGHT) {
                directions.push(Math.NORTH_EAST);
                directions.push(Math.EAST);
            }
            if (collisionDirection === Orientations.HORIZONTAL) {
                return directions;
            }
            if (collisionDirection === Orientations.DIAGONAL_LEFT) {
                directions.push(Math.WEST);
            }
            if (collisionDirection === Orientations.VERTICAL) {
                directions.push(Math.NORTH_WEST);
                directions.push(Math.WEST);
            }
        }
        if (Math.IsSouth(angle)) {
            if (collisionDirection === Orientations.HORIZONTAL) {
                return directions;
            }
            if (collisionDirection === Orientations.DIAGONAL_RIGHT) {
                directions.push(Math.SOUTH_WEST);
                directions.push(Math.WEST);
            }
            if (collisionDirection === Orientations.DIAGONAL_LEFT) {
                directions.push(Math.SOUTH_EAST);
                directions.push(Math.EAST);
            }
            if (collisionDirection === Orientations.VERTICAL) {
                directions.push(Math.EAST);
            }
        }

        return directions;
    }
    AlternativeDirections(direction: Vector): Vector[] {
        const directions = [];
        const angle = VectorToAngles(direction).y;

        if (Math.IsNorthEast(angle)) {
            directions.push(Math.NORTH);
            directions.push(Math.EAST);
        }
        if (Math.IsNorthWest(angle)) {
            directions.push(Math.NORTH);
            directions.push(Math.WEST);
        }
        if (Math.IsSouthEast(angle)) {
            directions.push(Math.SOUTH);
            directions.push(Math.EAST);
        }
        if (Math.IsSouthWest(angle)) {
            directions.push(Math.SOUTH);
            directions.push(Math.WEST);
        }
        if (Math.IsEast(angle) || Math.IsWest(angle)) {
            if (this.unit.GetAbsOrigin().y < 0) {
                directions.push(Math.SOUTH);
                directions.push(Math.NORTH);
            }

            if (this.unit.GetAbsOrigin().y > 0) {
                directions.push(Math.NORTH);
                directions.push(Math.SOUTH);
            }
        }
        if (Math.IsNorth(angle) || Math.IsSouth(angle)) {
            if (this.unit.GetAbsOrigin().x < 0) {
                directions.push(Math.WEST);
            }
            if (this.unit.GetAbsOrigin().x > 0) {
                directions.push(Math.EAST);
            }
        }
        return directions;
    }
    Update(): void {
        const direction = CustomEntitiesLegacy.GetDirection(this.unit).Normalized();
        const speed = this.unit.GetIdealSpeed() / 25;

        if (CustomEntitiesLegacy.IsAnimating(this.unit)) {
            this.unit.RemoveModifierByName(ModifierHeroMovement.name);
            this.unit.RemoveModifierByName(ModifierTowerIdle.name);
        }

        if ((direction.x !== 0 || direction.y !== 0) && CustomEntitiesLegacy.CanWalk(this.unit)) {
            const output = this.Move(direction, speed);
            if (output !== CollisionTypes.SUCCESS) {
                let alternativeDirections: Vector[] = [];

                if (output === CollisionTypes.WALL) {
                    alternativeDirections = this.AlternativeDirectionsWalls(direction);
                } else {
                    alternativeDirections = this.AlternativeDirections(direction);
                }

                for (let i = 0; i < alternativeDirections.length; i++) {
                    const alternativeDireaction = alternativeDirections[i];
                    const newOutput = this.Move(alternativeDireaction, speed * 0.8);
                    if (newOutput === CollisionTypes.SUCCESS) {
                        break;
                    }
                }
            }

            if (
                !this.unit.HasModifier("modifier_casting") &&
                !this.unit.HasModifier("modifier_mars_counter_countering") &&
                !this.unit.HasModifier("modifier_spectre_counter_countering")
            ) {
                fullyFaceTowards(this.unit, direction);
            }
        } else {
            if (this.unit.GetUnitName() === "dire_tower") {
                if (!ModifierTowerIdle.findOne(this.unit)) {
                    ModifierTowerIdle.apply(this.unit, this.unit, undefined, {});
                }
            }
            this.unit.RemoveModifierByName(ModifierHeroMovement.name);
        }

        if (IsInToolsMode() && DEBUG) {
            // Don't quote me on this, im just fixing warnings
            // if ((this.unit as CDOTA_BaseNPC_Hero).GetPlayerID) {
            const player = GameRules.Addon.FindPlayerById((this.unit as CDOTA_BaseNPC_Hero).GetPlayerID());

            if (player) {
                const mouse = player.GetCursorPosition();
                DebugDrawLine_vCol(
                    this.unit.GetAbsOrigin(),
                    this.unit.GetAbsOrigin().__add(this.unit.GetForwardVector().__mul(500)),
                    Vector(0, 0, 255),
                    true,
                    0.03
                );
                DebugDrawLine_vCol(this.unit.GetAbsOrigin(), mouse, Vector(0, 255, 0), true, 0.03);
            }
            // }
        }
    }
    OnDeath(event: EntityKilledEvent): void {
        super.OnDeath(event);
        this.Destroy(false);
    }
}
export class CustomHeroNPC extends CustomNPC {
    constructor(unit: CDOTA_BaseNPC) {
        super(unit);
        customEntities.SetUseEnergy(this.unit);
    }
}
export class CustomNonPlayerHeroNPC extends CustomHeroNPC {
    constructor(unit: CDOTA_BaseNPC) {
        super(unit);
        this.LevelAllAbilities(1);
    }
}
export class CustomPlayerHeroNPC extends CustomHeroNPC {
    heroUpgrades: HeroUpgrade[] = [];
    reward: Reward | undefined;
    remainingTimeToRemoveMana = 1.0 * 30;

    constructor(unit: CDOTA_BaseNPC) {
        super(unit);
        this.LevelAllAbilities(1);
        if (GameRules.Addon.IsPVE()) {
            (this.unit as CDOTA_BaseNPC_Hero).SetAbilityPoints(0);
            customEntities.ChangeMS(this.unit, 50);
            this.unit.RemoveAbility(this.unit.GetAbilityByIndex(7)!.GetName());
            this.unit.RemoveAbility(this.unit.GetAbilityByIndex(8)!.GetName());
            //ListenToGameEvent('dota_player_learned_ability', (event) => this.OnLearnedAbilityEvent(event), undefined);
        }
    }

    OnLearnedAbilityEvent(event: DotaPlayerLearnedAbilityEvent): void {
        if (event.PlayerID === this.unit.GetPlayerOwnerID()) {
            const ability = this.unit.FindAbilityByName(event.abilityname);
            if (ability) {
                if (ability.GetLevel() === 2) {
                    ability.SetLevel(1);
                    (this.unit as CDOTA_BaseNPC_Hero).SetAbilityPoints((this.unit as CDOTA_BaseNPC_Hero).GetAbilityPoints() + 1);
                }
            }
        }
    }

    Update(): void {
        super.Update();
        if (this.remainingTimeToRemoveMana > 0) {
            this.remainingTimeToRemoveMana--;
        } else if (this.remainingTimeToRemoveMana === 0) {
            CustomEntitiesLegacy.SetManaCustom(this.unit, 0, true);
            this.remainingTimeToRemoveMana = -1;
        }

        if (this.unit.IsAlive()) {
            this.PickupItems();
        }
    }

    PickupItems(): void {
        const dropItems = Entities.FindAllByClassnameWithin("dota_item_drop", this.unit.GetAbsOrigin(), this.unit.GetHullRadius() * 2.5);
        dropItems.forEach(drop => {
            const item = (drop as CDOTA_Item_Physical).GetContainedItem();
            const owner = item.GetPurchaser();

            //Only pickup items owned by teammates
            if (!owner || (owner && CustomEntitiesLegacy.Allies(this.unit, owner) && this.unit !== owner)) {
                this.unit.AddItem(item);
                item.OnSpellStart();

                GameRules.Addon.OnPickedUp(item);
                UTIL_Remove(drop);
            }
        });
    }

    IsRanged(): boolean {
        return (this.unit as CDOTA_BaseNPC_Hero).GetPrimaryAttribute() === Attributes.AGILITY;
    }

    IsMeele(): boolean {
        return (this.unit as CDOTA_BaseNPC_Hero).GetPrimaryAttribute() === Attributes.STRENGTH;
    }

    IsSelectingUpgrade(): boolean {
        const tableName = "custom_npc_favors" as never;
        const value = CustomNetTables.GetTableValue(tableName, this.unit.GetPlayerOwnerID().toString()) as {
            playerId: PlayerID;
            upgrades: Upgrade[] | undefined;
        };
        return value && value.upgrades !== undefined;
    }

    IsSelectingReward(): boolean {
        const tableName = "custom_npc_rewards" as never;
        const value = CustomNetTables.GetTableValue(tableName, this.unit.GetPlayerOwnerID().toString()) as {
            playerId: PlayerID;
            rewards: Reward[] | undefined;
        };
        return value && value.rewards !== undefined;
    }

    ReleaseAbility(abilityName: string): void {
        //WIP
    }

    ApplyItem(upgrade: Upgrade): void {
        if (upgrade.ingredients) {
            upgrade.ingredients.forEach(ingredientId => {
                const ingredientUpgrade = this.heroUpgrades.find(heroUpgrade => heroUpgrade.id === ingredientId);

                if (ingredientUpgrade) {
                    this.unit.RemoveModifierByName(ingredientUpgrade.modifier!.name);
                }
            });

            EFX("particles/items_fx/item_sheepstick.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.unit, {
                release: true
            });

            ModifierCombineUtilVFX.apply(this.unit, this.unit, undefined, {
                duration: 1.5
            });

            EmitSoundOn("DOTA_Item.RepairKit.Target", this.unit);
        }

        EFX("particles/econ/events/ti10/mekanism_ti10.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.unit, {
            release: true
        });
        EmitSoundOn("DOTA_Item.Overwhelming_Blink.NailedIt", this.unit);
    }

    ApplyFavor(upgrade: Upgrade): void {
        EmitSoundOn("DOTA_Item.Mekansm.Target", this.unit);

        EFX("particles/econ/events/ti10/hero_levelup_ti10.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.unit, {
            release: true
        });
    }

    ApplyShard(upgrade: Upgrade): void {
        EmitSoundOn("Item.MoonShard.Consume", this.unit);

        EFX("particles/econ/events/ti10/hero_levelup_ti10.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.unit, {
            release: true
        });
    }

    SelectReward(reward: Reward): void {
        this.reward = reward;
        this.ClearTable("custom_npc_rewards" as never);
        const customEvents = CustomEvents.GetInstance();
        customEvents.EmitEvent("pve:next_reward_selected", {
            customNpc: this,
            reward
        });

        const data = {
            nextReward: this.reward.name
        } as never;
        CustomNetTables.SetTableValue("main" as never, "pve", data);
    }

    ClearTable(name: never): void {
        const data = {
            playerId: this.unit.GetPlayerOwnerID()
        } as never;
        CustomNetTables.SetTableValue(name, this.unit.GetPlayerOwnerID().toString(), data);
    }
}
