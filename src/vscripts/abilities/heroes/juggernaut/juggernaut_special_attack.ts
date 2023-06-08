import { registerAbility, registerModifier } from "../../../lib/dota_ts_adapter";
import { Translate } from "../../../modifiers/modifier_casting";
import { ModifierRecast } from "../../../modifiers/modifier_recast";
import { direction2D, giveManaAndEnergyPercent, isGem, isObstacle } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";
import { CustomModifier } from "../../framework/custom_modifier";

@registerAbility("juggernaut_special_attack")
class JuggernautSpecialAttack extends CustomAbility {
    GetAnimation() {
        return GameActivity.DOTA_TAUNT;
    }

    GetPlaybackRateOverride() {
        return 2.0;
    }

    GetCastingCrawl() {
        return 10;
    }

    GetAnimationTranslate() {
        return Translate.odachi;
    }

    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const point = CustomAbilitiesLegacy.GetCursorPosition(this);
        const damage = this.GetSpecialValueFor("ability_damage");
        const fading_slow_pct = this.GetSpecialValueFor("fading_slow_pct");
        const fading_slow_duration = this.GetSpecialValueFor("fading_slow_duration");
        const manaGainPct = this.GetSpecialValueFor("mana_gain_pct");
        const recastTime = this.GetSpecialValueFor("recast_time");
        const projectileSpeed = this.GetSpecialValueFor("projectile_speed");
        const projectileDirection = direction2D(origin, point);

        this.ProjectileAttack({
            source: this.caster,
            velocity: projectileDirection.__mul(projectileSpeed),
            spawnOrigin: origin.__add(Vector(projectileDirection.x * 45, projectileDirection.y * 45, 96)),
            effectName: "particles/juggernaut/juggernaut_special_attack.vpcf",
            groundOffset: 0,
            draw: true,
            unitTest: (unit, projectile) =>
                unit.GetUnitName() != "npc_dummy_unit" && !CustomEntitiesLegacy.Allies(projectile.getSource(), unit),
            onUnitHit: (unit, projectile) => {
                ApplyDamage({
                    victim: unit,
                    attacker: projectile.getSource(),
                    damage: damage,
                    damage_type: DamageTypes.MAGICAL
                });
                unit.AddNewModifier(this.caster, this, "modifier_generic_fading_slow", {
                    duration: fading_slow_duration,
                    max_slow_pct: fading_slow_pct
                });

                if (projectile.getSource() == this.caster) {
                    if (this.GetLevel() == 2) {
                        if (unit.IsAlive()) {
                            ModifierJuggernautSpecialAttackMark.apply(this.caster, unit, this, { duration: recastTime });
                            ModifierJuggernautSpecialAttackRecast.apply(this.caster, this.caster, undefined, {
                                duration: recastTime,
                                abilityLeft: JuggernautSpecialAttack.name,
                                abilityRight: JuggernautSpecialAttackRecast.name
                            });
                        }
                    }

                    if (!isObstacle(unit) && !isGem(unit)) {
                        giveManaAndEnergyPercent(projectile.getSource(), manaGainPct, true);
                    }
                }
            },
            onFinish: projectile => {
                this.PlayEffectsOnFinish(projectile.getPosition());
                // if this.caster.HasModifier("modifier_upgrade_juggernaut_refresh_dagger") then
                // 	const counter = 0
                // 	for k, v in pairs(_self.tHitLog) do
                // 		counter = counter + 1
                // 	}
                // 	if counter == 0 then
                // 		this.StartCooldown(this.GetCooldown(0) * 1.5)
                // 	else
                // 		this.EndCooldown()
                // 		this.StartCooldown(this.GetCooldown(0)/5)
                // 	}
                // }
            }
        });

        this.PlayEffectsOnCast();
        super.OnSpellStart();
    }

    PlayEffectsOnFinish(position: Vector) {
        EmitSoundOnLocationWithCaster(position, "Hero_Juggernaut.Attack", this.caster);
        const particleId = ParticleManager.CreateParticle(
            "particles/econ/items/arc_warden/arc_warden_ti9_immortal/arc_warden_ti9_wraith_impact_start.vpcf",
            ParticleAttachment.WORLDORIGIN,
            undefined
        );
        ParticleManager.SetParticleControl(particleId, 0, position);
        ParticleManager.ReleaseParticleIndex(particleId);
    }

    PlayEffectsOnCast() {
        EmitSoundOn("juggernaut_jug_spawn_02", this.caster);
        EmitSoundOn("Hero_Juggernaut.ArcanaTrigger", this.caster);
        EmitSoundOn("Hero_Juggernaut.BladeDance", this.caster);
    }

    // function juggernaut_special_attack:OnUpgrade()
    // 	CustomAbilitiesLegacy:LinkUpgrades(self, "juggernaut_special_attack_recast")
    // }
}

@registerAbility("juggernaut_special_attack_recast")
class JuggernautSpecialAttackRecast extends CustomAbility {
    OnSpellStart() {
        const origin = this.caster.GetAbsOrigin();
        const target = ModifierJuggernautSpecialAttackMark.findOne(this.caster)?.caster;
        const randomNumber = RandomInt(1, 9);

        if (target) {
            if (randomNumber > 1) {
                EmitSoundOn(`juggernaut_jug_ability_bladefury_0${randomNumber}`, this.caster);
            }

            FindClearSpaceForUnit(this.caster, target.GetAbsOrigin().__add(target.GetForwardVector().__mul(Vector(-80, -80, -80))), true);
            const particleId = ParticleManager.CreateParticle(
                "particles/juggernaut/special_attack_recast.vpcf",
                ParticleAttachment.WORLDORIGIN,
                undefined
            );
            ParticleManager.SetParticleControl(particleId, 0, origin);
            ParticleManager.SetParticleControl(particleId, 1, origin);
            ParticleManager.SetParticleControl(particleId, 3, origin);
            ParticleManager.ReleaseParticleIndex(particleId);
            this.caster.StartGestureWithPlaybackRate(GameActivity.DOTA_SPAWN, 2.0);
        }
    }

    // function juggernaut_special_attack_recast:SetTargetIndex(target_index)
    //     self.target_index = target_index
    // }

    // function juggernaut_special_attack_recast:OnUpgrade()
    // 	CustomAbilitiesLegacy:LinkUpgrades(self, "juggernaut_special_attack")
    // }
}

@registerModifier({ customNameForI18n: "modifier_juggernaut_special_attack_recast" })
class ModifierJuggernautSpecialAttackRecast extends ModifierRecast {}

@registerModifier({ customNameForI18n: "modifier_juggernaut_special_attack_mark" })
class ModifierJuggernautSpecialAttackMark extends CustomModifier {}