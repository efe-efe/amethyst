import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierBanish } from "../../../modifiers/modifier_banish";
import { Translate } from "../../../modifiers/modifier_casting";
import { ModifierThinker, ModifierThinkerParams } from "../../../modifiers/modifier_thinker";
import { clampPosition, getCursorPosition } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";

@registerAbility("invoker_mobility")
class InvokerMobility extends CustomAbility {
    particleId?: ParticleID;

    GetAnimation() {
        return GameActivity.DOTA_SPAWN;
    }
    GetAnimationTranslate() {
        return Translate.loadout;
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
            EmitSoundOn("invoker_invoker_spawn_01", this.caster);

            return true;
        }
        return false;
    }

    OnAbilityPhaseInterrupted() {
        super.OnAbilityPhaseInterrupted();
        this.StopEffects();
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const cursor = getCursorPosition(this.caster);
        const point = clampPosition(origin, cursor, {
            maxRange: this.GetCastRange(Vector(0, 0, 0), undefined),
            minRange: this.GetSpecialValueFor("min_range")
        });

        ModifierInvokerMobilityThinker.createThinker(this.caster, this, point, {
            radius: this.GetSpecialValueFor("radius"),
            delayTime: this.GetSpecialValueFor("delay_time")
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
        let particleId = ParticleManager.CreateParticle(
            "particles/invoker/invoker_mobility_start.vpcf",
            ParticleAttachment.POINT,
            this.caster
        );
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

@registerModifier({ customNameForI18n: "modifier_invoker_mobility_thinker" })
class ModifierInvokerMobilityThinker extends ModifierThinker {
    particleId?: ParticleID;

    OnCreated(params: ModifierThinkerParams) {
        super.OnCreated(params);

        if (IsServer()) {
            AddFOWViewer(this.caster.GetTeamNumber(), this.origin, this.radius, this.delayTime + 0.2, true);
            this.PlayEffects();
            ModifierInvokerMobilityBanish.apply(this.caster, this.caster, this.ability, { duration: this.delayTime });
        }
    }

    OnDestroy() {
        super.OnDestroy();
        if (IsServer()) {
            this.StopEffects();
        }
    }

    OnReady() {
        FindClearSpaceForUnit(this.caster, this.origin, true);
        this.PlayEffectsOnReady();
        //this.caster.StartGestureWithPlaybackRate(GameActivity.DOTA_CAST_ABILITY_4, 1.5)
        this.Destroy();
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
        const particle_cast = "particles/units/heroes/hero_shadow_demon/shadow_demon_soul_catcher_v2_ground01.vpcf";
        this.particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.WORLDORIGIN, undefined);
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

@registerModifier({ customNameForI18n: "modifier_invoker_mobility_banish" })
class ModifierInvokerMobilityBanish extends ModifierBanish {
    CheckState() {
        return {
            ...super.CheckState(),
            [ModifierState.COMMAND_RESTRICTED]: true
        };
    }
}
