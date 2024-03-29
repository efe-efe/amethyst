import { CustomAbility } from "../../../abilities/framework/custom_ability";
import { registerAbility } from "../../../lib/dota_ts_adapter";
import { createRadiusMarker, findUnitsInRadius } from "../../../util";

@registerAbility("radiant_creep_heal_aura")
class RadiantCreepHealAura extends CustomAbility {
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
        const heal = this.GetSpecialValueFor("heal");

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
            ally.Heal(heal, this);
        }

        createRadiusMarker(this.caster, this.caster.GetAbsOrigin(), radius, "public", 0.15);
        EmitSoundOn("General.Attack", this.caster);

        EFX("particles/radiant_zombie/heal.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.caster, {
            release: true
        });
    }

    OnUpgrade() {
        EFX("particles/radiant_zombie/heal_aura.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.caster, {
            release: true
        });
    }
}
