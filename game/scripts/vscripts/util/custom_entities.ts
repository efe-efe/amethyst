import '../abilities/generic/modifier_generic_no_health_bar';
import '../abilities/generic/modifier_generic_disarm';
import '../abilities/generic/modifier_generic_use_energy';
import '../abilities/generic/modifier_generic_ignore_ms_limit';

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
    IgnoreMSLimit(entity: CDOTA_BaseNPC): void{
        entity.AddNewModifier(entity, undefined, 'modifier_generic_ignore_ms_limit', {});
    },
    
};

export default customEntities;