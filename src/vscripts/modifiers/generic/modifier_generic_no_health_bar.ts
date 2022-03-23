import { BaseModifier, registerModifier } from "../../lib/dota_ts_adapter";

@registerModifier()
export class modifier_generic_no_health_bar extends BaseModifier{
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
    CheckState(): Partial<Record<ModifierState, boolean>> {
        return {
            [ModifierState.NO_HEALTH_BAR]: true,
        };
    }
}

