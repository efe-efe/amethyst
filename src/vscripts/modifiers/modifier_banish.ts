import { CustomAbility } from "../abilities/framework/custom_ability";
import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";

@registerModifier()
export class ModifierBanish<A extends CDOTABaseAbility | undefined = CustomAbility> extends CustomModifier<A> {
    originalScale!: number;

    OnCreated() {
        if (IsServer()) {
            this.originalScale = this.parent.GetModelScale();
            this.parent.SetModelScale(0.05);
        }
    }

    OnDestroy() {
        if (IsServer()) {
            this.parent.SetModelScale(this.originalScale);
        }
    }

    CheckState() {
        return {
            [ModifierState.NO_UNIT_COLLISION]: true,
            [ModifierState.FLYING_FOR_PATHING_PURPOSES_ONLY]: true,
            [ModifierState.INVULNERABLE]: true,
            [ModifierState.OUT_OF_GAME]: true
        };
    }
}
