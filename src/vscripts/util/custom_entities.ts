import "../modifiers/generic/modifier_generic_no_health_bar";
import "../modifiers/generic/modifier_generic_disarm";
import "../modifiers/generic/modifier_generic_use_energy";
import { ModifierUnlimitedSpeed } from "../modifiers/modifier_unlimited_speed";
import { ModifierMovementSpeed } from "../modifiers/modifier_movement_speed";

const customEntities = {
    Disarm(entity: CDOTA_BaseNPC): void {
        entity.AddNewModifier(entity, undefined, "modifier_generic_disarm", {});
    },
    HideHealthBar(entity: CDOTA_BaseNPC): void {
        entity.AddNewModifier(entity, undefined, "modifier_generic_no_health_bar", {});
    },
    SetUseEnergy(entity: CDOTA_BaseNPC): void {
        entity.AddNewModifier(entity, undefined, "modifier_generic_use_energy", {});
    },
    IgnoreMSLimit(entity: CDOTA_BaseNPC): void {
        ModifierUnlimitedSpeed.apply(entity, entity, undefined, {});
    },
    ChangeMS(entity: CDOTA_BaseNPC, amount: number): void {
        ModifierMovementSpeed.apply(entity, entity, undefined, {
            amount
        });
    }
};

export default customEntities;
