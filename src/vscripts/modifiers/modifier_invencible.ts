import { CustomModifier } from "../abilities/framework/custom_modifier";
import { registerModifier } from "../lib/dota_ts_adapter";
import { strongPurge } from "../util";

@registerModifier("modifier_generic_invencible")
export class ModifierInvencible extends CustomModifier {
    IsHidden() {
        return false;
    }

    IsDebuff() {
        return false;
    }

    IsPurgable() {
        return true;
    }

    OnCreated() {
        if (IsServer()) {
            this.PlayEffects();
            this.StartIntervalThink(0.05);
        }
    }

    OnIntervalThink() {
        strongPurge(this.parent);
    }

    DeclareFunctions() {
        return [ModifierFunction.INCOMING_DAMAGE_PERCENTAGE];
    }

    GetModifierIncomingDamage_Percentage() {
        return -100;
    }

    PlayEffects() {
        ParticleManager.ReleaseParticleIndex(
            ParticleManager.CreateParticle(
                "particles/econ/items/monkey_king/arcana/fire/mk_arcana_fire_spring_ring_radial.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.parent
            )
        );
    }

    GetStatusEffectName() {
        return "particles/status_fx/status_effect_electrical.vpcf";
    }

    // function modifier_generic_invencible:GetStatusLabel() return "Invulnerable" }
    // function modifier_generic_invencible:GetStatusPriority() return 1 }
    // function modifier_generic_invencible:GetStatusStyle() return "BladeFury" }
}
// if IsClient() then require("wrappers/modifiers") }
// Modifiers.Status(modifier_generic_invencible)
