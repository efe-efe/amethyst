import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { DisplacementParams, ModifierDisplacement, OnCollisionEvent } from "../../../modifiers/modifier_displacement";
import { direction2D, getCursorPosition } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { ModifierPangoRollEndAnimation } from "./modifier_pango_roll_end_animation";

@registerAbility("pango_ultimate")
class PangoUltimate extends CustomAbility {
    particleId?: ParticleID;

    GetAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_4;
    }

    GetPlaybackRateOverride() {
        return 1.0;
    }

    GetCastingCrawl() {
        return 0;
    }

    OnAbilityPhaseStart() {
        if (super.OnAbilityPhaseStart()) {
            this.particleId = EFX(
                "particles/units/heroes/hero_pangolier/pangolier_gyroshell_cast.vpcf",
                ParticleAttachment.WORLDORIGIN,
                undefined,
                {
                    cp0: this.caster.GetAbsOrigin(),
                    cp3: this.caster.GetAbsOrigin(),
                    cp5: this.caster.GetAbsOrigin()
                }
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

        const origin = this.caster.GetAbsOrigin();
        const point = getCursorPosition(this.caster);
        const direction = direction2D(origin, point);

        ModifierPangoUltimate.apply(this.caster, this.caster, this, {
            x: direction.x,
            y: direction.y,
            distance: 2000,
            speed: 2500,
            peak: 1,
            teamFilter: UnitTargetTeam.ENEMY
        });

        EmitSoundOn("Hero_Pangolier.Swashbuckle.Cast", this.caster);
    }
}

@registerModifier()
class ModifierPangoUltimate extends ModifierDisplacement {
    particleId?: ParticleID;
    bounces = 5;
    distance = 250;

    OnCreated(params: DisplacementParams) {
        super.OnCreated(params);

        if (IsServer()) {
            this.particleId = EFX(
                "particles/units/heroes/hero_pangolier/pangolier_gyroshell.vpcf",
                ParticleAttachment.CUSTOMORIGIN,
                this.parent,
                {
                    cp0: {
                        ent: this.parent,
                        point: "attach_hitloc"
                    }
                }
            );
            EFX("particles/units/heroes/hero_lion/lion_spell_voodoo.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.parent, {
                release: true
            });
            this.parent.StartGestureWithPlaybackRate(GameActivity.DOTA_RUN, 1.0);
            EmitSoundOn("Hero_Pangolier.Gyroshell.Loop", this.parent);
        }
    }

    OnDestroy() {
        super.OnDestroy();

        if (IsServer()) {
            if (this.particleId) {
                ParticleManager.DestroyParticle(this.particleId, false);
                ParticleManager.ReleaseParticleIndex(this.particleId);
            }

            StopSoundOn("Hero_Pangolier.Gyroshell.Loop", this.parent);
            this.parent.RemoveGesture(GameActivity.DOTA_RUN);

            ModifierPangoRollEndAnimation.apply(this.parent, this.parent, this.ability, { duration: 0.3 });
            // CustomEntitiesLegacy: SetAllAbilitiesActivated(this.parent, true);
        }
    }

    OnCollide(event: OnCollisionEvent) {
        if (IsServer()) {
            if (event.collision == "unit") {
                const origin = this.parent.GetAbsOrigin();
                for (const unit of event.units) {
                    const direction = direction2D(origin, unit.GetAbsOrigin());

                    if (!ModifierPangoUltimateDisplacement.findOne(unit)) {
                        ModifierPangoUltimateDisplacement.apply(unit, this.caster, this.ability, {
                            x: direction.x,
                            y: direction.y,
                            distance: this.distance,
                            speed: this.distance / 0.4,
                            peak: 150
                        });

                        ApplyDamage({
                            victim: unit,
                            attacker: this.parent,
                            damage: this.ability.GetSpecialValueFor("ability_damage"),
                            damage_type: DamageTypes.PURE
                        });

                        EmitSoundOn("Hero_Pangolier.Gyroshell.Stun", unit);
                    }
                }
            }
            if (event.collision == "wall") {
                EmitSoundOn("Hero_Pangolier.Gyroshell.Carom", this.parent);

                const direction = Vector(this.direction.x * -1, this.direction.y * -1, this.direction.z);

                ModifierPangoUltimate.apply(this.parent, this.parent, this.ability, {
                    x: direction.x,
                    y: direction.y,
                    distance: 2000,
                    speed: this.speed * 0.75,
                    peak: 1,
                    teamFilter: UnitTargetTeam.ENEMY
                });
            }
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.OVERRIDE_ANIMATION, ModifierFunction.OVERRIDE_ANIMATION_RATE, ModifierFunction.MODEL_CHANGE];
    }

    GetOverrideAnimation() {
        return GameActivity.DOTA_OVERRIDE_ABILITY_4;
    }

    GetOverrideAnimationRate() {
        return 1.5;
    }

    CheckState() {
        return {
            ...super.CheckState(),
            [ModifierState.NO_UNIT_COLLISION]: true
        };
    }

    GetModifierModelChange() {
        return "models/heroes/pangolier/pangolier_gyroshell2.vmdl";
    }
}

@registerModifier()
class ModifierPangoUltimateDisplacement extends ModifierDisplacement {
    DeclareFunctions() {
        return [ModifierFunction.OVERRIDE_ANIMATION, ModifierFunction.OVERRIDE_ANIMATION_RATE];
    }

    GetOverrideAnimation() {
        return GameActivity.DOTA_FLAIL;
    }

    GetOverrideAnimationRate() {
        return 1.0;
    }

    CheckState() {
        return {
            ...super.CheckState(),
            [ModifierState.NO_UNIT_COLLISION]: true
        };
    }
}
