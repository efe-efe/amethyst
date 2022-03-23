import { registerModifier, BaseModifier } from '../../lib/dota_ts_adapter';

@registerModifier()
export default class modifier_generic_use_energy extends BaseModifier{
    IsHidden(): boolean{
        return true;
    }
    IsDebuff(): boolean{
        return	false;	
    }
    IsPurgable(): boolean{
        return false;	
    }
    RemoveOnDeath(): boolean{
        return false;
    }
    DeclareFunctions(): ModifierFunction[]{
        return [ 
            ModifierFunction.ON_SPENT_MANA,
            ModifierFunction.ON_ABILITY_FULLY_CAST,
        ];
    }
    OnSpentMana(event: ModifierAbilityEvent): void{
        CustomEntitiesLegacy.SendDataToClient(this.GetParent());
    }
    OnAbilityFullyCast(event: ModifierAbilityEvent): void{
        if(IsServer()){
            if(event.unit !== this.GetParent()){
                return;
            }

            if(!GameRules.Addon.IsInWTFMode()){
                CustomEntitiesLegacy.GiveEnergy(event.unit, -(event.ability as any).GetEnergyCost());
            }
        }
    }
}