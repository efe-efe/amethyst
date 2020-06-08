nevermore_second_attack = class({})
LinkLuaModifier("modifier_nevermore_second_attack", "abilities/heroes/hero_name/nevermore_second_attack/modifier_nevermore_second_attack", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------
--Passive Modifier
function nevermore_second_attack:GetIntrinsicModifierName()
	return "modifier_nevermore_second_attack"
end

function nevermore_second_attack:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()

	-- Projectile data
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()

	-- Probable data
    local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local radius = self:GetSpecialValueFor("radius")
	local damage = caster:GetAttackDamage() -- or self:GetSpecialValueFor("ability_damage")

	-- Projectile
	local projectile = {
		EffectName = "particles/mod_units/heroes/hero_nevermore/invoker_tornado_ti6.vpcf",
		vSpawnOrigin = origin + Vector(0, 0, 96),
		fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fUniqueRadius = self:GetSpecialValueFor("hitbox"),
		Source = caster,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_DESTROY,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 80,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit) 
		end,
		OnFinish = function(_self, pos)
			local enemies = caster:FindUnitsInRadius(
				caster:GetOrigin(), 
				radius, 
				DOTA_UNIT_TARGET_TEAM_ENEMY, 
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_ANY_ORDER
			)
	
			-- for each affected enemies
			for _,enemy in pairs(enemies) do
				-- Apply damage
				local damageTable = {
					victim = enemy,
					attacker = caster,
					damage = self.damage + stacks * self.damage_per_stack,
					damage_type = DAMAGE_TYPE_MAGICAL,
					ability = this,
				}
				ApplyDamage(damageTable)
			end
	
			--[[
			if #enemies > 0 then
				local mana_gain_final = caster:GetMaxMana() * self.mana_gain
				caster:GiveMana(mana_gain_final)   
	
				-- Refresh if posible
				local cooldownModifier = caster:AddNewModifier(
					caster,
					self:GetAbility(),
					"modifier_nevermore_second_attack_cooldown",
					{ duration = self.stack_duration }
				)
				local cooldownStacks = cooldownModifier:GetStackCount()
				
				if cooldownStacks < 3 then
					self:GetAbility():EndCooldown()
				else
					SafeDestroyModifier("modifier_nevermore_second_attack_cooldown", caster, caster)
				end
		
			else
				SafeDestroyModifier("modifier_nevermore_second_attack_cooldown", caster, caster)
			end
			]]
			self:PlayEffectsRaze(pos, radius)
			
			if _self.Source == caster then 
				caster:GiveManaPercent(mana_gain_pct, unit)
			end
		end,
	}

	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

function nevermore_second_attack:PlayEffectsOnCast()
	EmitSoundOn("CAST_SOUND", self:GetCaster())
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
--Abilities.BasicAttack(nevermore_second_attack)
Abilities.Initialize(
	nevermore_second_attack,
	{ activity = ACT_DOTA_RAZE_2, rate = 1.5 },
	{ movement_speed = 10, hide_indicator = 1, fixed_range = 1 }
)

--[[
nevermore_second_attack = class({})
LinkLuaModifier("modifier_nevermore_second_attack_thinker", "abilities/heroes/nevermore/nevermore_second_attack/modifier_nevermore_second_attack_thinker", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------
-- Ability Start
function nevermore_second_attack:OnCastPointEnd(point)
	local caster = self:GetCaster()
	local delay_time = self:GetSpecialValueFor("delay_time")
	local point = Clamp(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)

	CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_thinker_indicator", --modifierName
		{ 
			thinker = "modifier_nevermore_second_attack_thinker",
			show_all = 1,
			radius = self.radius,
			delay_time = delay_time,
		}, --paramTable
		point, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)
end
]]