import { BaseModifier, registerModifier } from "../../lib/dota_ts_adapter";

@registerModifier()
export class modifier_generic_flying extends BaseModifier{
    IsHidden(): boolean{ 
        return true;
    }
    IsDebuff(): boolean{
        return	false;	
    }
    IsPurgable(): boolean{
        return false;	
    }
    CheckState(): Partial<Record<ModifierState, boolean>> {
        return {
            [ModifierState.FLYING]: true,
        };
    }
}

