import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierDisplacement } from "../../../modifiers/modifier_displacement";
import { CustomAbility } from "../../framework/custom_ability";
import { ModifierPangoMobility } from "./modifier_pango_mobility";
import { PangoSpecialAttack } from "./pango_special_attack";

@registerAbility("pango_mobility")
class PangoMobility extends CustomAbility {
    particleId?: ParticleID;

    GetAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_4;
    }

    GetPlaybackRateOverride() {
        return 2.0;
    }

    GetCastingCrawl() {
        return 80;
    }

    OnAbilityPhaseStart() {
        if (super.OnAbilityPhaseStart()) {
            this.particleId = ParticleManager.CreateParticle(
                "particles/pango/pango_mobility.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.caster
            );
            ParticleManager.SetParticleControlEnt(
                this.particleId,
                1,
                this.caster,
                ParticleAttachment.ABSORIGIN_FOLLOW,
                "attach_hitloc",
                this.caster.GetAbsOrigin(),
                false
            );
            EmitSoundOn("Hero_Pangolier.Gyroshell.Cast", this.caster);
            return true;
        }
        return false;
    }

    OnAbilityPhaseInterrupted() {
        super.OnAbilityPhaseInterrupted();
        if (this.particleId) {
            DEFX(this.particleId, false);
        }
        StopSoundOn("Hero_Pangolier.Gyroshell.Cast", this.caster);
    }

    OnSpellStart() {
        if (this.particleId) {
            DEFX(this.particleId, false);
        }
        const duration = this.GetSpecialValueFor("duration");

        ModifierPangoMobility.apply(this.caster, this.caster, this, { duration: duration });
        StopSoundOn("Hero_Pangolier.Gyroshell.Cast", this.caster);

        if (this.GetLevel() >= 2) {
            PangoSpecialAttack.findOne(this.caster)?.EndCooldown();
        }
    }
}
