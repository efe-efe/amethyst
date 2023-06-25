import { registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierDisplacement } from "../../../modifiers/modifier_displacement";
import { direction2D } from "../../../util";
import { CustomModifier } from "../../framework/custom_modifier";
import { ModifierPangoRollEndAnimation } from "./modifier_pango_roll_end_animation";

@registerModifier()
export class ModifierPangoMobility extends CustomModifier {
    particleId?: ParticleID;

    OnCreated() {
        if (IsServer()) {
            const origin = this.parent.GetAbsOrigin();

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
            EFX("particles/storm/storm_ex_mobility_strike.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
                cp0: origin,
                cp1: origin + Vector(0, 0, 1000),
                cp2: origin,
                release: true
            });
            EFX("particles/units/heroes/hero_lion/lion_spell_voodoo.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.parent, {
                release: true
            });

            this.parent.StartGestureWithPlaybackRate(GameActivity.DOTA_RUN, 1.0);
            EmitSoundOn("Hero_Pangolier.Gyroshell.Loop", this.parent);
            EmitSoundOn("Hero_Juggernaut.Attack", this.parent);

            this.StartIntervalThink(0.1);
            // CustomEntitiesLegacy:DeactivateNonPriorityAbilities(this.parent)
        }
    }

    OnIntervalThink() {
        // CustomEntitiesLegacy:DeactivateNonPriorityAbilities(this.parent)
        const origin = this.parent.GetAbsOrigin();

        const enemies = CustomEntitiesLegacy.FindUnitsInRadius(
            this.caster,
            origin,
            this.Value("radius"),
            UnitTargetTeam.ENEMY,
            UnitTargetType.HERO + UnitTargetType.BASIC,
            UnitTargetFlags.NONE,
            FindOrder.ANY
        );

        const distance = this.Value("radius") * 1.5;

        for (const enemy of enemies) {
            const direction = direction2D(origin, enemy.GetAbsOrigin());

            if (!ModifierPangoMobilityDisplacement.findOne(enemy) && !ModifierPangoMobilityMark.findOne(enemy)) {
                ModifierPangoMobilityDisplacement.apply(enemy, enemy, this.ability, {
                    x: direction.x,
                    y: direction.y,
                    distance: distance,
                    speed: distance / 0.3,
                    peak: 150
                });

                ModifierPangoMobilityMark.apply(enemy, enemy, this.ability, { duration: 1.0 });

                ApplyDamage({
                    victim: enemy,
                    attacker: this.parent,
                    damage: this.Value("ability_damage"),
                    damage_type: DamageTypes.PURE
                });

                EmitSoundOn("Hero_Pangolier.Gyroshell.Stun", enemy);
            }
        }
    }

    OnDestroy() {
        if (IsServer()) {
            if (this.particleId) {
                ParticleManager.DestroyParticle(this.particleId, false);
                ParticleManager.ReleaseParticleIndex(this.particleId);
            }
            StopSoundOn("Hero_Pangolier.Gyroshell.Loop", this.parent);
            this.parent.RemoveGesture(GameActivity.DOTA_RUN);
            ModifierPangoRollEndAnimation.apply(this.parent, this.parent, this.ability, { duration: 0.3 });
            // CustomEntitiesLegacy:SetAllAbilitiesActivated(this.parent, true)
        }
    }

    CheckState() {
        return {
            [ModifierState.NO_UNIT_COLLISION]: true
        };
    }

    DeclareFunctions() {
        return [
            ModifierFunction.ON_ORDER,
            ModifierFunction.MOVESPEED_BONUS_PERCENTAGE,
            ModifierFunction.OVERRIDE_ANIMATION,
            ModifierFunction.MODEL_CHANGE
        ];
    }

    OnOrder(event: ModifierUnitEvent) {
        if (event.unit == this.parent && (event.order_type == UnitOrder.STOP || event.order_type == UnitOrder.HOLD_POSITION)) {
            this.Destroy();
        }
    }

    GetModifierModelChange() {
        return "models/heroes/pangolier/pangolier_gyroshell2.vmdl";
    }

    GetOverrideAnimation() {
        return GameActivity.DOTA_OVERRIDE_ABILITY_4;
    }

    GetModifierMoveSpeedBonus_Percentage() {
        return this.Value("speed_buff_pct");
    }

    // function modifier_pango_mobility:GetStatusLabel() return "Rolling Thunder" }
    // function modifier_pango_mobility:GetStatusPriority() return 4 }
    // function modifier_pango_mobility:GetStatusStyle() return "RollingThunder" }
}
// if(IsClient() ) { require("wrappers/modifiers") }
// Modifiers.Status(modifier_pango_mobility)
// Modifiers.MoveForced(modifier_pango_mobility)

@registerModifier()
class ModifierPangoMobilityDisplacement extends ModifierDisplacement {
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

@registerModifier()
class ModifierPangoMobilityMark extends CustomModifier {
    IsPermanent() {
        return true;
    }

    IsHidden() {
        return true;
    }
}
