nevermore_second_attack = class({})
LinkLuaModifier("modifier_nevermore_second_attack_recast", "abilities/heroes/nevermore/nevermore_second_attack/modifier_nevermore_second_attack_recast", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_second_attack_recasts_counter", "abilities/heroes/nevermore/nevermore_second_attack/modifier_nevermore_second_attack_recasts_counter", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_second_attack_debuff", "abilities/heroes/nevermore/nevermore_second_attack/modifier_nevermore_second_attack_debuff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_second_attack_block_recast", "abilities/heroes/nevermore/nevermore_second_attack/modifier_nevermore_second_attack_block_recast", LUA_MODIFIER_MOTION_NONE)

function nevermore_second_attack:GetCastAnimationCustom()		return ACT_DOTA_RAZE_2 end
function nevermore_second_attack:GetPlaybackRateOverride() 		return 1.5 end
function nevermore_second_attack:GetCastPointSpeed() 			return 10 end

function nevermore_second_attack:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()

	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()
    local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local radius = self:GetSpecialValueFor("radius")
	local damage = self:GetSpecialValueFor("ability_damage")
	local damage_per_stack = self:GetSpecialValueFor("damage_per_stack")
	local speed_per_stack = self:GetSpecialValueFor("speed_per_stack")
    local recast_duration = self:GetSpecialValueFor("recast_duration")


	local recasts_done = 0
	if caster:HasModifier("modifier_nevermore_second_attack_recasts_counter") then
		recasts_done = self:GetSpecialValueFor("recasts") - caster:FindModifierByName("modifier_nevermore_second_attack_recasts_counter"):GetStackCount()
	end
	
	local projectile = {
		EffectName = "particles/mod_units/heroes/hero_nevermore/invoker_tornado_ti6.vpcf",
		vSpawnOrigin = origin + Vector(0, 0, 96),
		fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fUniqueRadius = self:GetSpecialValueFor("hitbox"),
		Source = caster,
		vVelocity = projectile_direction * (projectile_speed + (speed_per_stack * recasts_done)),
		UnitBehavior = PROJECTILES_DESTROY,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 80,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnFinish = function(_self, pos)
			local enemies = _self.Source:FindUnitsInRadius(
				pos, 
				radius, 
				DOTA_UNIT_TARGET_TEAM_ENEMY, 
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_ANY_ORDER
			)

			local damage_table = {
				attacker = _self.Source,
				damage_type = DAMAGE_TYPE_PURE,
			}

			local should_recast = false
	
			for _,enemy in pairs(enemies) do
				if not enemy:IsObstacle() then
					should_recast = true
				end

				local debuff_stacks = 0
				if enemy:HasModifier("modifier_nevermore_second_attack_debuff") then
					debuff_stacks = enemy:FindModifierByName("modifier_nevermore_second_attack_debuff"):GetStackCount()
				end

				damage_table.victim = enemy
				damage_table.damage = damage + debuff_stacks * damage_per_stack

				ApplyDamage(damage_table)

				enemy:AddNewModifier(_self.Source, self, "modifier_nevermore_second_attack_debuff", { duration = recast_duration })
			end
	
			if _self.Source == caster then
				if should_recast then
					if not caster:HasModifier("modifier_nevermore_second_attack_block_recast") then
						local modifier = caster:FindModifierByName("modifier_nevermore_second_attack_recasts_counter")

						if modifier == nil then
							caster:AddNewModifier(caster, self, "modifier_nevermore_second_attack_recasts_counter", {})
						else 
							modifier:DecrementStackCount()
						end
						caster:GiveManaPercent(mana_gain_pct, unit)
					end
				else
					caster:RemoveModifierByName("modifier_nevermore_second_attack_recasts_counter")
				end
			end

			self:PlayEffectsRaze(pos, radius)
		end,
	}

	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

function nevermore_second_attack:PlayEffectsOnCast()
	EmitSoundOn("Hero_Nevermore.Attack", self:GetCaster())
end

function nevermore_second_attack:PlayEffectsRaze(pos, radius)
	local caster = self:GetCaster()
    EmitSoundOnLocationWithCaster(pos, "Hero_Nevermore.Shadowraze", caster)
	
    local particle_cast = "particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect_cast, 0, pos)
    ParticleManager:SetParticleControl(effect_cast, 1, Vector(radius, 1, 1))
    ParticleManager:ReleaseParticleIndex(effect_cast)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(nevermore_second_attack)