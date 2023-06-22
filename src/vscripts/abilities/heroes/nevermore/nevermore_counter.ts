import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierBanish } from "../../../modifiers/modifier_banish";
import { OnHitEvent } from "../../../modifiers/modifier_combat_events";
import { ModifierCounter } from "../../../modifiers/modifier_counter";
import { ModifierThinker, ModifierThinkerParams } from "../../../modifiers/modifier_thinker";
import { clampPosition, createRadiusMarker, strongPurge } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";

class NevermoreCounterCommon extends CustomAbility {
    PlayEffectsFear() {
        const origin = this.caster.GetAbsOrigin();

        EFX("particles/econ/events/ti4/blink_dagger_end_ti4.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
            cp0: origin,
            release: true
        });

        const particleId = EFX(
            "particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined,
            {
                cp0: origin
            }
        );
        ParticleManager.SetParticleControl(particleId, 60, Vector(157, 0, 243));
        ParticleManager.SetParticleControl(particleId, 61, Vector(1, 0, 0));
        ParticleManager.ReleaseParticleIndex(particleId);

        EFX(
            "particles/econ/items/outworld_devourer/od_ti8/od_ti8_santies_eclipse_area_shockwave.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined,
            {
                cp0: origin,
                release: true
            }
        );

        ScreenShake(origin, 100, 300, 0.45, 1000, 0, true);
    }
}

@registerAbility("nevermore_counter")
class NevermoreCounter extends NevermoreCounterCommon {
    OnSpellStart() {
        ModifierNevermoreCounter.apply(this.caster, this.caster, this, { duration: this.GetSpecialValueFor("counter_duration") });
        EmitSoundOn("Hero_Nevermore.RequiemOfSoulsCast", this.caster);

        //   LinkAbilityCooldowns(this.caster, 'nevermore_ex_counter')
    }
}

@registerAbility("nevermore_ex_counter")
class NevermoreExCounter extends NevermoreCounterCommon {
    // nevermore_ex_counter.PlayEffectsFear = nevermore_counter.PlayEffectsFear

    GetAnimation() {
        return GameActivity.DOTA_RAZE_2;
    }

    GetPlaybackRateOverride() {
        return 1.3;
    }

    GetCastingCrawl() {
        return 0;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const duration = this.GetSpecialValueFor("fear_duration");
        const radius = this.GetSpecialValueFor("radius");

        createRadiusMarker(this.caster, origin, radius, "public", 0.1);

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
            ApplyDamage({
                victim: enemy,
                attacker: this.caster,
                damage: this.GetSpecialValueFor("ability_damage"),
                damage_type: DamageTypes.PURE
            });
            //    unit:AddNewModifier(this.caster, this, 'modifier_nevermore_counter_fear', { duration = duration })
        }

        this.PlayEffectsFear();
        EmitSoundOn("Hero_Nevermore.Shadowraze.Arcana", this.caster);
        EmitSoundOn("nevermore_nev_arc_ability_shadow_24", this.caster);
        // LinkAbilityCooldowns(this.caster, 'nevermore_counter')
    }
}

@registerModifier({ customNameForI18n: "modifier_nevermore_counter_countering" })
class ModifierNevermoreCounter extends ModifierCounter {
    OnDestroy() {
        super.OnDestroy();

        if (IsServer()) {
            StopSoundOn("Hero_Nevermore.RequiemOfSoulsCast", this.caster);
            EmitSoundOn("Hero_Juggernaut.Attack", this.caster);
            ParticleManager.ReleaseParticleIndex(
                ParticleManager.CreateParticle(
                    "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_omni_slash_tgt_bonus.vpcf",
                    ParticleAttachment.ABSORIGIN_FOLLOW,
                    this.caster
                )
            );
        }
    }

    OnHit(event: OnHitEvent) {
        if (IsServer()) {
            ModifierNevermoreCounterBanish.apply(this.parent, this.parent, this.ability, {
                duration: this.Value("banish_duration")
            });

            strongPurge(this.parent);
            this.PlayEffectsOnTrigger();

            if (event.attackCategory == "projectile") {
                if (event.projectile.getIsDestructible()) {
                    event.projectile.scheduleDestroy();
                }
            }
            return false;
        }

        return true;
    }

    AfterHit() {
        this.Destroy();
    }

    GetMovementSpeedPercentage() {
        return 0;
    }

    DeclareFunctions() {
        return [...super.DeclareFunctions(), ModifierFunction.OVERRIDE_ANIMATION, ModifierFunction.OVERRIDE_ANIMATION_RATE];
    }

    GetOverrideAnimation() {
        return GameActivity.DOTA_TELEPORT;
    }

    GetOverrideAnimationRate() {
        return 1.0;
    }

    PlayEffectsOnTrigger() {
        EmitSoundOn("Hero_Nevermore.RequiemOfSouls", this.parent);

        let particleId = ParticleManager.CreateParticle(
            "particles/econ/events/ti9/blink_dagger_ti9_start_lvl2.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined
        );
        ParticleManager.SetParticleControl(particleId, 0, this.parent.GetAbsOrigin());
        ParticleManager.ReleaseParticleIndex(particleId);

        particleId = ParticleManager.CreateParticle(
            "particles/econ/events/ti9/phase_boots_ti9_body_magic.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined
        );
        ParticleManager.SetParticleControl(particleId, 0, this.parent.GetAbsOrigin());
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}

@registerModifier({ customNameForI18n: "modifier_nevermore_counter_banish" })
class ModifierNevermoreCounterBanish extends ModifierBanish {
    OnDestroy() {
        super.OnDestroy();

        if (IsServer()) {
            const origin = this.caster.GetAbsOrigin();
            const cursor = CustomAbilitiesLegacy.GetCursorPosition(this.ability);
            const point = clampPosition(origin, cursor, {
                maxRange: this.ability.GetCastRange(Vector(0, 0, 0), undefined)
            });

            ModifierNevermoreCounterThinker.createThinker(this.parent, this.ability, point, {
                delayTime: this.Value("delay_time"),
                radius: this.Value("radius")
            });
        }
    }

    CheckState() {
        return {
            ...super.CheckState(),
            [ModifierState.COMMAND_RESTRICTED]: true
        };
    }
}

@registerModifier({ customNameForI18n: "modifier_nevermore_counter_thinker" })
class ModifierNevermoreCounterThinker extends ModifierThinker {
    particleId?: ParticleID;

    OnCreated(params: ModifierThinkerParams) {
        super.OnCreated(params);
        if (IsServer()) {
            this.PlayEffects();
        }
    }

    OnDestroy() {
        super.OnDestroy();
        if (IsServer() && this.particleId) {
            DEFX(this.particleId, false);
        }
    }

    OnReady() {
        if (IsServer()) {
            FindClearSpaceForUnit(this.caster, this.parent.GetAbsOrigin(), true);

            const enemies = CustomEntitiesLegacy.FindUnitsInRadius(
                this.caster,
                this.parent.GetAbsOrigin(),
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
                //  enemy: AddNewModifier(this.caster, this.ability, "modifier_nevermore_counter_fear", {
                //      duration = this.Value("fear_duration")
                //  });
            }

            // this.ability.PlayEffectsFear();
            this.caster.StartGesture(GameActivity.DOTA_RAZE_2);
        }
    }

    PlayEffects() {
        const origin = this.parent.GetAbsOrigin();
        this.particleId = EFX(
            "particles/units/heroes/hero_shadow_demon/shadow_demon_soul_catcher_v2_ground01.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined,
            {
                cp0: origin,
                cp1: origin,
                cp2: origin,
                cp3: Vector(this.radius, 0, 0)
            }
        );
    }
}

// modifier_nevermore_counter_fear = class({})

// if(IsClient() ) { require("wrappers/modifiers") }
// Modifiers.Fear(modifier_nevermore_counter_fear)
