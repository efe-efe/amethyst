import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { ModifierCharges } from "../../../modifiers/modifier_charges";
import { attackWithBaseDamage, direction2D, getCursorPosition, giveManaAndEnergyPercent, isGem, isObstacle } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";

@registerAbility("sniper_basic_attack")
export class SniperBasicAttack extends CustomAbility {
    GetIntrinsicModifierName() {
        return ModifierSniperCharges.name;
    }

    GetCastPoint() {
        if (IsServer()) {
            return super.GetCastPoint() + this.caster.GetAttackAnimationPoint();
        }

        return 0;
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

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const point = getCursorPosition(this.caster);
        const manaGainPct = this.GetSpecialValueFor("mana_gain_pct");
        const projectileSpeed = this.GetSpecialValueFor("projectile_speed");
        const projectileDirection = direction2D(origin, point);

        ModifierSniperCharges.findOne(this.caster)?.ResetCooldown();

        this.ProjectileAttack({
            source: this.caster,
            attackType: "basic",
            effectName: "particles/sniper/sniper_basic_attack.vpcf",
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
                    }
                }
            },
            onFinish: projectile => {
                this.PlayEffectsOnFinish(projectile.getPosition());
            }
        });
        EmitSoundOn("Hero_Sniper.MKG_attack", this.caster);
    }

    PlayEffectsOnFinish(position: Vector) {
        EmitSoundOnLocationWithCaster(position, "Hero_Sniper.ProjectileImpact", this.caster);
        const particleId = ParticleManager.CreateParticle(
            "particles/sniper/sniper_basic_attack_explosion.vpcf",
            ParticleAttachment.ABSORIGIN,
            this.caster
        );
        ParticleManager.SetParticleControl(particleId, 3, position);
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}

@registerModifier("modifier_sniper_basic_attack_charges")
export class ModifierSniperCharges extends ModifierCharges {
    GetMaxCharges() {
        return this.Value("max_charges");
    }

    GetReplenishTime() {
        if (IsServer()) {
            const attacksPerSecond = this.parent.GetAttacksPerSecond();
            return 1 / (attacksPerSecond <= 0 ? 1 : attacksPerSecond);
        }
        return 0;
    }
}
