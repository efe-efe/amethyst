import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierBanish } from "../../../modifiers/modifier_banish";
import { ModifierCharges } from "../../../modifiers/modifier_charges";
import { getCursorPosition } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { ModifierPuckBasicAttack, PuckBasicAttack } from "./puck_basic_attack";

@registerAbility("puck_counter")
export class PuckCounter extends CustomAbility {
    GetIntrinsicModifierName() {
        return ModifierPuckCounterCharges.name;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const point = getCursorPosition(this.caster);
        const banishDuration = this.GetSpecialValueFor("banish_duration");

        ModifierPuckCounter.apply(this.caster, this.caster, this, { duration: banishDuration });

        if (this.GetLevel() >= 2) {
            ModifierPuckBasicAttack.findOne(this.caster)?.Replenish();
        }

        PuckBasicAttack.findOne(this.caster)?.LaunchProjectile(origin, point);
    }
}

@registerModifier({ customNameForI18n: "modifier_puck_counter_banish" })
class ModifierPuckCounter extends ModifierBanish {
    particleId?: ParticleID;

    OnCreated() {
        super.OnCreated();
        if (IsServer()) {
            EmitSoundOn("Hero_Puck.Phase_Shift", this.parent);

            this.particleId = ParticleManager.CreateParticle(
                "particles/units/heroes/hero_puck/puck_phase_shift.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.parent
            );
        }
    }

    OnDestroy() {
        super.OnDestroy();
        if (IsServer()) {
            StopSoundOn("Hero_Puck.Phase_Shift", this.parent);

            if (this.particleId) {
                ParticleManager.DestroyParticle(this.particleId, false);
                ParticleManager.ReleaseParticleIndex(this.particleId);
            }
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.ON_ORDER];
    }

    OnOrder(params) {
        // if (params.unit == this.parent) {
        //     if (
        //         params.order_type == DOTA_UNIT_ORDER_STOP ||
        //         params.order_type == DOTA_UNIT_ORDER_HOLD_POSITION ||
        //         params.order_type == DOTA_UNIT_ORDER_CAST_POSITION ||
        //         params.order_type == DOTA_UNIT_ORDER_CAST_NO_TARGET
        //     ) {
        //         this.Destroy();
        //     }
        // }
    }

    CheckState() {
        return {
            ...super.CheckState(),
            [ModifierState.ROOTED]: true
        };
    }

    // function modifier_puck_counter_banish:GetStatusLabel() return "Phase Shift" }
    // function modifier_puck_counter_banish:GetStatusPriority() return 4 }
    // function modifier_puck_counter_banish:GetStatusStyle() return "PhaseShift" }
}
// if IsClient() then require("wrappers/modifiers") }
// Modifiers.Banish(modifier_puck_counter_banish)
// Modifiers.Status(modifier_puck_counter_banish)

@registerModifier({ customNameForI18n: "modifier_puck_counter_charges" })
class ModifierPuckCounterCharges extends ModifierCharges {
    GetMaxCharges() {
        return this.Value("max_charges");
    }

    GetReplenishTime() {
        if (IsServer()) {
            return this.ability.GetCooldown(this.ability.GetLevel());
        }

        return 0;
    }
}
