import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierCombatEvents } from "../../../modifiers/modifier_combat_events";
import { ModifierCooldown } from "../../../modifiers/modifier_cooldown";
import { ModifierShield } from "../../../modifiers/modifier_shield";
import { ModifierThinker, ModifierThinkerParams } from "../../../modifiers/modifier_thinker";
import { attackWithBaseDamage, clampPosition, direction2D, giveManaAndEnergyPercent, isGem, isObstacle, replenishEFX } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";

class PuckBasicAttackCommon extends CustomAbility {
    GetCooldown(level: number) {
        if (IsServer()) {
            const attacksPerSecond = this.caster.GetAttacksPerSecond();
            const attackSpeed = 1 / attacksPerSecond;
            return super.GetCooldown(level) + attackSpeed;
        }

        return super.GetCooldown(level);
    }

    PlayEffectsOnCast(charged: boolean) {
        EmitSoundOn("Hero_Puck.Attack", this.caster);
        if (charged) {
            EmitSoundOn("Hero_Oracle.FortunesEnd.Attack", this.caster);
        }
    }
}

@registerAbility("puck_basic_attack")
export class PuckBasicAttack extends PuckBasicAttackCommon {
    GetCastPoint() {
        if (IsServer()) {
            return super.GetCastPoint() + this.caster.GetAttackAnimationPoint();
        }

        return super.GetCastPoint();
    }

    GetAnimation() {
        return GameActivity.DOTA_ATTACK;
    }

    GetPlaybackRateOverride() {
        return 1.0;
    }

    GetCastingCrawl() {
        return 10;
    }

    GetIntrinsicModifierName() {
        return ModifierPuckBasicAttack.name;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const point = CustomAbilitiesLegacy.GetCursorPosition(this);

        this.LaunchProjectile(origin, point);
    }

    LaunchProjectile(origin: Vector, point: Vector) {
        const manaGainPct = this.GetSpecialValueFor("mana_gain_pct");
        const projectileSpeed = this.GetSpecialValueFor("projectile_speed");
        const projectileDirection = direction2D(origin, point);

        const fairyDustDuration = this.GetSpecialValueFor("fairy_dust_duration");
        const fairyDustSlowPct = this.GetSpecialValueFor("fairy_dust_slow_pct");

        const isCharged = ModifierPuckBasicAttack.findOne(this.caster)?.IsCooldownReady() ?? false;

        this.ProjectileAttack({
            source: this.caster,
            attackType: "basic",
            effectName: isCharged ? "particles/puck/puck_base_attack_alternative.vpcf" : "particles/puck/puck_base_attack.vpcf",
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

                if (isCharged) {
                    ModifierPuckFairyDust.apply(unit, projectile.getSource(), this, {
                        duration: fairyDustDuration,
                        slowPct: fairyDustSlowPct
                    });
                }

                if (projectile.getSource() == this.caster && !isObstacle(unit)) {
                    if (!isGem(unit)) {
                        giveManaAndEnergyPercent(projectile.getSource(), manaGainPct, true);
                    }

                    if (this.GetLevel() >= 2) {
                        ModifierPuckBasicAttack.findOne(this.caster)?.Replenish();
                    }
                }
            },
            onFinish: projectile => {
                this.PlayEffectsOnFinish(projectile.getPosition(), isCharged);
            }
        });
    }

    PlayEffectsOnFinish(position: Vector, charged: boolean) {
        EmitSoundOnLocationWithCaster(position, "Hero_Puck.ProjectileImpact", this.caster);
        const path = charged
            ? "particles/puck/puck_base_attack_alternative_explosion.vpcf"
            : "particles/puck/puck_base_attack_explosion.vpcf";
        const particleId = ParticleManager.CreateParticle(path, ParticleAttachment.ABSORIGIN, this.caster);
        ParticleManager.SetParticleControl(particleId, 3, position);
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    // OnUpgrade(){
    // 	const related = this.caster.FindAbilityByName('puck_basic_attack_related')
    // 	if(this.GetLevel() > related:GetLevel()){
    // 		related:UpgradeAbility(true)
    // 	}
    // }
}

@registerAbility("puck_basic_attack_related")
export class PuckBasicAttackRelated extends PuckBasicAttackCommon {
    GetAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_2;
    }

    GetPlaybackRateOverride() {
        return 1.0;
    }

    GetCastingCrawl() {
        return 10;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const cursor = CustomAbilitiesLegacy.GetCursorPosition(this);
        const point = clampPosition(origin, cursor, { maxRange: this.GetCastRange(Vector(0, 0, 0), undefined) });
        const puckExBasicAttack = PuckExBasicAttack.findOne(this.caster)?.GetSpecialValueFor("delay_time") ?? 0;

        ModifierPuckExBasicAttackThinker.createThinker(this.caster, this, point, {
            radius: this.GetSpecialValueFor("radius"),
            status: ModifierPuckBasicAttack.findOne(this.caster)?.IsCooldownReady() ? "charged" : "notCharged",
            delayTime: puckExBasicAttack
        });

        EFX("particles/econ/items/invoker/invoker_ti7/invoker_ti7_alacrity_cast.vpcf", ParticleAttachment.CUSTOMORIGIN, this.caster, {
            cp0: {
                ent: this.caster,
                point: "attach_hitloc"
            },
            cp1: point + Vector(0, 0, 1000),
            cp2: point + Vector(0, 0, 1000),
            release: true
        });
        // 	this.PlayEffectsOnCast(charged == 1)
    }

    // OnUpgrade(){
    // 	const related = this.caster.FindAbilityByName('puck_basic_attack')
    // 	if(this.GetLevel() > related:GetLevel()){
    // 		related:UpgradeAbility(true)
    // 	}
    // }
}

@registerModifier({ customNameForI18n: "modifier_puck_basic_attack_cooldown" })
export class ModifierPuckBasicAttack extends ModifierCooldown {
    DeclareFunctions() {
        return [ModifierFunction.PREATTACK_BONUS_DAMAGE];
    }

    OnBasicAttackStarted() {
        if (this.GetRemainingTime() > 0) {
            return;
        }

        if (IsServer()) {
            ModifierPuckBasicAttackBuff.apply(this.parent, this.parent, this.ability, {});
        }

        this.StartCooldown();
    }

    GetModifierPreAttack_BonusDamage() {
        if (!this.IsCooldownReady()) {
            return 0;
        }

        return this.Value("charged_damage");
    }

    OnReplenish() {
        if (IsServer()) {
            replenishEFX(this.parent);
        }
    }

    GetReplenishTime() {
        return this.Value("replenish_time");
    }
}
// if(IsClient()){ require("wrappers/modifiers") }
// Modifiers.Cooldown(modifier_puck_basic_attack_cooldown)
// Modifiers.OnEvent(modifier_puck_basic_attack_cooldown)

@registerModifier({ customNameForI18n: "modifier_puck_basic_attack_buff" })
class ModifierPuckBasicAttackBuff extends ModifierCombatEvents {
    IsHidden() {
        return true;
    }

    OnBasicAttackEnded() {
        this.Destroy();
    }

    // GetPreAttackDamage() {
    //     return this.Value("charged_damage");
    // }
}
// Modifiers.OnEvent(modifier_puck_basic_attack_buff)
// Modifiers.PreAttackDamage(modifier_puck_basic_attack_buff)

@registerModifier({ customNameForI18n: "modifier_puck_fairy_dust" })
export class ModifierPuckFairyDust extends CustomModifier {
    particleId?: ParticleID;

    OnCreated(params: { slowPct: number }) {
        if (IsServer()) {
            this.SetStackCount(params.slowPct);
            this.particleId = ParticleManager.CreateParticle(
                "particles/puck/puck_mobility_trail.vpcf",
                ParticleAttachment.ABSORIGIN_FOLLOW,
                this.parent
            );
        }
    }

    OnDestroy() {
        if (IsServer() && this.particleId) {
            ParticleManager.DestroyParticle(this.particleId, false);
            ParticleManager.ReleaseParticleIndex(this.particleId);
        }
    }

    OnRefresh(params: { slowPct: number }) {
        if (IsServer()) {
            if (params.slowPct > this.GetStackCount()) {
                this.SetStackCount(params.slowPct);
            }
        }
    }

    DeclareFunctions() {
        return [ModifierFunction.MOVESPEED_BONUS_PERCENTAGE];
    }

    GetModifierMoveSpeedBonus_Percentage() {
        return -this.GetStackCount();
    }

    GetStatusEffectName() {
        return "particles/status_fx/status_effect_combo_breaker.vpcf";
    }

    GetTexture() {
        return "modifier_puck_fairy_dust";
    }

    // function modifier_puck_fairy_dust:GetStatusLabel() return "Fairy Dust" }
    // function modifier_puck_fairy_dust:GetStatusPriority() return 4 }
    // function modifier_puck_fairy_dust:GetStatusStyle() return "FairyDust" }
}
// if IsClient() then require("wrappers/modifiers") }
// Modifiers.Status(modifier_puck_fairy_dust)

@registerAbility("puck_ex_basic_attack")
class PuckExBasicAttack extends CustomAbility {
    OnSpellStart() {
        const duration = this.GetSpecialValueFor("duration");
        ModifierPuckExBasicAttack.apply(this.caster, this.caster, this, { duration: duration });
        EFX("particles/puck/puck_ex_base_attack.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.caster, {
            release: true
        });
        EmitSoundOn("puck_puck_laugh_01", this.caster);
        EmitSoundOn("Hero_Puck.EtherealJaunt", this.caster);
        EmitSoundOn("Hero_Puck.Phase_Shift", this.caster);
    }
}

@registerModifier({ customNameForI18n: "modifier_puck_ex_basic_attack" })
class ModifierPuckExBasicAttack extends CustomModifier {
    particleIds: ParticleID[] = [];

    OnCreated() {
        if (IsServer()) {
            this.parent.SwapAbilities(PuckBasicAttack.name, PuckBasicAttackRelated.name, false, true);
            this.particleIds.push(
                ParticleManager.CreateParticle(
                    "particles/econ/items/mirana/mirana_ti8_immortal_mount/mirana_ti8_immortal_leap_trail_embers.vpcf",
                    ParticleAttachment.ABSORIGIN_FOLLOW,
                    this.parent
                )
            );
            this.particleIds.push(
                ParticleManager.CreateParticle("particles/puck/puck_mobility_trail.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.parent)
            );
        }
    }

    OnDestroy() {
        StopSoundOn("Hero_Puck.Phase_Shift", this.parent);
        if (IsServer()) {
            this.parent.SwapAbilities(PuckBasicAttack.name, PuckBasicAttackRelated.name, true, false);

            for (const particleId of this.particleIds) {
                ParticleManager.DestroyParticle(particleId, false);
                ParticleManager.ReleaseParticleIndex(particleId);
            }
            ParticleManager.ReleaseParticleIndex(
                ParticleManager.CreateParticle(
                    "particles/econ/items/mirana/mirana_ti8_immortal_mount/mirana_ti8_immortal_leap_start_embers.vpcf",
                    ParticleAttachment.ABSORIGIN_FOLLOW,
                    this.parent
                )
            );
            this.ability.StartCooldown(this.ability.GetCooldown(0));
        }
    }
    GetStatusEffectName() {
        return "particles/status_fx/status_effect_ghost.vpcf";
    }
    // function modifier_puck_ex_basic_attack.GetStatusLabel() return "Fairy Form" }
    // function modifier_puck_ex_basic_attack.GetStatusPriority() return 4 }
    // function modifier_puck_ex_basic_attack.GetStatusStyle() return "FairyDust" }
}
// if(IsClient()){ require("wrappers/modifiers") }
// Modifiers.Status(modifier_puck_ex_basic_attack)

//@Refactor maybe I should use the PuckExBasicAttack as the ability instead of the PuckBasicAttackRelated
@registerModifier({ customNameForI18n: "modifier_puck_basic_attack_thinker" })
class ModifierPuckExBasicAttackThinker extends ModifierThinker {
    charged!: boolean;
    origin!: Vector;
    duration!: number;
    shieldPerHit!: number;
    healPerHit!: number;
    fairyDustDuration!: number;
    fairyDustSlowPct!: number;
    manaGainPct!: number;

    exBasicAttack?: PuckExBasicAttack;

    OnCreated(params: ModifierThinkerParams & { status: "charged" | "notCharged" }) {
        super.OnCreated(params);

        if (IsServer()) {
            this.origin = this.parent.GetAbsOrigin();
            this.manaGainPct = this.ability.GetSpecialValueFor("mana_gain_pct");
            this.exBasicAttack = PuckExBasicAttack.findOne(this.caster);

            if (!this.exBasicAttack) {
                print("[ERROR] On PuckBasicAttackRelated: Can't find PuckExBasicAttack to get the values!");
                this.Destroy();
                return;
            }

            this.duration = this.exBasicAttack.GetSpecialValueFor("duration");
            this.shieldPerHit = this.exBasicAttack.GetSpecialValueFor("shield_per_hit");
            this.healPerHit = this.exBasicAttack.GetSpecialValueFor("heal_per_hit");
            this.fairyDustDuration = this.exBasicAttack.GetSpecialValueFor("fairy_dust_duration");
            this.fairyDustSlowPct = this.exBasicAttack.GetSpecialValueFor("fairy_dust_slow_pct");
            this.charged = params.status == "charged";
        }
    }

    OnReady() {
        EmitSoundOn("Hero_Leshrac.Lightning_Storm", this.parent);
        const color = this.charged ? Vector(100, 0, 0) : Vector(0, 0, 0);
        let giveMana = false;

        if (this.charged) {
            EFX(
                "particles/econ/generic/generic_aoe_explosion_sphere_1/generic_aoe_explosion_sphere_1.vpcf",
                ParticleAttachment.WORLDORIGIN,
                undefined,
                {
                    cp0: this.origin,
                    cp1: Vector(200, 0, 0),
                    cp2: Vector(2.0, 1, 1),
                    cp3: Vector(255, 0, 229),
                    cp4: Vector(250, 0, 255),
                    release: true
                }
            );
        }

        EFX("particles/puck/puck_basic_attack_related.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
            cp0: this.origin,
            cp1: this.origin,
            cp6: color,
            release: true
        });

        this.ability.AoeAttack({
            attackType: "basic",
            origin: this.origin,
            radius: this.radius,
            effect: target => {
                this.caster.PerformAttack(target, true, true, true, true, false, false, true);
                ModifierPuckFairyDust.apply(this.caster, this.caster, this.ability, {
                    duration: this.fairyDustDuration,
                    slowPct: this.fairyDustSlowPct
                });

                if (!isObstacle(target)) {
                    giveMana = true;
                }
            }
        });

        if (giveMana) {
            if (this.ability.GetLevel() >= 2) {
                ModifierPuckBasicAttack.findOne(this.caster)?.Replenish();
            }

            if (this.exBasicAttack && this.exBasicAttack.GetLevel() >= 2) {
                this.caster.Heal(this.healPerHit, this.ability);
            }

            ModifierPuckExBasicAttackShield.apply(this.caster, this.caster, undefined, {
                duration: 6.0,
                damageBlock: this.shieldPerHit
            });

            giveManaAndEnergyPercent(this.caster, this.manaGainPct, true);
        }
        this.Destroy();
    }
}

@registerModifier({ customNameForI18n: "modifier_puck_ex_basic_attack_shield" })
class ModifierPuckExBasicAttackShield extends ModifierShield {
    // function modifier_puck_ex_basic_attack_shield:GetStatusLabel() return "Fairy Shield" }
    // function modifier_puck_ex_basic_attack_shield:GetStatusPriority() return 3 }
    // function modifier_puck_ex_basic_attack_shield:GetStatusStyle() return "Shield" }
    // function modifier_puck_ex_basic_attack_shield:GetStackeable() return true }
}
// if(IsClient()){ require("wrappers/modifiers") }
// Modifiers.Status(modifier_puck_ex_basic_attack_shield)
// Modifiers.Shield(modifier_puck_ex_basic_attack_shield)
