import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";
import { ModifierShield } from "./modifier_shield";

@registerModifier()
export class ModifierBase extends CustomModifier<undefined> {
    IsPermanent() {
        return true;
    }

    IsHidden() {
        return false; //true;
    }

    DeclareFunctions() {
        return [ModifierFunction.INCOMING_DAMAGE_PERCENTAGE];
    }

    GetModifierIncomingDamage_Percentage(event: ModifierAttackEvent) {
        let remainingDamage = event.damage;

        for (const modifier of this.parent.FindAllModifiers()) {
            if (modifier instanceof ModifierShield) {
                print(modifier.GetName());
                // CustomEntitiesLegacy:SetBeenHurt(self:GetParent(), true)
                const remainingShield = Math.max(0, modifier.GetStackCount() - remainingDamage);
                remainingDamage = Math.max(0, remainingDamage - modifier.GetStackCount());

                modifier.SetStackCount(remainingShield);

                if (remainingDamage == 0) {
                    break;
                }
            }
        }

        print("Hey, im here", remainingDamage);

        return -(100 - (100 * remainingDamage) / remainingDamage);
    }
}
