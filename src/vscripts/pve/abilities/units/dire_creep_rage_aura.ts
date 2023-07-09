import { CustomAbility } from "../../../abilities/framework/custom_ability";
import { CustomModifier } from "../../../abilities/framework/custom_modifier";
import { createRadiusMarker, findUnitsInRadius } from "../../../util";
import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";

@registerAbility("dire_creep_rage_aura")
class DireCreepRageAura extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_ATTACK;
    }

    GetPlaybackRateOverride() {
        return 1.0;
    }

    GetCastingCrawl() {
        return 0;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const radius = this.GetSpecialValueFor("radius");
        const duration = this.GetSpecialValueFor("duration");

        const allies = findUnitsInRadius(
            this.caster,
            origin,
            radius,
            UnitTargetTeam.FRIENDLY,
            UnitTargetType.HERO + UnitTargetType.BASIC,
            UnitTargetFlags.NONE,
            FindOrder.ANY
        );

        for (const ally of allies) {
            ModifierDireCreepRageAura.apply(ally, this.caster, this, { duration: duration });
        }

        createRadiusMarker(this.caster, this.caster.GetAbsOrigin(), radius, "public", 0.15);
        EmitSoundOn("General.Attack", this.caster);

        EFX(
            "particles/econ/items/lifestealer/ls_ti10_immortal/ls_ti10_immortal_infest_gold_shockwave.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            this.caster,
            {
                release: true
            }
        );
    }

    OnUpgrade() {
        EFX("particles/econ/items/invoker/invoker_ti7/invoker_ti7_alacrity_buff.vpcf", ParticleAttachment.OVERHEAD_FOLLOW, this.caster, {
            release: true
        });
    }
}

@registerModifier("modifier_dire_creep_rage_aura")
class ModifierDireCreepRageAura extends CustomModifier {
    particleId?: ParticleID;

    OnCreated() {
        if (IsServer()) {
            this.particleId = EFX(
                "particles/econ/items/lycan/ti9_immortal/lycan_ti9_immortal_howl_buff.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.parent,
                {}
            );
        }
    }

    OnDestroy() {
        if (IsServer() && this.particleId) {
            DEFX(this.particleId, false);
        }
    }

    DeclareFunctions() {
        return [
            ModifierFunction.PREATTACK_BONUS_DAMAGE,
            ModifierFunction.MOVESPEED_BONUS_PERCENTAGE,
            ModifierFunction.ATTACKSPEED_BONUS_CONSTANT
        ];
    }

    GetModifierAttackSpeedBonus_Constant() {
        return this.Value("as_speed");
    }

    GetModifierMoveSpeedBonus_Percentage() {
        return this.Value("ms_buff_pct");
    }

    GetModifierPreAttack_BonusDamage() {
        return this.Value("damage_bonus");
    }
}
