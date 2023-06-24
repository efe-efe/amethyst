import { CustomAbility } from "../../../../abilities/framework/custom_ability";
import { registerAbility, registerModifier } from "../../../../lib/dota_ts_adapter";
import { DisplacementParams, ModifierDisplacement, OnCollisionEvent } from "../../../../modifiers/modifier_displacement";
import { ModifierFadingSlow } from "../../../../modifiers/modifier_fading_slow";
import { ModifierStun } from "../../../../modifiers/modifier_stunned";
import { direction2D, fullyFaceTowards } from "../../../../util";

@registerAbility("centaur_charge")
class CentaurCharge extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_CENTAUR_STAMPEDE;
    }

    GetPlaybackRateOverride() {
        return 2.0;
    }

    GetCastingCrawl() {
        return 0;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const point = this.GetCursorPosition();
        const direction = direction2D(origin, point);

        fullyFaceTowards(this.caster, direction);

        ModifierCentaurChargeDisplacement.apply(this.caster, this.caster, this, {
            x: direction.x,
            y: direction.y,
            distance: this.GetCastRange(Vector(0, 0, 0), undefined),
            speed: 1200,
            peak: 30,
            radius: 200,
            teamFilter: UnitTargetTeam.ENEMY
        });

        this.PlayEffectsOnCast();
    }

    PlayEffectsOnCast() {
        EmitSoundOn("Hero_Centaur.Stampede.Cast", this.caster);
        ParticleManager.ReleaseParticleIndex(
            ParticleManager.CreateParticle("particles/blink_purple.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.caster)
        );
    }
}

@registerModifier({ customNameForI18n: "modifier_centaur_charge_displacement" })
class ModifierCentaurChargeDisplacement extends ModifierDisplacement {
    OnDestroy() {
        super.OnDestroy();

        if (IsServer()) {
            const particleId = ParticleManager.CreateParticle(
                "particles/phantom/mobility_trail.vpcf",
                ParticleAttachment.ABSORIGIN,
                this.parent
            );
            ParticleManager.SetParticleControl(particleId, 0, this.origin);
            ParticleManager.SetParticleControl(particleId, 1, this.parent.GetAbsOrigin());
            ParticleManager.SetParticleControl(particleId, 60, Vector(188, 7, 229));
            ParticleManager.SetParticleControl(particleId, 61, Vector(1, 0, 0));
            ParticleManager.ReleaseParticleIndex(particleId);
        }
    }

    OnCollide(event: OnCollisionEvent) {
        if (IsServer() && event.collision == "unit") {
            for (const unit of event.units) {
                if (!ModifierFadingSlow.findOne(unit)) {
                    ModifierFadingSlow.apply(unit, this.caster, undefined, {
                        duration: 5,
                        maxSlowPct: 100
                    });

                    ModifierStun.apply(unit, this.caster, undefined, { duration: 0.5 });
                }
            }
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.OVERRIDE_ANIMATION, ModifierFunction.OVERRIDE_ANIMATION_RATE];
    }

    GetOverrideAnimation() {
        return GameActivity.DOTA_RUN;
    }

    GetOverrideAnimationRate() {
        return 1.5;
    }
}

//@Refactor im not using this nowhere D:
@registerModifier({ customNameForI18n: "modifier_centaur_charge_knockback_displacement" })
class ModifierCentaurChargeKnockback extends ModifierDisplacement {
    DeclareFunctions() {
        return [ModifierFunction.OVERRIDE_ANIMATION, ModifierFunction.OVERRIDE_ANIMATION_RATE];
    }

    GetOverrideAnimation() {
        return GameActivity.DOTA_FLAIL;
    }
    GetOverrideAnimationRate() {
        return 1.0;
    }
}
