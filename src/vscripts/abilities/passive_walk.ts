import { registerAbility, registerModifier } from "../lib/dota_ts_adapter";
import { CustomAbility } from "./framework/custom_ability";
import { CustomModifier } from "./framework/custom_modifier";

@registerAbility("passive_walk")
class PassiveWalk extends CustomAbility {
    GetIntrinsicModifierName() {
        return ModifierPassiveWalk.name;
    }
}

@registerModifier({ customNameForI18n: "modifier_passive_walk" })
class ModifierPassiveWalk extends CustomModifier {
    direction = Vector(1, 0, 0);
    OnCreated() {
        if (IsServer()) {
            this.StartIntervalThink(3.0);
        }
    }

    OnIntervalThink() {
        const newOrigin = this.parent.GetAbsOrigin().__add(this.direction.__mul(500));
        this.parent.MoveToPosition(newOrigin);
        this.direction = Vector(this.direction.x * -1, this.direction.y, this.direction.z);
    }
}
