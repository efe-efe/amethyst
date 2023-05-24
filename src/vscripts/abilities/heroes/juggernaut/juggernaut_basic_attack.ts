import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { Translate } from "../../../modifiers/modifier_casting";
import {
    attackWithBaseDamage,
    clampPosition,
    direction2D,
    giveManaAndEnergyPercent,
    isGem,
    isObstacle,
    meeleEFX,
    replenishEFX
} from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";

@registerAbility("juggernaut_basic_attack")
class JuggernautBasicAttack extends CustomAbility {
    GetCastPoint() {
        return this.caster.GetAttackAnimationPoint();
    }

    GetCooldown(level: number) {
        const attacksPerSecond = this.caster.GetAttacksPerSecond();
        const attackSpeed = 1 / attacksPerSecond;

        return super.GetCooldown(level) + attackSpeed;
    }

    GetAnimation() {
        return GameActivity.DOTA_ATTACK_EVENT;
    }

    GetPlaybackRateOverride() {
        return 1.2;
    }

    GetAnimationTranslate() {
        return Translate.odachi;
    }

    GetCastPointSpeed() {
        return this.GetSpecialValueFor("cast_point_speed_pct");
    }

    OnSpellStart() {
        const origin = this.caster.GetOrigin();
        //TODO: @Refactor Refactor the cursor
        const cursor = CustomAbilitiesLegacy.GetCursorPosition(this);

        const castRange = this.GetCastRange(Vector(0, 0, 0), undefined);
        const point = clampPosition(origin, cursor, {
            maxRange: castRange,
            minRange: castRange
        });
        //TODO: @Refactor Handle the extra radius
        const meeleExtraRadius = 0; //CustomEntitiesLegacy:GetMeeleExtraRadius(caster)

        const radius = this.GetSpecialValueFor("radius") + meeleExtraRadius;
        const cooldownReduction = this.GetSpecialValueFor("cooldown_reduction");
        const cooldownReductionCounter = this.GetSpecialValueFor("cooldown_reduction_counter");
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

                if (!isObstacle(target)) {
                    if (!isGem(target)) {
                        giveManaAndEnergyPercent(this.caster, manaGainPct, true);
                    }

                    ModifierJuggernautStacks.apply(this.caster, this.caster, this, {});

                    this.ReduceCooldown("juggernaut_second_attack", cooldownReduction);
                    this.ReduceCooldown("juggernaut_ex_second_attack", cooldownReduction);

                    if (this.GetLevel() >= 2) {
                        this.ReduceCooldown("juggernaut_counter", cooldownReductionCounter);
                        this.ReduceCooldown("juggernaut_ex_counter", cooldownReductionCounter);
                    }
                }

                this.PlayEffectsOnImpact(target);
            },
            baseSound: "Hero_Juggernaut.PreAttack"
        });
    }

    ReduceCooldown(abilityName: string, cooldownReduction: number) {
        const ability = this.caster.FindAbilityByName(abilityName);

        if (ability) {
            const abilityCooldown = ability.GetCooldownTimeRemaining();
            const newCooldown = abilityCooldown - cooldownReduction;

            if (newCooldown < 0) {
                ability.EndCooldown();
            } else {
                ability.EndCooldown();
                ability.StartCooldown(newCooldown);
            }
        }
    }

    PlayEffectsOnImpact(target: CDOTA_BaseNPC) {
        EFX("particles/juggernaut/juggernaut_basic_attack_impact.vpcf", ParticleAttachment.ABSORIGIN, target, {
            release: true
        });

        EmitSoundOn("Hero_Juggernaut.Attack", target);
    }
}

@registerModifier({ customNameForI18n: "modifier_juggernaut_basic_attack_stacks" })
class ModifierJuggernautStacks extends CustomModifier<JuggernautBasicAttack> {
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
