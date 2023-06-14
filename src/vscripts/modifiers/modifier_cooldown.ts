import { CustomAbility } from "../abilities/framework/custom_ability";
import { registerModifier } from "../lib/dota_ts_adapter";
import { ModifierCombatEvents } from "./modifier_combat_events";

@registerModifier()
export class ModifierCooldown<A extends CDOTABaseAbility | undefined = CustomAbility> extends ModifierCombatEvents<A> {
    DestroyOnExpire() {
        return false;
    }

    OnCreated() {
        if (IsServer()) {
            this.StartCooldown();
        }
    }

    OnIntervalThink() {
        this.Replenish();
    }

    Replenish() {
        if (IsServer()) {
            if (!this.IsCooldownReady()) {
                this.SetDuration(-1, true);
                this.StartIntervalThink(-1);
                this.SetStackCount(1);

                this.OnReplenish();
            }
        }
    }

    ReduceCooldown(amount: number) {
        if (IsServer()) {
            const difference = this.GetRemainingTime() - amount;
            if (difference < 0) {
                this.Replenish();
            } else {
                this.StartCooldown(difference);
            }
        }
    }

    StartCooldown(cooldown?: number) {
        if (IsServer()) {
            const time = cooldown ?? this.GetReplenishTime();

            this.SetDuration(time, true);
            this.StartIntervalThink(time);
            this.SetStackCount(0);

            this.OnCooldownStart();
        }
    }

    OnReplenish() {}

    OnCooldownStart() {}

    GetReplenishTime() {
        return 0;
    }

    IsCooldownReady() {
        return this.GetStackCount() > 0;
    }
}
