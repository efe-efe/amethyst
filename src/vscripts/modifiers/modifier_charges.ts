import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";

@registerModifier()
export class ModifierCharges extends CustomModifier<CDOTABaseAbility> {
    IsHidden() {
        return false;
    }

    IsDebuff() {
        return false;
    }

    IsPurgable() {
        return false;
    }

    DestroyOnExpire() {
        return false;
    }

    OnCreated() {
        if (IsServer()) {
            this.SetStackCount(this.GetMaxCharges());
            if (this.GetReplenishType() == "async") {
                this.CalculateCharge();
            }
        }
    }

    OnRefresh() {
        if (IsServer()) {
            this.CalculateCharge();
        }
    }

    AddCharge() {
        this.IncrementStackCount();
        this.CalculateCharge();
    }

    RemoveCharge() {
        this.DecrementStackCount();
        this.CalculateCharge();
    }

    CalculateCharge() {
        if (this.GetReplenishType() == "async") {
            this.ability.EndCooldown();
            if (this.GetStackCount() >= this.GetMaxCharges()) {
                // Stop charging
                this.SetStackCount(this.GetMaxCharges());
                this.SetDuration(-1, true);
                this.StartIntervalThink(-1);
            } else {
                // If not charging
                if (this.GetRemainingTime() <= 0.05) {
                    // Start charging
                    const chargeTime = this.ability.GetCooldown(-1);
                    this.StartIntervalThink(chargeTime);
                    this.SetDuration(chargeTime, true);
                }
                // Set on cooldown if(no charges
                if (this.GetStackCount() == 0) {
                    this.ability.StartCooldown(this.GetRemainingTime());
                }
            }
        }

        if (this.GetReplenishType() == "sync") {
            if (this.GetStackCount() == this.GetMaxCharges()) {
                // Stop charging
                this.SetDuration(-1, false);
                this.StartIntervalThink(-1);
            }
            if (this.GetStackCount() < this.GetMaxCharges()) {
                // If not charging
                if (this.GetRemainingTime() <= 0.05) {
                    this.ResetCooldown();
                }
                // Set on cooldown if(no charges
                if (this.GetStackCount() == 0) {
                    this.ability.StartCooldown(this.GetRemainingTime());
                }
            }
        }
    }

    ResetCooldown() {
        this.StartIntervalThink(this.GetReplenishTime());
        this.SetDuration(this.GetReplenishTime(), true);
    }

    OnIntervalThink() {
        if (this.GetReplenishType() == "async") {
            this.IncrementStackCount();
            this.StartIntervalThink(-1);
            this.CalculateCharge();
        }
        if (this.GetReplenishType() == "sync") {
            this.SetStackCount(this.GetMaxCharges());
            this.StartIntervalThink(-1);
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.ON_ABILITY_FULLY_CAST, ModifierFunction.ON_DEATH];
    }

    OnDeath(event: ModifierInstanceEvent) {
        if (IsServer()) {
            if (event.unit != this.parent) {
                return;
            }
            this.SetStackCount(this.GetMaxCharges());
        }
    }

    OnAbilityFullyCast(event: ModifierAbilityEvent) {
        if (IsServer()) {
            if (event.unit != this.parent) {
                return;
            }
            if (event.ability == this.ability) {
                if (!GameRules.Addon.IsInWTFMode()) {
                    this.DecrementStackCount();
                    this.CalculateCharge();
                }
            }
        }
    }

    RefreshCharges() {
        this.SetStackCount(this.GetMaxCharges());
        this.CalculateCharge();
        this.ability.EndCooldown();
    }

    GetReplenishTime() {
        return 0;
    }

    GetReplenishType(): "sync" | "async" {
        return "sync";
    }

    GetMaxCharges() {
        return 1;
    }
}
//     Modifiers.StartTracking(modifier, MODIFIER_TYPES.CHARGES)
