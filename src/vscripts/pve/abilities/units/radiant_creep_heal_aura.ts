import { CustomAbility } from "../../../abilities/framework/custom_ability";
import { registerAbility } from "../../../lib/dota_ts_adapter";
import { createRadiusMarker } from "../../../util";

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

        const enemies = CustomEntitiesLegacy.FindUnitsInRadius(
            this.caster,
            origin,
            radius,
            UnitTargetTeam.ENEMY,
            UnitTargetType.HERO + UnitTargetType.BASIC,
            UnitTargetFlags.NONE,
            FindOrder.ANY
        );

        for (const enemy of enemies) {
            enemy.Heal(heal, this);
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
