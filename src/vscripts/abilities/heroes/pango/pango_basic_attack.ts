import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierFadingSlow } from "../../../modifiers/modifier_fading_slow";
import { ModifierSilence } from "../../../modifiers/modifier_silence";
import {
    attackWithBaseDamage,
    clampPosition,
    direction2D,
    getCursorPosition,
    giveManaAndEnergyPercent,
    isGem,
    isObstacle,
    meeleEFX,
    replenishEFX
} from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";

@registerAbility("pango_basic_attack")
export class PangoBasicAttack extends CustomAbility {
    GetCastPoint() {
        if (IsServer()) {
            return this.caster.GetAttackAnimationPoint();
        }
        return 0;
    }

    GetCooldown(level: number) {
        if (IsServer()) {
            const attacksPerSecond = this.caster.GetAttacksPerSecond();
            const attackSpeed = 1 / attacksPerSecond;

            return super.GetCooldown(level) + attacksPerSecond;
        }
        return super.GetCooldown(level);
    }

    GetAnimation() {
        if (RandomInt(0, 3) == 0) {
            return GameActivity.DOTA_SPAWN;
        } else {
            return GameActivity.DOTA_CAST_ABILITY_4_END;
        }
    }

    GetPlaybackRateOverride() {
        return 1.2;
    }

    GetCastingCrawl() {
        return this.GetSpecialValueFor("cast_point_speed_pct");
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const cursor = getCursorPosition(this.caster);
        const castRange = this.GetCastRange(Vector(0, 0, 0), undefined);
        const point = clampPosition(origin, cursor, {
            maxRange: castRange,
            minRange: castRange
        });
        //TODO: @Refactor Handle the extra radius
        const meeleExtraRadius = 0; //CustomEntitiesLegacy:GetMeeleExtraRadius(caster)

        const radius = this.GetSpecialValueFor("radius") + meeleExtraRadius;
        const manaGainPct = this.GetSpecialValueFor("mana_gain_pct");
        const direction = direction2D(origin, point);
        const modifier = this.caster.FindModifierByName("modifier_juggernaut_ex_counter");

        meeleEFX(this.caster, direction, radius, modifier ? Vector(0, 255, 0) : undefined);

        this.MeeleAttack({
            direction,
            origin,
            radius,
            maxTargets: 1,
            attackType: "basic",
            effect: (target: CDOTA_BaseNPC) => {
                attackWithBaseDamage({ source: this.caster, target: target });

                this.TryProc(target);

                if (!isObstacle(target)) {
                    if (!isGem(target)) {
                        giveManaAndEnergyPercent(this.caster, manaGainPct, true);
                    }

                    ModifierPangoStacks.apply(this.caster, this.caster, this, {});
                }

                this.PlayEffectsOnImpact(target);
            },
            baseSound: "Hero_Juggernaut.PreAttack"
        });

        this.PlayEffectsOnMiss(point);
    }

    TryProc(target: CDOTA_BaseNPC) {
        const stacks = ModifierPangoStacks.findOne(this.caster)?.GetStackCount() ?? 0;
        if (stacks == this.GetSpecialValueFor("max_stacks")) {
            this.caster.RemoveModifierByName(ModifierPangoStacks.name);

            ModifierSilence.apply(target, this.caster, this, { duration: this.GetSpecialValueFor("fading_slow_duration") });

            ModifierFadingSlow.apply(target, this.caster, undefined, {
                duration: this.GetSpecialValueFor("fading_slow_duration"),
                maxSlowPct: this.GetSpecialValueFor("fading_slow_pct")
            });

            EmitSoundOn("Hero_Pangolier.LuckyShot.Proc", target);

            ApplyDamage({
                victim: target,
                attacker: this.caster,
                damage: this.GetSpecialValueFor("proc_damage"),
                damage_type: DamageTypes.PHYSICAL
            });
        }
    }

    PlayEffectsOnImpact(target: CDOTA_BaseNPC) {
        EFX("particles/juggernaut/juggernaut_basic_attack_impact.vpcf", ParticleAttachment.ABSORIGIN, target, {
            release: true
        });

        EmitSoundOn("Hero_Pangolier.Attack.Impact", target);
    }

    PlayEffectsOnMiss(position: Vector) {
        EmitSoundOnLocationWithCaster(position, "Hero_Pangolier.PreAttack", this.caster);
    }
}

@registerModifier()
export class ModifierPangoStacks extends CustomModifier {
    particleIds: ParticleID[] = [];

    IsHidden() {
        return false;
    }

    IsDebuff() {
        return false;
    }

    IsStunDebuff() {
        return false;
    }

    IsPurgable() {
        return true;
    }

    OnCreated() {
        if (IsServer()) {
            this.SetStackCount(1);
        }
    }

    OnRefresh() {
        const maxStacks = this.Value("max_stacks");

        if (IsServer() && this.GetStackCount() < maxStacks) {
            this.IncrementStackCount();

            if (this.GetStackCount() == maxStacks) {
                this.PlayEffectsCharged();
            }
        }
    }

    OnDestroy() {
        if (IsServer()) {
            this.StopEffects();
        }
    }

    PlayEffectsCharged() {
        replenishEFX(this.GetParent());

        for (let i = 0; i < 5; i++) {
            this.particleIds.push(
                ParticleManager.CreateParticle(
                    "particles/units/heroes/hero_invoker_kid/invoker_kid_forge_spirit_ambient_fire.vpcf",
                    ParticleAttachment.ABSORIGIN_FOLLOW,
                    this.caster
                )
            );
        }
    }

    StopEffects() {
        for (const particleId of this.particleIds) {
            ParticleManager.DestroyParticle(particleId, false);
            ParticleManager.ReleaseParticleIndex(particleId);
        }
    }

    GetTexture() {
        return "juggernaut_blade_dance";
    }
}
