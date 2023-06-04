import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierBanish } from "../../../modifiers/modifier_banish";
import { Translate } from "../../../modifiers/modifier_casting";
import { DisplacementParams, ModifierDisplacement, OnCollisionEvent } from "../../../modifiers/modifier_displacement";
import {
    attackWithBaseDamage,
    createRadiusMarker,
    direction2D,
    hideHealthBar,
    isObstacle,
    randomInArray,
    unhideHealthBar
} from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";
import { ModifierJuggernautStacks } from "./juggernaut_basic_attack";
import { ModifierJuggernautSpin } from "./juggernaut_second_attack";

@registerAbility("juggernaut_ultimate")
class JuggernautUltimate extends CustomAbility {
    GetCastAnimationCustom() {
        return GameActivity.DOTA_GENERIC_CHANNEL_1;
    }

    GetPlaybackRateOverride() {
        return 2.0;
    }

    GetCastingCrawl() {
        return 0;
    }

    GetAnimationTranslate() {
        return Translate.sharp_blade;
    }

    OnAbilityPhaseStart() {
        if (super.OnAbilityPhaseStart()) {
            this.PlayEffectsOnPhase();
            return true;
        }
        return false;
    }

    OnAbilityPhaseInterrupted() {
        super.OnAbilityPhaseInterrupted();
        StopGlobalSound("juggernaut_jug_rare_17");
        StopGlobalSound("Hero_Juggernaut.PreAttack");
        StopGlobalSound("Hero_Lycan.SummonWolves");
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const point = CustomAbilitiesLegacy.GetCursorPosition(this);
        const distance = this.GetCastRange(Vector(0, 0, 0), undefined);
        const direction = direction2D(origin, point);

        ModifierJuggernautUltimateDisplacement.apply(this.caster, this.caster, this, {
            x: direction.x,
            y: direction.y,
            distance: distance,
            speed: distance / 0.5,
            peak: 50,
            teamFilter: UnitTargetTeam.ENEMY,
            flagFilter: UnitTargetFlags.NO_INVIS
        });

        EmitSoundOn("Hero_PhantomAssassin.Strike.End", this.caster);
    }

    PlayEffectsOnPhase() {
        EmitGlobalSound("juggernaut_jug_rare_17");
        EmitGlobalSound("Hero_Lycan.SummonWolves");
        EmitGlobalSound("Hero_Juggernaut.PreAttack");

        ParticleManager.ReleaseParticleIndex(
            ParticleManager.CreateParticle(
                "particles/juggernaut/juggernaut_ultimate_cast.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.caster
            )
        );
        const particleId = ParticleManager.CreateParticle(
            "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_omni_end.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            this.caster
        );
        ParticleManager.SetParticleControl(particleId, 2, this.caster.GetAbsOrigin());
        ParticleManager.SetParticleControl(particleId, 3, this.caster.GetAbsOrigin());
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}
// if IsClient() then require("wrappers/abilities") end
// Abilities.Castpoint(juggernaut_ultimate)

@registerModifier({ customNameForI18n: "modifier_juggernaut_ultimate_displacement" })
class ModifierJuggernautUltimateDisplacement extends ModifierDisplacement<JuggernautUltimate> {
    slashingDuration!: number;
    aspdPerStack!: number;
    stacks!: number;

    OnCreated(params: DisplacementParams) {
        super.OnCreated(params);

        this.slashingDuration = this.ability.GetSpecialValueFor("duration");
        this.aspdPerStack = this.ability.GetSpecialValueFor("aspd_per_stack");

        if (IsServer()) {
            const modifier = ModifierJuggernautStacks.findOne(this.parent);
            this.stacks = modifier?.GetStackCount() ?? 0;
            modifier?.Destroy();
        }
    }

    OnCollide(params: OnCollisionEvent) {
        if (IsServer()) {
            if (params.collision == "unit") {
                const enemy = params.units.find(unit => !isObstacle(unit));

                if (enemy) {
                    EmitSoundOn("Hero_PhantomAssassin.Attack", enemy);

                    ModifierJuggernautUltimateSlashing.apply(this.parent, this.parent, this.ability, {
                        duration: this.slashingDuration,
                        aspdBuff: this.aspdPerStack * this.stacks
                    });
                    this.Destroy();
                }
            }
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.OVERRIDE_ANIMATION, ModifierFunction.OVERRIDE_ANIMATION_RATE];
    }

    GetOverrideAnimation() {
        return GameActivity.DOTA_ATTACK_EVENT;
    }

    GetOverrideAnimationRate() {
        return 1.0;
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

    GetEffectName() {
        return "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_trigger.vpcf";
    }
}
// if IsClient() then require("wrappers/modifiers") end
// Modifiers.Displacement(modifier_juggernaut_ultimate_displacement)
// Modifiers.Animation(modifier_juggernaut_ultimate_displacement)

@registerModifier({ customNameForI18n: "modifier_juggernaut_ultimate_slashing" })
class ModifierJuggernautUltimateSlashing extends CustomModifier<JuggernautUltimate> {
    radius!: number;
    attackSpeed!: number;
    currentPosition!: Vector;
    previousPosition!: Vector;
    currentTarget?: CDOTA_BaseNPC;

    IsHidden() {
        return false;
    }

    IsDebuff() {
        return false;
    }

    IsPurgable() {
        return false;
    }

    OnCreated(params: { aspdBuff: number }) {
        this.radius = this.ability.GetSpecialValueFor("find_radius");
        if (IsServer()) {
            this.currentPosition = this.parent.GetAbsOrigin();
            this.previousPosition = this.currentPosition;
            this.SetStackCount(params.aspdBuff);
            const attacksPerSecond = this.parent.GetAttacksPerSecond();
            this.attackSpeed = math.abs(1 / attacksPerSecond);
            this.OnIntervalThink();
            this.StartIntervalThink(this.attackSpeed);
            hideHealthBar(this.parent, this.GetDuration());
        }
    }

    OnDestroy() {
        if (IsServer()) {
            unhideHealthBar(this.parent);
            ModifierJuggernautSpin.apply(this.parent, this.parent, undefined, { duration: 0.3 });
        }
    }

    FindTargets() {
        const findOrigin = this.currentTarget?.GetAbsOrigin() ?? this.parent.GetAbsOrigin();
        createRadiusMarker(this.parent, findOrigin, this.radius, "public", 0.1);

        return CustomEntitiesLegacy.FindUnitsInRadius(
            this.parent,
            findOrigin,
            this.radius,
            UnitTargetTeam.ENEMY,
            UnitTargetType.HERO + UnitTargetType.BASIC,
            UnitTargetFlags.MAGIC_IMMUNE_ENEMIES + UnitTargetFlags.NO_INVIS,
            FindOrder.ANY
        ).filter(enemy => !isObstacle(enemy));
    }

    OnIntervalThink() {
        const enemies = this.FindTargets();
        if (enemies.length > 0) {
            this.currentTarget = randomInArray(enemies);
            this.ability.SingleAttack({
                target: this.currentTarget,
                attackType: "basic",
                triggerCounters: false,
                effect: (target: CDOTA_BaseNPC) => {
                    attackWithBaseDamage({
                        source: this.parent,
                        target: target,
                        ability: this.ability
                    });
                    const targetOrigin = target.GetAbsOrigin();
                    FindClearSpaceForUnit(this.parent, targetOrigin.__add(RandomVector(128)), false);
                    const direction = targetOrigin.__sub(this.parent.GetAbsOrigin());
                    direction.z = this.parent.GetForwardVector().z;
                    this.parent.SetForwardVector(direction.Normalized());
                    this.currentPosition = this.parent.GetAbsOrigin();
                    this.PlayEffectsTarget(target);
                    this.PlayEffectsTrail(this.previousPosition, this.currentPosition);
                    ScreenShake(targetOrigin, 100, 300, 0.45, 1000, 0, true);
                    this.previousPosition = this.currentPosition;
                }
            });
        } else {
            this.currentTarget = undefined;

            const effectOrigin = this.parent.GetAbsOrigin().__add(RandomVector(RandomInt(this.radius / 2, this.radius)));
            EmitSoundOn("Hero_Juggernaut.ArcanaHaste.Anim", this.parent);
            EFX("particles/juggernaut/juggernaut_ultimate_glitch.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
                cp0: effectOrigin,
                cp1: effectOrigin,
                release: true
            });
            ModifierJuggernautBanish.apply(this.parent, this.parent, undefined, { duration: this.attackSpeed });
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.ATTACKSPEED_BONUS_CONSTANT, ModifierFunction.OVERRIDE_ANIMATION, ModifierFunction.OVERRIDE_ANIMATION_RATE];
    }

    GetModifierAttackSpeedBonus_Constant() {
        return -50 + this.GetStackCount();
    }

    GetOverrideAnimation() {
        return GameActivity.DOTA_OVERRIDE_ABILITY_4;
    }

    GetOverrideAnimationRate() {
        return 1.5;
    }

    CheckState() {
        return {
            [ModifierState.COMMAND_RESTRICTED]: true,
            [ModifierState.NO_HEALTH_BAR]: true,
            [ModifierState.INVULNERABLE]: true,
            [ModifierState.OUT_OF_GAME]: true,
            [ModifierState.NO_UNIT_COLLISION]: true
        };
    }

    PlayEffectsTarget(target: CDOTA_BaseNPC) {
        EFX("particles/juggernaut/juggernaut_basic_attack_impact.vpcf", ParticleAttachment.ABSORIGIN, target, {
            release: true
        });
        const particleId = ParticleManager.CreateParticle(
            "particles/units/heroes/hero_juggernaut/juggernaut_omni_slash_tgt.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            target
        );
        ParticleManager.ReleaseParticleIndex(particleId);
        EmitSoundOn("Hero_Juggernaut.OmniSlash.Damage", target);
    }

    PlayEffectsTrail(previousPosition: Vector, currentPosition: Vector) {
        const particleId = ParticleManager.CreateParticle(
            "particles/units/heroes/hero_juggernaut/juggernaut_omni_slash_trail.vpcf",
            ParticleAttachment.ABSORIGIN,
            this.parent
        );
        ParticleManager.SetParticleControl(particleId, 0, previousPosition);
        ParticleManager.SetParticleControl(particleId, 1, currentPosition);
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    GetEffectName() {
        return "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_trigger.vpcf";
    }
}

// if IsClient() then require("wrappers/modifiers") end
// Modifiers.Animation(modifier_juggernaut_ultimate_slashing)

@registerModifier({ customNameForI18n: "modifier_juggernaut_ultimate_banish" })
class ModifierJuggernautBanish extends ModifierBanish {
    CheckState() {
        return {
            ...super.CheckState(),
            [ModifierState.COMMAND_RESTRICTED]: true
        };
    }
}

// if IsClient() then require("wrappers/modifiers") end
// Modifiers.Banish(modifier_juggernaut_ultimate_banish)
