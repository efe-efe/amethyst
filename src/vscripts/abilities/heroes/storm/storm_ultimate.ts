import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierBanish } from "../../../modifiers/modifier_banish";
import { ModifierDisplacement } from "../../../modifiers/modifier_displacement";
import { ModifierUpgradeStormUnleashedKnockback } from "../../../modifiers/upgrades/modifier_favors";
import { ModifierThinker } from "../../../modifiers/modifier_thinker";
import { clampPosition, direction2D, getCursorPosition } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";

@registerAbility("storm_ultimate")
class StormUltimate extends CustomAbility {
    particleId?: ParticleID;

    GetAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_1;
    }

    GetPlaybackRateOverride() {
        return 1.0;
    }

    GetCastingCrawl() {
        return 0;
    }

    OnAbilityPhaseStart() {
        if (super.OnAbilityPhaseStart()) {
            const origin = this.caster.GetAbsOrigin();
            ModifierStormUltimateBanish.apply(this.caster, this.caster, this, {
                duration: this.GetSpecialValueFor("delay_time") + this.GetCastPoint()
            });

            this.particleId = EFX("particles/storm/storm_ultimate_casting.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.caster, {
                cp1: Vector(100, 0, 0)
            });
            EmitGlobalSound("stormspirit_ss_spawn_07");
            EmitSoundOn("Hero_StormSpirit.StaticRemnantExplode", this.caster);
            EmitSoundOn("Hero_Zeus.BlinkDagger.Arcana", this.caster);
            EmitSoundOn("Hero_Zuus.GodsWrath.PreCast.Arcana", this.caster);
            EFX("particles/econ/items/zeus/arcana_chariot/zeus_arcana_blink_start.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
                cp0: origin,
                release: true
            });
            return true;
        }
        return false;
    }

    OnAbilityPhaseInterrupted() {
        super.OnAbilityPhaseInterrupted();
        if (this.particleId) {
            DEFX(this.particleId, false);
        }
    }

    OnSpellStart() {
        if (this.particleId) {
            DEFX(this.particleId, false);
        }

        const origin = this.caster.GetAbsOrigin();
        const cursor = getCursorPosition(this.caster);
        const point = clampPosition(origin, cursor, { maxRange: this.GetCastRange(Vector(0, 0, 0), undefined) });

        ModifierStormUltimateThinker.createThinker(this.caster, this, point, {
            delayTime: this.GetSpecialValueFor("delay_time"),
            radius: this.GetSpecialValueFor("radius")
        });
    }
}

@registerModifier({ customNameForI18n: "modifier_storm_ultimate" })
export class ModifierStormUltimate extends CustomModifier {
    OnDestroy() {
        if (IsServer()) {
            EFX("particles/units/heroes/hero_nyx_assassin/nyx_assassin_mana_burn.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.parent, {
                release: true
            });
        }
    }

    GetManaMultiplier() {
        return this.Value("mana_multiplier");
    }

    GetEffectName() {
        return "particles/storm/storm_ultimate.vpcf";
    }
    // function modifier_storm_ultimate:GetStatusLabel() return "Storm Unleashed" }
    // function modifier_storm_ultimate:GetStatusPriority() return 1 }
    // function modifier_storm_ultimate:GetStatusStyle() return "StormUnleashed" }
}
// if(IsClient()){ require("wrappers/modifiers") }
// Modifiers.Status(modifier_storm_ultimate)

@registerModifier({ customNameForI18n: "modifier_storm_ultimate_thinker" })
class ModifierStormUltimateThinker extends ModifierThinker {
    knockbackDistance = 500;

    OnReady() {
        EFX("particles/units/heroes/hero_zeus/zeus_cloud_strike.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
            cp0: this.origin,
            cp1: this.origin + Vector(0, 0, 1000),
            cp2: this.origin,
            release: true
        });
        EFX("particles/storm/storm_ultimate_impact.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
            cp0: this.origin,
            cp3: this.origin,
            release: true
        });
        EmitSoundOn("Hero_Zuus.GodsWrath.Target", this.caster);
        FindClearSpaceForUnit(this.caster, this.origin, true);
        ScreenShake(this.origin, 100, 300, 0.45, 1000, 0, true);

        const enemies = CustomEntitiesLegacy.FindUnitsInRadius(
            this.parent,
            this.parent.GetAbsOrigin(),
            this.Value("radius"),
            UnitTargetTeam.ENEMY,
            UnitTargetType.HERO + UnitTargetType.BASIC,
            UnitTargetFlags.NONE,
            FindOrder.ANY
        );

        for (const enemy of enemies) {
            ApplyDamage({
                victim: enemy,
                attacker: this.caster,
                damage: this.Value("ability_damage"),
                damage_type: DamageTypes.PURE
            });

            if (ModifierUpgradeStormUnleashedKnockback.findOne(this.caster)) {
                const direction = direction2D(this.origin, enemy.GetAbsOrigin());

                ModifierStormUltimateDisplacement.apply(enemy, this.caster, this.ability, {
                    x: direction.x,
                    y: direction.y,
                    distance: this.knockbackDistance,
                    speed: this.knockbackDistance / 0.35,
                    peak: 50
                });
            }
        }

        ModifierStormUltimate.apply(this.caster, this.caster, this.ability, { duration: this.Value("duration") });
        this.Destroy();
    }
}

@registerModifier({ customNameForI18n: "modifier_storm_ultimate_banish" })
class ModifierStormUltimateBanish extends ModifierBanish {
    CheckState() {
        return {
            ...super.CheckState(),
            [ModifierState.COMMAND_RESTRICTED]: true
        };
    }
}

@registerModifier({ customNameForI18n: "modifier_storm_ultimate_displacement" })
class ModifierStormUltimateDisplacement extends ModifierDisplacement {
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
            [ModifierState.NO_HEALTH_BAR]: true,
            [ModifierState.NO_UNIT_COLLISION]: true
        };
    }
}
