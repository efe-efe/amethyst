import { findAbilityDefinitionByName } from "../abilities/framework/ability_definition";
import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";
import { ModifierShield } from "./modifier_shield";

@registerModifier()
export class ModifierBase extends CustomModifier<undefined> {
    IsPermanent() {
        return true;
    }

    IsHidden() {
        return true;
    }

    DeclareFunctions() {
        return [ModifierFunction.INCOMING_DAMAGE_PERCENTAGE, ModifierFunction.ON_ABILITY_FULLY_CAST];
    }

    GetModifierIncomingDamage_Percentage(event: ModifierAttackEvent) {
        let remainingDamage = event.damage;

        for (const modifier of this.parent.FindAllModifiers()) {
            if (modifier instanceof ModifierShield) {
                // CustomEntitiesLegacy:SetBeenHurt(self:GetParent(), true)
                const remainingShield = Math.max(0, modifier.GetStackCount() - remainingDamage);
                remainingDamage = Math.max(0, remainingDamage - modifier.GetStackCount());

                modifier.SetStackCount(remainingShield);

                if (remainingDamage == 0) {
                    break;
                }
            }
        }

        return -(100 - (100 * remainingDamage) / remainingDamage);
    }

    OnAbilityFullyCast(event: ModifierAbilityEvent) {
        if (IsServer() && event.unit == this.parent) {
            const definition = findAbilityDefinitionByName(event.ability.GetName());

            if (definition) {
                if (definition.linkedAbility?.shareCooldown) {
                    const linked = this.parent.FindAbilityByName(definition.linkedAbility.name);
                    linked?.StartCooldown(linked.GetCooldown(0));
                }
            }
        }
    }
}
