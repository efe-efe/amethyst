import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierCharges } from "../../../modifiers/modifier_charges";
import { ModifierFadingSlow } from "../../../modifiers/modifier_fading_slow";
import { precache, resource } from "../../../precache";
import { hasUpgrade } from "../../../upgrade_definitions";
import { areUnitsAllied, direction2D, getCursorPosition, giveManaAndEnergyPercent, isGem, isObstacle } from "../../../util";
import { defineAbility } from "../../framework/ability_definition";
import { CustomAbility } from "../../framework/custom_ability";
import { ModifierPhantomBleed, ModifierPhantomStacks, PhantomBasicAttack, PhantomExBasicAttack } from "./phantom_basic_attack";

const resources = precache({
    dagger: resource.fx("particles/phantom/phantom_special_attack.vpcf"),
    impact: resource.fx("particles/phantom/phantom_special_attack_explosion.vpcf")
});

@registerAbility("phantom_special_attack")
class PhantomSpecialAttack extends CustomAbility {
    GetIntrinsicModifierName() {
        return ModifierPhantomSpecialAttackCharges.name;
    }

    GetAnimation() {
        return GameActivity.DOTA_TELEPORT_END;
    }

    GetPlaybackRateOverride() {
        return 2.0;
    }

    GetCastingCrawl() {
        return 80;
    }

    GetFadeGestureOnCast() {
        return false;
    }

    GetCooldown(level: number) {
        if (IsServer() && hasUpgrade(this.caster, UpgradeId.phantomFastDaggers)) {
            const attacksPerSecond = this.caster.GetAttacksPerSecond();
            const attackSpeed = 1 / attacksPerSecond;
            return attackSpeed * 2;
        }
        return super.GetCooldown(level);
    }

    OnSpellStart() {
        const point = getCursorPosition(this.caster);
        const origin = this.caster.GetAbsOrigin();
        const straightDirection = direction2D(origin, point);
        const directions = [straightDirection];

        if (hasUpgrade(this.caster, UpgradeId.phantomExtraDaggers)) {
            directions.push(RotatePoint(Vector(0, 0, 0), straightDirection, -30).Normalized());
            directions.push(RotatePoint(Vector(0, 0, 0), straightDirection, 30).Normalized());
        }

        for (const direction of directions) {
            this.ThrowProjectile(origin, direction);
        }

        EmitSoundOn("Hero_PhantomAssassin.Dagger.Cast", this.caster);
    }

    ThrowProjectile(origin: Vector, direction: Vector) {
        const manaGainPct = this.GetSpecialValueFor("mana_gain_pct");
        const projectileSpeed = this.GetSpecialValueFor("projectile_speed");

        const phantomBasicAttack = PhantomBasicAttack.findOne(this.caster);
        const phantomExBasicAttack = PhantomExBasicAttack.findOne(this.caster);

        const bleedDuration = phantomExBasicAttack?.GetSpecialValueFor("bleed_duration") ?? 0;
        const fadingSlowPct = phantomExBasicAttack?.GetSpecialValueFor("fading_slow_pct") ?? 0;
        const fadingSlowDuration = phantomExBasicAttack?.GetSpecialValueFor("fading_slow_duration") ?? 0;

        const damageModifier = this.GetSpecialValueFor("damage_modifier");
        const damage = this.caster.GetAverageTrueAttackDamage(this.caster);
        const finalDamage = damage + damageModifier;

        this.ProjectileAttack({
            source: this.caster,
            attackType: "basic",
            effectName: resources.dagger.path,
            spawnOrigin: origin.__add(Vector(direction.x * 30, direction.y * 30, 96)),
            velocity: direction.__mul(projectileSpeed),
            groundOffset: 0,
            unitTest: (unit, projectile) => !areUnitsAllied(projectile.getSource(), unit),
            onUnitHit: (unit, projectile) => {
                ApplyDamage({
                    victim: unit,
                    attacker: this.caster,
                    damage: finalDamage,
                    damage_type: DamageTypes.PHYSICAL,
                    ability: this
                });

                if (projectile.getSource() == this.caster) {
                    if (!isObstacle(unit)) {
                        if (!isGem(unit)) {
                            giveManaAndEnergyPercent(projectile.getSource(), manaGainPct, true);
                        }

                        if (phantomBasicAttack) {
                            ModifierPhantomStacks.apply(this.caster, this.caster, phantomBasicAttack as PhantomBasicAttack, {});
                        }
                    }
                }

                if (!hasUpgrade(projectile.getSource(), UpgradeId.phantomFastDaggers)) {
                    ModifierFadingSlow.apply(unit, projectile.getSource(), undefined, {
                        duration: fadingSlowDuration,
                        maxSlowPct: fadingSlowPct
                    });
                }

                if (this.GetLevel() >= 2) {
                    ModifierPhantomBleed.apply(unit, projectile.getSource(), phantomExBasicAttack as PhantomExBasicAttack, {
                        duration: bleedDuration
                    });
                }
            },
            onFinish: projectile => {
                this.PlayEffectsOnFinish(projectile.getPosition());
            }
        });
    }

    // OnUpgrade(){
    // 	if(this:GetLevel() == 2){
    // 		this.caster.FindModifierByName("modifier_phantom_special_attack_charges"):AddCharge()
    // 	}
    // }

    PlayEffectsOnFinish(position: Vector) {
        EmitSoundOnLocationWithCaster(position, "Hero_PhantomAssassin.Dagger.Target", this.caster);
        const particleId = ParticleManager.CreateParticle(resources.impact.path, ParticleAttachment.WORLDORIGIN, undefined);
        ParticleManager.SetParticleControl(particleId, 3, position);
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}

@registerModifier("modifier_phantom_special_attack_charges")
class ModifierPhantomSpecialAttackCharges extends ModifierCharges {
    GetMaxCharges() {
        return hasUpgrade(this.caster, UpgradeId.phantomFastDaggers) ? 1 : this.Value("max_charges");
    }

    GetReplenishTime() {
        if (IsServer()) {
            return this.ability.GetCooldown(this.ability.GetLevel());
        }

        return 0;
    }
}

defineAbility(PhantomSpecialAttack, {
    category: "special"
});
