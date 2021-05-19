import { BaseModifier, registerModifier } from '../../lib/dota_ts_adapter';

@registerModifier()
export class modifier_generic_ignore_ms_limit extends BaseModifier{
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
            ModifierFunction.IGNORE_MOVESPEED_LIMIT,
        ];
    }
    GetModifierIgnoreMovespeedLimit(): 0|1{
        return 1;   
    }
}

