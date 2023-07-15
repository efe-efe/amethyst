import { CustomAbility } from "../../../../abilities/framework/custom_ability";
import { registerAbility } from "../../../../lib/dota_ts_adapter";
import { ModifierStun } from "../../../../modifiers/modifier_stunned";
import { precache, resource } from "../../../../precache";
import { createTimedRadiusMarker, findUnitsInRadius } from "../../../../util";

const resources = precache({
    cast: resource.fx("particles/econ/items/centaur/centaur_ti6/centaur_ti6_warstomp.vpcf")
});

@registerAbility("centaur_short_attack")
class CentaurShortAttack extends CustomAbility {
    marker?: ReturnType<typeof createTimedRadiusMarker>;

    GetAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_1;
    }

    GetPlaybackRateOverride() {
        return 0.8;
    }

    GetCastingCrawl() {
        return 0;
    }

    OnAbilityPhaseStart() {
        if (super.OnAbilityPhaseStart()) {
            this.marker = createTimedRadiusMarker(
                this.caster,
                this.caster.GetAbsOrigin(),
                this.GetSpecialValueFor("radius"),
                this.GetCastPoint(),
                0.2,
                "public"
            );

            return true;
        }
        return false;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const radius = this.GetSpecialValueFor("radius");

        EmitSoundOn("Hero_Centaur.HoofStomp", this.caster);

        const enemies = findUnitsInRadius(
            this.caster,
            origin,
            radius,
            UnitTargetTeam.ENEMY,
            UnitTargetType.HERO + UnitTargetType.BASIC,
            UnitTargetFlags.NONE,
            FindOrder.ANY
        );

        for (const enemy of enemies) {
            ApplyDamage({
                victim: enemy,
                attacker: this.caster,
                damage: 20,
                damage_type: DamageTypes.PURE
            });

            ModifierStun.apply(enemy, this.caster, undefined, { duration: 0.5 });
        }

        EFX(resources.cast.path, ParticleAttachment.WORLDORIGIN, undefined, {
            cp0: origin,
            cp1: Vector(radius, 0, 0),
            release: true
        });
    }
}
