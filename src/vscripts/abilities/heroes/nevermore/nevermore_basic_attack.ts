import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import {
    attackWithBaseDamage,
    direction2D,
    getCursorPosition,
    giveManaAndEnergyPercent,
    isGem,
    isObstacle,
    replenishEFX
} from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";

@registerAbility("nevermore_basic_attack")
class NevermoreBasicAttack extends CustomAbility {
    GetCastPoint() {
        if (IsServer()) {
            return super.GetCastPoint() + this.caster.GetAttackAnimationPoint();
        }

        return super.GetCastPoint();
    }

    GetCooldown(level: number) {
        if (IsServer()) {
            const attacks_per_second = this.caster.GetAttacksPerSecond();
            const attack_speed = 1 / attacks_per_second;

            return super.GetCooldown(level) + attack_speed;
        }

        return super.GetCooldown(level);
    }

    GetAnimation() {
        return GameActivity.DOTA_ATTACK;
    }

    GetPlaybackRateOverride() {
        return 1.5;
    }

    GetCastingCrawl() {
        return 10;
    }

    GetIntrinsicModifierName() {
        return "modifier_nevermore_souls";
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const point = getCursorPosition(this.caster);
        const manaGainPct = this.GetSpecialValueFor("mana_gain_pct");
        const projectileSpeed = this.GetSpecialValueFor("projectile_speed");
        const projectileDirection = direction2D(origin, point);

        this.ProjectileAttack({
            source: this.caster,
            attackType: "basic",
            effectName: "particles/nevermore/nevermore_basic_attack.vpcf",
            spawnOrigin: origin.__add(Vector(0, 0, 96)),
            velocity: projectileDirection.__mul(projectileSpeed),
            groundOffset: 0,
            unitTest: (unit, projectile) =>
                unit.GetUnitName() != "npc_dummy_unit" && !CustomEntitiesLegacy.Allies(projectile.getSource(), unit),
            onUnitHit: (unit, projectile) => {
                attackWithBaseDamage({
                    source: projectile.getSource(),
                    target: unit,
                    ability: this
                });

                if (projectile.getSource() == this.caster) {
                    if (!isObstacle(unit) && !isGem(unit)) {
                        giveManaAndEnergyPercent(projectile.getSource(), manaGainPct, true);

                        ModifierNevermoreStacks.findOne(this.caster)?.IncrementStackCount();
                        this.PlayEffectsSoul(unit);
                    }
                }
            },
            onFinish: projectile => {
                this.PlayEffectsOnFinish(projectile.getPosition());
            }
        });

        this.PlayEffectsOnCast();
    }

    PlayEffectsOnCast() {
        EmitSoundOn("Hero_Nevermore.Attack", this.caster);
    }

    PlayEffectsOnFinish(position: Vector) {
        EmitSoundOnLocationWithCaster(position, "Hero_Nevermore.ProjectileImpact", this.caster);

        const particleId = ParticleManager.CreateParticle(
            "particles/units/heroes/hero_nevermore/nevermore_base_attack_impact.vpcf",
            ParticleAttachment.ABSORIGIN,
            this.caster
        );
        ParticleManager.SetParticleControl(particleId, 1, position);
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    PlayEffectsSoul(target: CDOTA_BaseNPC) {
        const info = {
            Target: this.caster,
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
}

@registerModifier({ customNameForI18n: "modifier_nevermore_souls" })
export class ModifierNevermoreStacks extends CustomModifier {
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
            this.SetStackCount(0);
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

        for (let i = 0; i < 3; i++) {
            this.particleIds.push(
                ParticleManager.CreateParticle(
                    "particles/nevermore/nevermore_basic_attack_aura.vpcf",
                    ParticleAttachment.ABSORIGIN_FOLLOW,
                    this.caster
                )
            );
        }

        this.particleIds.push(
            ParticleManager.CreateParticle(
                "particles/econ/items/lycan/ti9_immortal/lycan_ti9_immortal_howl_buff.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.caster
            )
        );
    }

    StopEffects() {
        for (const particleId of this.particleIds) {
            ParticleManager.DestroyParticle(particleId, false);
            ParticleManager.ReleaseParticleIndex(particleId);
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.PREATTACK_BONUS_DAMAGE];
    }

    GetModifierPreAttack_BonusDamage() {
        return this.Value("damage_per_stack") * this.GetStackCount();
    }

    GetTexture() {
        return "juggernaut_blade_dance";
    }
}
