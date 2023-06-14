import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierCharges } from "../../../modifiers/modifier_charges";
import { DisplacementParams, ModifierDisplacement, OnCollisionEvent } from "../../../modifiers/modifier_displacement";
import { ModifierShield } from "../../../modifiers/modifier_shield";
import { direction2D } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";
import { PhantomBasicAttack } from "./phantom_basic_attack";

@registerAbility("phantom_mobility")
class PhantomMobility extends CustomAbility {
    GetIntrinsicModifierName() {
        return ModifierPhantomMobilityCharges.name;
    }
    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const point = CustomAbilitiesLegacy.GetCursorPosition(this);
        const phantomBasicAttack = PhantomBasicAttack.findOne(this.caster);
        const distance = this.GetCastRange(Vector(0, 0, 0), this.caster) + this.caster.GetCastRangeBonus();
        const casterDirection = CustomEntitiesLegacy.GetDirection(this.caster);
        const direction = casterDirection.x != 0 || casterDirection.y != 0 ? casterDirection : direction2D(origin, point);

        ModifierPhantomMobilityDisplacement.apply(this.caster, this.caster, this, {
            x: direction.x,
            y: direction.y,
            distance: distance,
            speed: distance / 0.15,
            peak: 30,
            teamFilter: UnitTargetTeam.ENEMY
        });

        if (phantomBasicAttack) {
            phantomBasicAttack.TryThrowKnives("modifier_upgrade_phantom_dash_damage");
        }
        this.PlayEffectsOnCast();
    }
    PlayEffectsOnCast() {
        EmitSoundOn("Hero_PhantomAssassin.Strike.Start", this.GetCaster());
        const effect_cast = ParticleManager.CreateParticle(
            "particles/blink_purple.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            this.GetCaster()
        );
        ParticleManager.ReleaseParticleIndex(effect_cast);
    }
}

@registerModifier({ customNameForI18n: "modifier_phantom_mobility_charges" })
class ModifierPhantomMobilityCharges extends ModifierCharges {
    GetMaxCharges() {
        //@Refactor this might not work
        return this.Value("max_charges");
    }

    GetReplenishTime() {
        if (IsServer()) {
            return this.ability.GetCooldown(this.ability.GetLevel());
        }

        return 0;
    }
}

@registerModifier({ customNameForI18n: "modifier_phantom_mobility_displacement" })
class ModifierPhantomMobilityDisplacement extends ModifierDisplacement {
    OnCreated(params: DisplacementParams) {
        super.OnCreated(params);
        if (IsServer()) {
            this.origin = this.parent.GetAbsOrigin();
        }
    }

    OnDestroy() {
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
        if (IsServer()) {
            if (event.collision == "unit") {
                for (const unit of event.units) {
                    if (!ModifierPhantomMobility.findOne(unit)) {
                        ModifierPhantomMobility.apply(unit, this.parent, this.ability, { duration: 5 });

                        const shieldModifier = this.parent.FindModifierByName("modifier_upgrade_phantom_dash_shield");
                        if (shieldModifier) {
                            ModifierPhantomMobilityShield.apply(this.parent, this.parent, undefined, {
                                duration: 5.0,
                                damageBlock: 0 //@Refactor fix this
                                // damageBlock: shieldModifier.GetDamageBlock()
                            });
                        }
                    }
                }
            }
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.OVERRIDE_ANIMATION, ModifierFunction.OVERRIDE_ANIMATION_RATE];
    }

    GetOverrideAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_2;
    }
    GetOverrideAnimationRate() {
        return 1.5;
    }

    GetCollisionRadius() {
        return 120;
    }
}

@registerModifier({ customNameForI18n: "modifier_phantom_mobility_debuff" })
class ModifierPhantomMobility extends CustomModifier {
    IsHidden() {
        return true;
    }

    IsPurgable() {
        return false;
    }
}

@registerModifier({ customNameForI18n: "modifier_phantom_mobility_shield" })
class ModifierPhantomMobilityShield extends ModifierShield {
    // function modifier_phantom_mobility_shield:GetStatusLabel() return "Dash Shield" }
    // function modifier_phantom_mobility_shield:GetStatusPriority() return 3 }
    // function modifier_phantom_mobility_shield:GetStatusStyle() return "Shield" }
}
