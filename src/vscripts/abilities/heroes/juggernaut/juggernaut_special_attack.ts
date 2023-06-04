import { registerAbility } from "../../../lib/dota_ts_adapter";
import { Translate } from "../../../modifiers/modifier_casting";
import { ProjectileBehavior } from "../../../projectiles";
import { direction2D, giveManaAndEnergyPercent, isGem, isObstacle } from "../../../util";
import { CustomAbility } from "../../framework/custom_ability";

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
        const point = CustomAbilitiesLegacy.GetCursorPosition(this);
        const origin = this.caster.GetAbsOrigin();
        const damage = this.GetSpecialValueFor("ability_damage");
        const fading_slow_pct = this.GetSpecialValueFor("fading_slow_pct");
        const fading_slow_duration = this.GetSpecialValueFor("fading_slow_duration");
        const manaGainPct = this.GetSpecialValueFor("mana_gain_pct");
        const recastTime = this.GetSpecialValueFor("recast_time");
        const projectile_speed = this.GetSpecialValueFor("projectile_speed");
        const projectile_direction = direction2D(origin, point);

        this.ProjectileAttack({
            source: this.caster,
            velocity: projectile_direction.__mul(projectile_speed),
            spawnOrigin: origin.__add(Vector(projectile_direction.x * 45, projectile_direction.y * 45, 96)),
            effectName: "particles/juggernaut/juggernaut_special_attack.vpcf",
            treeBehavior: ProjectileBehavior.NOTHING,
            groundBehavior: ProjectileBehavior.NOTHING,
            groundOffset: 0,
            draw: true,
            unitTest: (unit, projectile) => unit.GetUnitName() != "npc_dummy_unit" && !CustomEntitiesLegacy.Allies(projectile.source, unit),
            onUnitHit: (unit, projectile) => {
                ApplyDamage({
                    victim: unit,
                    attacker: projectile.source,
                    damage: damage,
                    damage_type: DamageTypes.MAGICAL
                });
                unit.AddNewModifier(this.caster, this, "modifier_generic_fading_slow", {
                    duration: fading_slow_duration,
                    max_slow_pct: fading_slow_pct
                });

                if (projectile.source == this.caster) {
                    if (this.GetLevel() == 2) {
                        if (unit.IsAlive()) {
                            // this.caster.FindAbilityByName("juggernaut_special_attack_recast"):SetTargetIndex(unit:GetEntityIndex())
                            // this.caster.AddNewModifier(this.caster, self, "modifier_juggernaut_special_attack_recast", { duration = recastTime })
                        }
                    }

                    if (!isObstacle(unit) && !isGem(unit)) {
                        giveManaAndEnergyPercent(projectile.source, manaGainPct, true);
                    }
                }
            },
            onFinish: (position: Vector) => {
                this.PlayEffectsOnFinish(position);
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
}

// function juggernaut_special_attack:OnUpgrade()
// 	CustomAbilitiesLegacy:LinkUpgrades(self, "juggernaut_special_attack_recast")
// }

// function juggernaut_special_attack_recast:IsHidden()
//     return true
// }

// function juggernaut_special_attack_recast:OnSpellStart()
//     const this.caster = this.GetCaster()
//     const origin = this.caster.GetAbsOrigin()
//     const target_entity = EntIndexToHScript(self.target_index)

// 	const random_number = RandomInt(1, 9)
// 	if random_number > 1 then
// 		EmitSoundOn("juggernaut_jug_ability_bladefury_0" .. random_number, this.caster)
// 	}

//     FindClearSpaceForUnit(this.caster, target_entity:GetAbsOrigin() + target_entity:GetForwardVector() * - 80, true)

// 	const particle_cast = "particles/juggernaut/special_attack_recast.vpcf"
//     const effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
//     ParticleManager:SetParticleControl(effect_cast, 0, origin)
//     ParticleManager:SetParticleControl(effect_cast, 1, this.GetCaster():GetAbsOrigin())
//     ParticleManager:SetParticleControl(effect_cast, 3, this.GetCaster():GetAbsOrigin())
//     ParticleManager:ReleaseParticleIndex(effect_cast)

//     this.caster.StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 2.0)

// }

// juggernaut_special_attack_recast = class({})
// LinkLuaModifier("modifier_juggernaut_special_attack_recast", "abilities/heroes/juggernaut/juggernaut_special_attack/modifier_juggernaut_special_attack_recast", LUA_MODIFIER_MOTION_NONE)

// function juggernaut_special_attack_recast:SetTargetIndex(target_index)
//     self.target_index = target_index
// }

// function juggernaut_special_attack_recast:OnUpgrade()
// 	CustomAbilitiesLegacy:LinkUpgrades(self, "juggernaut_special_attack")
// }

// if IsClient() then require("wrappers/abilities") }
// Abilities.Castpoint(juggernaut_special_attack)

// modifier_juggernaut_special_attack_recast = class({})

// function modifier_juggernaut_special_attack_recast:OnCreated(params)
//     if IsServer() then
//         self.target_index = params.target_index
//     end
// end

// function modifier_juggernaut_special_attack_recast:GetTargetIndex()
//     return self.target_index
// end

// function modifier_juggernaut_special_attack_recast:GetRecastAbility()
//     if IsServer() then
//         return self:GetParent():FindAbilityByName("juggernaut_special_attack_recast")
//     end
// end

// function modifier_juggernaut_special_attack_recast:GetRecastCharges()
// 	return 1
// end

// function modifier_juggernaut_special_attack_recast:GetRecastKey()
// 	return "E"
// end

// if IsClient() then require("wrappers/modifiers") end
// Modifiers.Recast(modifier_juggernaut_special_attack_recast)
