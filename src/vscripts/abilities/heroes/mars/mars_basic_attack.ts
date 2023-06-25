import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { Translate } from "../../../modifiers/modifier_casting";
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

@registerAbility("mars_basic_attack")
class MarsBasicAttack extends CustomAbility {
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

            return super.GetCooldown(level) + attackSpeed;
        }

        return super.GetCooldown(level);
    }

    GetAnimation() {
        return GameActivity.DOTA_ATTACK;
    }
    GetPlaybackRateOverride() {
        return 2.0;
    }
    GetCastingCrawl() {
        return this.GetSpecialValueFor("cast_point_speed_pct");
    }
    GetAnimationTranslate() {
        return Translate.attack_close_range;
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

                if (!isObstacle(target)) {
                    if (!isGem(target)) {
                        giveManaAndEnergyPercent(this.caster, manaGainPct, true);
                    }

                    ModifierMarsStacks.apply(this.caster, this.caster, this, {});
                }

                EmitSoundOn("Hero_Juggernaut.Attack", target);
            },
            baseSound: "Hero_Juggernaut.PreAttack"
        });

        // ExecuteOrderFromTable({ OrderType = DOTA_UNIT_ORDER_STOP, UnitIndex = this.caster.entindex() })
        this.PlayEffectsOnFinish(direction);
        EmitSoundOn("Hero_Juggernaut.PreAttack", this.caster);
    }

    PlayEffectsOnFinish(direction: Vector) {
        const offset = 40;
        const origin = this.caster.GetAbsOrigin();
        const finalPosition = origin.__add(Vector(direction.x * offset, direction.y * offset, 0));

        const particleId = ParticleManager.CreateParticle(
            "particles/meele_swing_red/pa_arcana_attack_blinkb_red.vpcf",
            ParticleAttachment.POINT,
            this.caster
        );
        ParticleManager.SetParticleControl(particleId, 0, finalPosition);
        ParticleManager.SetParticleControlForward(particleId, 0, direction);
        ParticleManager.ReleaseParticleIndex(particleId);

        ParticleManager.ReleaseParticleIndex(
            ParticleManager.CreateParticle(
                "particles/econ/items/juggernaut/jugg_ti8_sword/juggernaut_ti8_sword_crit_golden.vpcf",
                ParticleAttachment.POINT,
                this.caster
            )
        );
    }
}

@registerAbility("mars_ex_basic_attack")
class MarsExBasicAttack extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_TAUNT;
    }

    GetPlaybackRateOverride() {
        return 1.0;
    }

    GetCastingCrawl() {
        return 10;
    }

    GetAnimationTranslate() {
        return Translate.ti10_taunt;
    }

    OnSpellStart() {
        const heal = this.GetSpecialValueFor("heal");
        const duration = this.GetSpecialValueFor("duration");
        this.caster.Heal(heal, this);
        ModifierMarsExBasicAttack.apply(this.caster, this.caster, this, { duration: duration });

        EmitSoundOn("DOTA_Item.Cheese.Activate", this.caster);
        EmitSoundOn("DOTA_Item.FaerieSpark.Activate", this.caster);
        EmitSoundOn("mars_mars_attack_20", this.caster);

        EFX(
            "particles/econ/taunts/bane/taunt_purple/bane_taunt_purple_food_end_left.vpcf",
            ParticleAttachment.ABSORIGIN_FOLLOW,
            this.caster,
            { release: true }
        );
    }
}

@registerModifier({ customNameForI18n: "modifier_mars_basic_attack_stacks" })
export class ModifierMarsStacks extends CustomModifier {
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
        const maxStacks = this.ability.GetSpecialValueFor("max_stacks");

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
        replenishEFX(this.parent);

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
}

@registerModifier({ customNameForI18n: "modifier_mars_ex_basic_attack" })
class ModifierMarsExBasicAttack extends CustomModifier {
    particleId?: ParticleID;
    OnCreated() {
        if (IsServer()) {
            this.particleId = EFX("particles/items5_fx/essence_ring.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.parent, {});
            this.StartIntervalThink(this.Value("think_interval"));
        }
    }

    OnIntervalThink() {
        this.parent.Heal(this.Value("heal_per_tick"), this.ability);
    }

    OnDestroy() {
        if (IsServer() && this.particleId) {
            DEFX(this.particleId, false);
        }
    }
}
