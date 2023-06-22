import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { DisplacementParams, ModifierDisplacement, OnCollisionEvent } from "../../../modifiers/modifier_displacement";
import { ModifierFadingSlow } from "../../../modifiers/modifier_fading_slow";
import { clampPosition, direction2D, giveManaAndEnergyPercent, isGem, isObstacle } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";
import { ModifierNevermoreStacks } from "./nevermore_basic_attack";

@registerAbility("nevermore_mobility")
class NevermoreMobility extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_RAZE_1;
    }
    GetPlaybackRateOverride() {
        return 1.1;
    }
    GetCastingCrawl() {
        return 0;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const cursor = CustomAbilitiesLegacy.GetCursorPosition(this);
        const point = clampPosition(origin, cursor, {
            maxRange: this.GetCastRange(Vector(0, 0, 0), undefined),
            minRange: this.GetSpecialValueFor("min_range")
        });
        const direction = direction2D(origin, point);
        const distance = point.__sub(origin).Length2D();

        ModifierNevermoreMobility.apply(this.caster, this.caster, this, {
            x: direction.x,
            y: direction.y,
            distance: distance,
            speed: distance / 0.4,
            peak: 0,
            teamFilter: UnitTargetTeam.ENEMY
        });

        this.PlayEffectsOnCast();
    }

    PlayEffectsOnCast() {
        EmitSoundOn("Hero_Nevermore.Death", this.caster);
    }
}

@registerModifier({ customNameForI18n: "modifier_nevermore_mobility_displacement" })
class ModifierNevermoreMobility extends ModifierDisplacement {
    OnCreated(params: DisplacementParams) {
        super.OnCreated(params);

        if (IsServer()) {
            const particleId = ParticleManager.CreateParticle(
                "particles/econ/items/shadow_fiend/sf_desolation/sf_desolation_scratch.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.parent
            );
            ParticleManager.SetParticleControl(particleId, 0, this.parent.GetAbsOrigin());
            ParticleManager.ReleaseParticleIndex(particleId);
        }
    }

    OnDestroy() {
        super.OnDestroy();

        if (IsServer()) {
            this.parent.StartGestureWithPlaybackRate(GameActivity.DOTA_TELEPORT_END, 2.0);
            this.PlayEffectsOnDestroy();
        }
    }

    OnCollide(event: OnCollisionEvent) {
        if (IsServer() && event.collision == "unit") {
            for (const unit of event.units.filter(unit => !ModifierNevermoreMobilityMark.findOne(unit))) {
                ApplyDamage({
                    victim: unit,
                    attacker: this.parent,
                    damage: this.Value("ability_damage"),
                    damage_type: DamageTypes.PURE
                });

                if (!isObstacle(unit) && !isGem(unit)) {
                    giveManaAndEnergyPercent(this.parent, this.Value("mana_gain_pct"), true);

                    ModifierNevermoreStacks.findOne(this.caster)?.IncrementStackCount();
                    ModifierNevermoreStacks.findOne(this.caster)?.IncrementStackCount();

                    this.PlayEffectsOnImpact(unit);
                    this.PlayEffectsOnImpact(unit);
                }

                ModifierNevermoreMobilityMark.apply(unit, this.parent, this.ability, { duration: 1.0 });

                ModifierFadingSlow.apply(unit, this.parent, undefined, {
                    duration: this.Value("fading_slow_duration"),
                    maxSlowPct: this.Value("fading_slow_pct")
                });
            }
        }
    }

    // GetOnThinkCallback(){
    //     this.PlayEffectsOnDestroy()
    // }

    PlayEffectsOnDestroy() {
        const particleId = ParticleManager.CreateParticle(
            "particles/nevermore/nevermore_mobility.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined
        );
        ParticleManager.SetParticleControl(particleId, 0, this.parent.GetAbsOrigin());
        ParticleManager.SetParticleControl(particleId, 1, Vector(250, 1, 1));
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    PlayEffectsOnImpact(target: CDOTA_BaseNPC) {
        EmitSoundOn("Hero_Nevermore.ProjectileImpact", target);

        const info = {
            Target: this.parent,
            Source: target,
            EffectName: "particles/units/heroes/hero_nevermore/nevermore_necro_souls.vpcf",
            iMoveSpeed: 400,
            vSourceLoc: target.GetAbsOrigin(),
            bDodgeable: false,
            bReplaceExisting: false,
            flExpireTime: GameRules.GetGameTime() + 5,
            bProvidesVision: false
        };
        ProjectileManager.CreateTrackingProjectile(info);
    }

    DeclareFunctions() {
        return [ModifierFunction.OVERRIDE_ANIMATION, ModifierFunction.TRANSLATE_ACTIVITY_MODIFIERS];
    }

    GetOverrideAnimation() {
        return GameActivity.DOTA_FLAIL;
    }

    GetActivityTranslationModifiers() {
        return "forcestaff_friendly";
    }

    CheckState() {
        return {
            ...super.CheckState(),
            [ModifierState.NO_HEALTH_BAR]: true,
            [ModifierState.INVULNERABLE]: true,
            [ModifierState.OUT_OF_GAME]: true,
            [ModifierState.NO_UNIT_COLLISION]: true
        };
    }
}

@registerModifier({ customNameForI18n: "modifier_nevermore_mobility_hit" })
class ModifierNevermoreMobilityMark extends CustomModifier {
    IsPermanent() {
        return true;
    }

    IsHidden() {
        return true;
    }
}
