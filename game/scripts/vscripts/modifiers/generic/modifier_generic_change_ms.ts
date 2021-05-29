import { BaseModifier, registerModifier } from '../../lib/dota_ts_adapter';

@registerModifier()
export class modifier_generic_change_ms extends BaseModifier{
    OnCreated(data: any): void{
        if(IsServer()){
            this.SetStackCount(data.amount);
        }
    }
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
            ModifierFunction.MOVESPEED_BONUS_CONSTANT_UNIQUE,
        ];
    }
    GetModifierMoveSpeedBonus_Constant_Unique(): number{
        return this.GetStackCount();
    }
}

