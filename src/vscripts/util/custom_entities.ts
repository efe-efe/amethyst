import "../modifiers/generic/modifier_generic_no_health_bar";
import "../modifiers/generic/modifier_generic_disarm";
import "../modifiers/generic/modifier_generic_use_energy";
import "../modifiers/generic/modifier_generic_ignore_ms_limit";

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
        entity.AddNewModifier(entity, undefined, "modifier_generic_ignore_ms_limit", {});
    },
    ChangeMS(entity: CDOTA_BaseNPC, amount: number): void {
        entity.AddNewModifier(entity, undefined, "modifier_generic_change_ms", {
            amount
        });
    }
};

export default customEntities;
