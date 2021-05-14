import '../abilities/generic/modifier_generic_no_health_bar';
import '../abilities/generic/modifier_generic_disarm';
import '../abilities/generic/modifier_generic_use_energy';

const customEntities = {
    Disarm(entity: CDOTA_BaseNPC): void{
        entity.AddNewModifier(entity, undefined, 'modifier_generic_disarm', {});
    },
    HideHealthBar(entity: CDOTA_BaseNPC): void{
        entity.AddNewModifier(entity, undefined, 'modifier_generic_no_health_bar', {});
    },
    SetUseEnergy(entity: CDOTA_BaseNPC): void{
        entity.AddNewModifier(entity, undefined, 'modifier_generic_use_energy', {});
    },
};

export default customEntities;