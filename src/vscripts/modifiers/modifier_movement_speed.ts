import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";

@registerModifier()
export class ModifierMovementSpeed extends CustomModifier<undefined> {
    OnCreated(params: { amount: number }): void {
        if (IsServer()) {
            this.SetStackCount(params.amount);
        }
    }

    IsHidden(): boolean {
        return true;
    }

    IsDebuff(): boolean {
        return false;
    }

    IsPurgable(): boolean {
        return false;
    }

    RemoveOnDeath(): boolean {
        return false;
    }

    DeclareFunctions(): ModifierFunction[] {
        return [ModifierFunction.MOVESPEED_BONUS_CONSTANT_UNIQUE];
    }

    GetModifierMoveSpeedBonus_Constant_Unique(): number {
        return this.GetStackCount();
    }
}
