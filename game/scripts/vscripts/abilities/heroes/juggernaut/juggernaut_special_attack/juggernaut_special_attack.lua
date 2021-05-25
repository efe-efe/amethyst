
juggernaut_special_attack = class({})
juggernaut_special_attack_recast = class({})
LinkLuaModifier("modifier_juggernaut_special_attack_recast", "abilities/heroes/juggernaut/juggernaut_special_attack/modifier_juggernaut_special_attack_recast", LUA_MODIFIER_MOTION_NONE)

function juggernaut_special_attack:GetCastAnimationCustom()		return ACT_DOTA_TAUNT end
function juggernaut_special_attack:GetPlaybackRateOverride() 	return 2.0 end
function juggernaut_special_attack:GetCastPointSpeed() 			return 10 end
function juggernaut_special_attack:GetAnimationTranslate()		return "odachi" end

function juggernaut_special_attack:OnSpellStart()
	local caster = self:GetCaster()
	local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    local origin = caster:GetOrigin()
	local damage = self:GetSpecialValueFor("ability_damage")
	local fading_slow_pct = self:GetSpecialValueFor("fading_slow_pct")
	local fading_slow_duration = self:GetSpecialValueFor("fading_slow_duration")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local recast_time = self:GetSpecialValueFor("recast_time")
	
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = Direction2D(origin, point)

	CustomEntitiesLegacy:ProjectileAttack(caster, {
		tProjectile = {
			EffectName = "particles/juggernaut/juggernaut_special_attack.vpcf",
			vSpawnOrigin = origin + Vector(projectile_direction.x * 45, projectile_direction.y * 45, 96),
			fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
			fStartRadius = self:GetSpecialValueFor("hitbox"),
			Source = caster,
			vVelocity = projectile_direction * projectile_speed,
			UnitBehavior = PROJECTILES_DESTROY,
			TreeBehavior = PROJECTILES_NOTHING,
			WallBehavior = PROJECTILES_DESTROY,
			GroundBehavior = PROJECTILES_NOTHING,
			fGroundOffset = 0,
			UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntitiesLegacy:Allies(_self.Source, unit) end,
			OnUnitHit = function(_self, unit) 
				local damage_table = {
					victim = unit,
					attacker = caster,
					damage = damage,
					damage_type = DAMAGE_TYPE_MAGICAL,
				}
				ApplyDamage(damage_table)

				unit:AddNewModifier(_self.Source, self, "modifier_generic_fading_slow", { 
					duration = fading_slow_duration,
					max_slow_pct = fading_slow_pct 
				})

				if _self.Source == caster then
					if self:GetLevel() == 2 then
						if unit:IsAlive() then
							caster:FindAbilityByName("juggernaut_special_attack_recast"):SetTargetIndex(unit:GetEntityIndex())
							caster:AddNewModifier(caster, self, "modifier_juggernaut_special_attack_recast", { duration = recast_time })
						end
					end
					if CustomEntitiesLegacy:ProvidesMana(unit) then
						CustomEntitiesLegacy:GiveManaAndEnergyPercent(caster, mana_gain_pct, true)
					end
				end
			end,
			OnFinish = function(_self, pos)
				self:PlayEffectsOnFinish(pos)
				
				if caster:HasModifier("modifier_upgrade_juggernaut_refresh_dagger") then
					local counter = 0
					for k, v in pairs(_self.tHitLog) do 
						counter = counter + 1 
					end
		
					if counter == 0 then
						self:StartCooldown(self:GetCooldown(0) * 1.5)
					else 
						self:EndCooldown()
						self:StartCooldown(self:GetCooldown(0)/5)
					end
				end
			end,
		}
	})

	self:PlayEffectsOnCast()
end

function juggernaut_special_attack:PlayEffectsOnFinish(pos)
	EmitSoundOnLocationWithCaster(pos, "Hero_Juggernaut.Attack", self:GetCaster())
	
	local particle_cast = "particles/econ/items/arc_warden/arc_warden_ti9_immortal/arc_warden_ti9_wraith_impact_start.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, pos)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function juggernaut_special_attack:PlayEffectsOnCast()
	EmitSoundOn("juggernaut_jug_spawn_02", self:GetCaster())
	EmitSoundOn("Hero_Juggernaut.ArcanaTrigger", self:GetCaster())	
	EmitSoundOn("Hero_Juggernaut.BladeDance", self:GetCaster())
end

function juggernaut_special_attack:OnUpgrade()
	CustomAbilitiesLegacy:LinkUpgrades(self, "juggernaut_special_attack_recast")
end

function juggernaut_special_attack_recast:IsHidden()
    return true 
end

function juggernaut_special_attack_recast:OnSpellStart()
    local caster = self:GetCaster()
    local origin = caster:GetAbsOrigin()
    local target_entity = EntIndexToHScript(self.target_index)
 
	local random_number = RandomInt(1, 9)
	if random_number > 1 then
		EmitSoundOn("juggernaut_jug_ability_bladefury_0" .. random_number, caster)
	end

    FindClearSpaceForUnit(caster, target_entity:GetAbsOrigin() + target_entity:GetForwardVector() * - 80, true)
    
	local particle_cast = "particles/juggernaut/special_attack_recast.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect_cast, 0, origin)
    ParticleManager:SetParticleControl(effect_cast, 1, self:GetCaster():GetOrigin())
    ParticleManager:SetParticleControl(effect_cast, 3, self:GetCaster():GetOrigin())
    ParticleManager:ReleaseParticleIndex(effect_cast)

    caster:StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 2.0)

end

function juggernaut_special_attack_recast:SetTargetIndex(target_index)
    self.target_index = target_index
end

function juggernaut_special_attack_recast:OnUpgrade()
	CustomAbilitiesLegacy:LinkUpgrades(self, "juggernaut_special_attack")
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(juggernaut_special_attack)