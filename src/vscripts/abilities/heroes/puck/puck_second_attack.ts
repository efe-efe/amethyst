import { registerAbility } from "../../../lib/dota_ts_adapter";
import { ModifierSilence } from "../../../modifiers/modifier_silence";
import { direction2D, giveManaAndEnergyPercent, isGem, isObstacle } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { ModifierPuckFairyDust } from "./puck_basic_attack";
import { PuckSpecialAttack } from "./puck_special_attack";

@registerAbility("puck_second_attack")
class PuckSecondAttack extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_CAST_ABILITY_1;
    }

    GetPlaybackRateOverride() {
        return 1.0;
    }

    GetCastingCrawl() {
        return 10;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const point = CustomAbilitiesLegacy.GetCursorPosition(this);
        const manaGainPct = this.GetSpecialValueFor("mana_gain_pct");
        const projectileSpeed = this.GetSpecialValueFor("projectile_speed");
        const projectileDirection = direction2D(origin, point);
        const damage = this.GetSpecialValueFor("ability_damage");
        const silenceDuration = this.GetSpecialValueFor("silence_duration");

        this.ProjectileAttack({
            source: this.caster,
            effectName: "particles/puck/puck_second_attack_projectile.vpcf",
            spawnOrigin: origin.__add(Vector(projectileDirection.x * 45, projectileDirection.y * 45, 96)),
            velocity: projectileDirection.__mul(projectileSpeed),
            groundOffset: 0,
            unitTest: (unit, projectile) =>
                unit.GetUnitName() != "npc_dummy_unit" && !CustomEntitiesLegacy.Allies(projectile.getSource(), unit),
            onUnitHit: (unit, projectile) => {
                ApplyDamage({
                    victim: unit,
                    attacker: projectile.getSource(),
                    damage: damage,
                    damage_type: DamageTypes.MAGICAL,
                    ability: this
                });

                if (ModifierPuckFairyDust.findOne(unit)) {
                    ModifierSilence.apply(unit, projectile.getSource(), this, { duration: silenceDuration });
                    unit.RemoveModifierByName(ModifierPuckFairyDust.name);

                    EmitSoundOn("Hero_Puck.EtherealJaunt", unit);
                    const particleId = ParticleManager.CreateParticle(
                        "particles/econ/items/mirana/mirana_ti8_immortal_mount/mirana_ti8_immortal_leap_start_embers.vpcf",
                        ParticleAttachment.ABSORIGIN_FOLLOW,
                        unit
                    );
                    ParticleManager.ReleaseParticleIndex(particleId);
                }

                if (projectile.getSource() == this.caster) {
                    if (!isObstacle(unit) && !isGem(unit)) {
                        giveManaAndEnergyPercent(projectile.getSource(), manaGainPct, true);

                        if (this.GetLevel() >= 2) {
                            PuckSpecialAttack.findOne(this.caster)?.EndCooldown();
                        }
                    }
                }
            },
            onFinish: projectile => {
                this.PlayEffectsOnFinish(projectile.getPosition());
            }
        });

        EmitSoundOn("Hero_Oracle.FortunesEnd.Target", this.caster);
    }

    PlayEffectsOnFinish(position: Vector) {
        const particleId = ParticleManager.CreateParticle(
            "particles/econ/items/puck/puck_merry_wanderer/puck_illusory_orb_explode_merry_wanderer.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined
        );
        ParticleManager.SetParticleControl(particleId, 0, position);
        ParticleManager.SetParticleControl(particleId, 3, position);
        ParticleManager.ReleaseParticleIndex(particleId);
    }
}
