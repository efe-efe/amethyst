import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";

@registerModifier()
export class ModifierRecast extends CustomModifier<undefined> {
    abilityLeft!: CDOTABaseAbility;
    abilityRight?: CDOTABaseAbility;
    duration!: number;

    IsHidden() {
        return true;
    }

    OnCreated(params: { abilityLeft: string; abilityRight?: string; charges?: number; duration: number }) {
        if (IsServer()) {
            const abilityLeft = this.parent.FindAbilityByName(params.abilityLeft);

            this.duration = params.duration;

            if (!abilityLeft) {
                print(`[ERROR] AbilityLeft (${params.abilityLeft}) not found on ModifierRecast`);
                this.Destroy();
                return;
            }

            this.abilityLeft = abilityLeft;

            if (params.abilityRight) {
                this.abilityRight = this.parent.FindAbilityByName(params.abilityRight);
                this.parent.SwapAbilities(params.abilityLeft, params.abilityRight, false, true);
            }

            const charges = params.charges ?? 1;

            this.SetStackCount(this.abilityRight ? charges : charges + 1);

            // CustomEntitiesLegacy:SendDataToClient(self:GetParent())
        }
    }

    // function modifier:GetRecastData()
    //     return {
    //         key = self:GetRecastKey(),
    //         modifier_name = self:GetName(),
    //         ability_name = self:GetRecastAbility():GetName(),
    //     }
    // end

    OnDestroy() {
        if (IsServer()) {
            if (this.abilityRight) {
                this.parent.SwapAbilities(this.abilityLeft.GetName(), this.abilityRight.GetName(), true, false);
            }

            this.abilityLeft.StartCooldown(this.abilityLeft.GetCooldown(this.abilityLeft.GetLevel()));
            //         CustomEntitiesLegacy:SendDataToClient(self:GetParent())
        }
    }

    OnRefresh() {
        if (IsServer()) {
            this.IncrementStackCount();
        }
    }

    OnStackCountChanged() {
        if (IsServer()) {
            if (this.GetStackCount() <= 0) {
                this.Destroy();
                return;
            }

            if (!this.abilityRight) {
                this.abilityLeft.EndCooldown();
            } else {
                this.abilityRight.EndCooldown();
            }
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.ON_ABILITY_FULLY_CAST];
    }

    OnAbilityFullyCast(event: ModifierAbilityEvent) {
        if (IsServer()) {
            if (event.unit != this.parent) {
                return;
            }

            if (!this.abilityRight && event.ability == this.abilityLeft) {
                this.DecrementStackCount();
            }

            if (event.ability == this.abilityRight) {
                this.DecrementStackCount();
            }
        }
    }

    // function modifier:GetRecastKey()
    //     if getRecastKey then return getRecastKey(self) end
    //     return "NO KEY"
    // end

    // function modifier:GetStatusLabel() return "Recast" end
    // function modifier:GetStatusPriority() return 10 end
    // function modifier:GetStatusStyle() return "Recast" end
    // function modifier:GetStatusScope() return STATUS_SCOPE_LOCAL end
}

//     if IsClient() then require("wrappers/modifiers") end
//     Modifiers.Status(modifier)
//     Modifiers.StartTracking(modifier, MODIFIER_TYPES.RECAST)
