import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { Translate } from "../../../modifiers/modifier_casting";
import { ModifierCooldown } from "../../../modifiers/modifier_cooldown";
import {
    attackWithBaseDamage,
    createRadiusMarker,
    direction2D,
    giveManaAndEnergyPercent,
    giveManaPercent,
    isGem,
    isObstacle,
    replenishEFX
} from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";

@registerAbility("storm_basic_attack")
class StormBasicAttack extends CustomAbility {
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

    GetAnimationTranslate() {
        return Translate.overload;
    }

    GetIntrinsicModifierName() {
        return ModifierStormBasicAttack.name;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const point = CustomAbilitiesLegacy.GetCursorPosition(this);
        const manaGainPct = this.GetSpecialValueFor("mana_gain_pct");
        const projectileSpeed = this.GetSpecialValueFor("projectile_speed");
        const projectileDirection = direction2D(origin, point);

        const radius = this.GetSpecialValueFor("radius");
        const fadingSlowDuration = this.GetSpecialValueFor("fading_slow_duration");
        const fadingSlowPct = this.GetSpecialValueFor("fading_slow_pct");

        const isCharged = ModifierStormBasicAttack.findOne(this.caster)?.IsCooldownReady() ?? false;

        this.ProjectileAttack({
            source: this.caster,
            attackType: "basic",
            effectName: isCharged ? "particles/storm/storm_basic_attack_charged.vpcf" : "particles/storm/storm_basic_attack.vpcf",
            spawnOrigin: origin.__add(Vector(projectileDirection.x * 45, projectileDirection.y * 45, 96)),
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

                        if (this.caster.HasModifier("modifier_storm_ultimate")) {
                            // const extraManaPct = manaGainPct * (this.caster.FindModifierByName('modifier_storm_ultimate').GetManaMultiplier() - 1)
                            // giveManaPercent(this.caster, extraManaPct, true, true)
                        }
                    }
                }

                if (isCharged) {
                    const enemies = CustomEntitiesLegacy.FindUnitsInRadius(
                        projectile.getSource(),
                        projectile.getPosition(),
                        radius,
                        UnitTargetTeam.ENEMY,
                        UnitTargetType.HERO + UnitTargetType.BASIC,
                        UnitTargetFlags.NONE,
                        FindOrder.ANY
                    );

                    for (const enemy of enemies) {
                        enemy.AddNewModifier(projectile.getSource(), this, "modifier_generic_fading_slow", {
                            duration: fadingSlowDuration,
                            max_slow_pct: fadingSlowPct
                        });

                        ApplyDamage({
                            attacker: projectile.getSource(),
                            victim: enemy,
                            damage: this.GetSpecialValueFor("aoe_damage"),
                            damage_type: DamageTypes.PURE
                        });
                    }

                    const groundPosition = GetGroundPosition(projectile.getPosition(), projectile.getSource());

                    createRadiusMarker(projectile.getSource(), groundPosition, radius, "public", 0.1);
                    ScreenShake(groundPosition, 100, 300, 0.45, 1000, 0, true);

                    EFX(
                        "particles/units/heroes/hero_void_spirit/voidspirit_overload_discharge.vpcf",
                        ParticleAttachment.WORLDORIGIN,
                        projectile.getSource(),
                        {
                            cp0: projectile.getPosition(),
                            release: true
                        }
                    );
                }
            },
            onFinish: projectile => {
                this.PlayEffectsOnFinish(projectile.getPosition());
            }
        });

        this.PlayEffectsOnCast(isCharged);
    }

    PlayEffectsOnCast(charged: boolean) {
        EmitSoundOn("Hero_StormSpirit.Attack", this.caster);
        if (charged) {
            EmitSoundOn("Hero_StormSpirit.StaticRemnantExplode", this.caster);
        }
    }

    PlayEffectsOnFinish(position: Vector) {
        EmitSoundOnLocationWithCaster(position, "Hero_StormSpirit.ProjectileImpact", this.caster);

        const particleId = ParticleManager.CreateParticle(
            "particles/units/heroes/hero_stormspirit/stormspirit_base_attack_explosion.vpcf",
            ParticleAttachment.ABSORIGIN,
            this.caster
        );
        ParticleManager.SetParticleControl(particleId, 3, position);
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}

@registerModifier({ customNameForI18n: "modifier_storm_basic_attack_cooldown" })
class ModifierStormBasicAttack extends ModifierCooldown {
    particleId?: ParticleID;

    DeclareFunctions() {
        return [ModifierFunction.ON_ABILITY_FULLY_CAST, ModifierFunction.ON_ATTACK];
    }

    OnAbilityFullyCast(event: ModifierAbilityEvent) {
        if (IsServer()) {
            if (event.unit != this.parent) {
                return;
            }
            if (event.ability != this.ability) {
                this.Replenish();
            }
        }
    }

    OnBasicAttackStarted() {
        if (this.GetRemainingTime() > 0) {
            return;
        }

        this.StartCooldown();

        if (this.particleId) {
            DEFX(this.particleId, false);
        }
    }

    OnReplenish() {
        if (IsServer()) {
            this.particleId = EFX(
                "particles/units/heroes/hero_stormspirit/stormspirit_overload_ambient.vpcf",
                ParticleAttachment.POINT_FOLLOW,
                this.parent,
                {}
            );
            ParticleManager.SetParticleControlEnt(
                this.particleId,
                0,
                this.parent,
                ParticleAttachment.POINT_FOLLOW,
                "attach_attack1",
                this.parent.GetAbsOrigin(),
                true
            );
            EmitSoundOn("Hero_StormSpirit.Overload", this.parent);
            replenishEFX(this.parent);
        }
    }

    GetReplenishTime() {
        return this.Value("replenish_time");
    }
}

@registerAbility("storm_ex_basic_attack")
export class StormExBasicAttack extends CustomAbility {
    OnSpellStart() {
        this.caster.AddNewModifier(this.caster, this, "modifier_storm_ex_basic_attack", {});
        EmitSoundOn("Hero_StormSpirit.StaticRemnantPlant", this.caster);
    }
}

@registerModifier({ customNameForI18n: "modifier_storm_ex_basic_attack" })
export class ModifierStormExBasicAttack extends CustomModifier {
    particleId!: ParticleID;

    IsHidden() {
        return true;
    }

    OnCreated() {
        if (IsServer()) {
            this.SetStackCount(this.ability.GetLevel() >= 2 ? 21 : 11);
            this.particleId = EFX("particles/storm/storm_ex_basic_attack.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.parent, {});
        }
    }

    OnDestroy() {
        if (IsServer()) {
            DEFX(this.particleId, false);
        }
    }

    OnStackCountChanged() {
        if (this.GetStackCount() <= 2) {
            this.Destroy();
        }
    }

    OnRefresh() {
        if (IsServer()) {
            DEFX(this.particleId, false);
            this.particleId = EFX(
                "particles/storm/storm_ex_basic_attack_level_two.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.parent,
                {}
            );
            if (this.ability.GetLevel() >= 2) {
                if (this.GetStackCount() < 22) {
                    this.SetStackCount(22);
                } else if (this.GetStackCount() < 12) {
                    this.IncrementStackCount();
                }
            }
        }
    }

    GetLevel() {
        return this.GetStackCount() % 10;
    }
}
