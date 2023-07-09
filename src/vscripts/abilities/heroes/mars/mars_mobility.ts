import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierBanish } from "../../../modifiers/modifier_banish";
import { ModifierThinker, ModifierThinkerParams } from "../../../modifiers/modifier_thinker";
import { clampPosition, findUnitsInRadius, getCursorPosition } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";

@registerAbility("mars_mobility")
class MarsMobility extends CustomAbility {
    particleId?: ParticleID;

    GetAnimation() {
        return GameActivity.DOTA_GENERIC_CHANNEL_1;
    }

    GetPlaybackRateOverride() {
        return 1.5;
    }

    GetCastingCrawl() {
        return 0;
    }

    OnAbilityPhaseStart() {
        if (super.OnAbilityPhaseStart()) {
            this.particleId = ParticleManager.CreateParticle(
                "particles/econ/events/ti10/fountain_regen_ti10_lvl3.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.caster
            );

            EmitSoundOn("mars_mars_spawn_01", this.caster);

            return true;
        }
        return false;
    }

    OnAbilityPhaseInterrupted() {
        this.StopEffects();
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const cursor = getCursorPosition(this.caster);
        const point = clampPosition(origin, cursor, {
            maxRange: this.GetCastRange(Vector(0, 0, 0), undefined),
            minRange: this.GetSpecialValueFor("min_range")
        });

        ModifierMarsMobilityThinker.createThinker(this.caster, this, point, {
            delayTime: this.GetSpecialValueFor("delay_time"),
            radius: this.GetSpecialValueFor("radius")
        });

        this.PlayEffectsOnCast();
        this.StopEffects();
    }

    StopEffects() {
        if (this.particleId) {
            ParticleManager.DestroyParticle(this.particleId, false);
            ParticleManager.ReleaseParticleIndex(this.particleId);
        }
    }

    PlayEffectsOnCast() {
        let particleId = ParticleManager.CreateParticle("particles/mars/mars_mobility_start.vpcf", ParticleAttachment.POINT, this.caster);
        ParticleManager.SetParticleControl(particleId, 0, this.caster.GetAbsOrigin());
        ParticleManager.SetParticleControl(particleId, 1, Vector(250, 1, 1));
        ParticleManager.ReleaseParticleIndex(particleId);

        particleId = ParticleManager.CreateParticle(
            "particles/econ/events/ti10/blink_dagger_start_ti10_lvl2.vpcf",
            ParticleAttachment.POINT,
            this.caster
        );
        ParticleManager.ReleaseParticleIndex(particleId);
        ParticleManager.SetParticleControl(particleId, 0, this.caster.GetAbsOrigin());
    }
}

@registerModifier("modifier_mars_mobility_banish")
class ModifierMarsMobilityBanish extends ModifierBanish {
    CheckState() {
        return {
            ...super.CheckState(),
            [ModifierState.COMMAND_RESTRICTED]: true
        };
    }
}

@registerModifier("modifier_mars_mobility_thinker")
class ModifierMarsMobilityThinker extends ModifierThinker {
    particleId?: ParticleID;

    OnCreated(params: ModifierThinkerParams) {
        super.OnCreated(params);

        if (IsServer()) {
            this.PlayEffects();
            ModifierMarsMobilityBanish.apply(this.caster, this.caster, this.ability, { duration: this.delayTime });
        }
    }

    OnDestroy() {
        super.OnDestroy();

        if (IsServer()) {
            this.StopEffects();
        }
    }

    OnReady() {
        if (IsServer()) {
            FindClearSpaceForUnit(this.caster, this.parent.GetAbsOrigin(), true);

            const enemies = findUnitsInRadius(
                this.caster,
                this.origin,
                this.radius,
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
            }
        }

        this.PlayEffectsOnReady();
        this.caster.StartGestureWithPlaybackRate(GameActivity.DOTA_CAST_ABILITY_4, 1.5);
    }

    PlayEffectsOnReady() {
        EmitSoundOn("Hero_Nevermore.ROS_Flames", this.caster);

        let particleId = ParticleManager.CreateParticle(
            "particles/econ/events/ti10/blink_dagger_end_ti10_lvl2.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined
        );
        ParticleManager.SetParticleControl(particleId, 0, this.caster.GetAbsOrigin());

        particleId = ParticleManager.CreateParticle(
            "particles/econ/items/lina/lina_ti7/lina_spell_light_strike_array_ti7.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined
        );
        ParticleManager.SetParticleControl(particleId, 0, this.caster.GetAbsOrigin());
        ParticleManager.SetParticleControl(particleId, 1, Vector(this.radius, 5, 1));
        ParticleManager.ReleaseParticleIndex(particleId);

        particleId = ParticleManager.CreateParticle(
            "particles/econ/items/axe/axe_helm_shoutmask/axe_beserkers_call_owner_shoutmask.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined
        );
        ParticleManager.SetParticleControl(particleId, 0, this.caster.GetAbsOrigin());
        ParticleManager.SetParticleControl(particleId, 2, Vector(this.radius, 1, 1));
        ParticleManager.ReleaseParticleIndex(particleId);

        ScreenShake(this.caster.GetAbsOrigin(), 100, 300, 0.45, 1000, 0, true);
    }

    PlayEffects() {
        this.particleId = ParticleManager.CreateParticle(
            "particles/units/heroes/hero_shadow_demon/shadow_demon_soul_catcher_v2_ground01.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined
        );
        ParticleManager.SetParticleControl(this.particleId, 0, this.parent.GetAbsOrigin());
        ParticleManager.SetParticleControl(this.particleId, 1, this.parent.GetAbsOrigin());
        ParticleManager.SetParticleControl(this.particleId, 2, this.parent.GetAbsOrigin());
        ParticleManager.SetParticleControl(this.particleId, 3, Vector(this.radius, 0, 0));
    }

    StopEffects() {
        if (this.particleId) {
            ParticleManager.DestroyParticle(this.particleId, false);
            ParticleManager.ReleaseParticleIndex(this.particleId);
        }
    }
}
