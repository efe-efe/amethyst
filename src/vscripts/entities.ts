import { ModifierBase } from "./modifiers/modifier_base";
import { ModifierDisarm } from "./modifiers/modifier_disarm";
import { ModifierEnergy } from "./modifiers/modifier_energy";
import { ModifierNoHealthbar } from "./modifiers/modifier_no_health_bar";
import { ModifierUnlimitedSpeed } from "./modifiers/modifier_unlimited_speed";
import { ModifierVisible } from "./modifiers/modifier_visible";
import { sendOverheadHealMessage } from "./util";

export type Entity = {
    handle: CDOTA_BaseNPC;
    threshold: number;
    energyPerCell: number;
    hurt: boolean;
    direction: Vector;
    collisionDirection?: Vector;
};

export let entities: Entity[] = [];

export function removeEntity(removed: Entity) {
    entities = entities.filter(entity => entity != removed);
}

export function createEntity(handle: CDOTA_BaseNPC) {
    const entity = {
        handle: handle,
        threshold: Constants.maxThreshold,
        energyPerCell: 100,
        hurt: false,
        direction: Vector(0, 0),
        collisionDirection: undefined
    };

    ModifierBase.apply(handle, handle, undefined, {});
    ModifierEnergy.apply(handle, handle, undefined, {});
    ModifierVisible.apply(handle, handle, undefined, {});
    ModifierDisarm.apply(handle, handle, undefined, {});
    ModifierUnlimitedSpeed.apply(handle, handle, undefined, {});
    ModifierNoHealthbar.apply(handle, handle, undefined, {});

    setEntityDirection(entity, 0, 0);
    entities.push(entity);
    return entity;
}

export function findEntityByHandle(handle: CDOTA_BaseNPC) {
    return entities.find(entity => entity.handle == handle);
}

export function setEntityDirection(entity: Entity, x: number, y: number) {
    entity.direction = Vector(x, y, entity.handle.GetForwardVector().z).Normalized();
}

export function trueHealEntity(entity: Entity, heal: number) {
    const unit = entity.handle;
    const baseHealth = unit.GetHealth();
    // CustomEntitiesLegacy:SetHealthCustom(hEntity, base_health + iHeal)
    unit.SetHealth(baseHealth + heal);

    entity.threshold = Math.min(Constants.maxThreshold, entity.threshold + heal);

    if (unit.GetHealth() < unit.GetMaxHealth()) {
        sendOverheadHealMessage(unit, heal);
    }
}
