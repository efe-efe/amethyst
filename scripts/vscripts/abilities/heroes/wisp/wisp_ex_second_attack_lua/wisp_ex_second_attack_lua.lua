wisp_ex_second_attack_lua = class({})
LinkLuaModifier( "modifier_wisp_ex_second_attack_lua", "abilities/heroes/wisp/wisp_ex_second_attack_lua/modifier_wisp_ex_second_attack_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_wisp_ex_second_attack_ally_lua", "abilities/heroes/wisp/wisp_ex_second_attack_lua/modifier_wisp_ex_second_attack_ally_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_wisp_guardian_essence_lua", "abilities/heroes/wisp/wisp_shared_modifiers/modifier_wisp_guardian_essence_lua/modifier_wisp_guardian_essence_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_wisp_ex_second_attack_movement_lua", "abilities/heroes/wisp/wisp_ex_second_attack_lua/modifier_wisp_ex_second_attack_movement_lua", LUA_MODIFIER_MOTION_HORIZONTAL )

--------------------------------------------------------------------------------
-- Ability Start
function wisp_ex_second_attack_lua:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = self:GetCursorPosition()
	local ability = self

	-- load data
	local projectile_name = "particles/mod_units/heroes/hero_dark_willow/dark_willow_shadow_attack.vpcf"
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	
	local damage = self:GetSpecialValueFor("damage")
	local debuff_duration = self:GetSpecialValueFor("debuff_duration")
	
	local projectile = {
		EffectName = projectile_name,
		vSpawnOrigin = {unit=caster, attach="attach_attack1", offset=Vector(0,0,0)},
		fDistance = projectile_distance,
		fStartRadius = projectile_start_radius,
		fEndRadius = projectile_end_radius,
		Source = caster,
		fExpireTime = 8.0,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_NOTHING,
		bMultipleHits = true,
		bIgnoreSource = true,
		TreeBehavior = PROJECTILES_NOTHING,
		bCutTrees = true,
		bTreeFullCollision = false,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 80,
		nChangeMax = 1,
		bRecreateOnChange = true,
		bZCheck = false,
		bGroundLock = true,
		bProvidesVision = true,
		iVisionRadius = 200,
		iVisionTeamNumber = caster:GetTeam(),
		bFlyingVision = false,
		fVisionTickTime = .1,
		fVisionLingerDuration = 1,
		draw = false,
		fRehitDelay = 1.0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and unit ~= _self.Source end,		
		OnUnitHit = function(_self, unit) 
			-- Hit
			--------------------
			--If target is ally
			if unit:GetTeamNumber() == _self.Source:GetTeamNumber() then
				--Link and speed
				unit:AddNewModifier(
					_self.Source, -- player source
					ability, -- ability source
					"modifier_wisp_ex_second_attack_ally_lua", -- modifier name
					{ duration = debuff_duration }
				)
				--- Movement
				local vLocation = _self:GetPosition()
				local difference = vLocation - _self.Source:GetOrigin()
				local distance = difference:Length2D()
				local x = vLocation.x - _self.Source:GetOrigin().x
				local y = vLocation.y - _self.Source:GetOrigin().y
				_self.Source:AddNewModifier(
					_self.Source,
					ability,
					"modifier_wisp_ex_second_attack_movement_lua",
					{
						r = distance,
						x = x,
						y = y,
					}
				)

			-- If target is enemy
			else	
				local damage = {
					victim = unit,
					attacker = _self.Source,
					damage = damage,
					damage_type = DAMAGE_TYPE_MAGICAL,
				}

				ApplyDamage( damage )

				--Link and silence
				unit:AddNewModifier(
					_self.Source, -- player source
					ability, -- ability source
					"modifier_wisp_ex_second_attack_lua", -- modifier name
					{ duration = debuff_duration }
				)

				-- apply guardian essence
				unit:AddNewModifier(
					_self.Source, -- player source
					ability, -- ability source
					"modifier_wisp_guardian_essence_lua", -- modifier name
					{}
				)
			end
			-- Effects
			--------------------
			self:PlayEffects_b(_self:GetPosition())

			-- End
			--------------------
			_self.Destroy()
		end,
		OnFinish = function(_self, pos)
			self:PlayEffects_b(pos)
		end,
	}

	self:PlayEffects_a()

	-- Put CD on the alternate version of the ability
	local ex_version = caster:FindAbilityByName("wisp_second_attack_lua")
	ex_version:StartCooldown(self:GetCooldown(0))

	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
end

--------------------------------------------------------------------------------
-- Graphics & sounds
function wisp_ex_second_attack_lua:PlayEffects_a()
	-- Get Resources
	local sound_cast = "Hero_Wisp.TeleportOut"
	local particle_cast = "particles/econ/items/wisp/wisp_guardian_explosion_ti7.vpcf"

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster()  )

	-- Create Particles
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function wisp_ex_second_attack_lua:PlayEffects_b( pos )
	local caster = self:GetCaster()

	-- Create Sound
	local sound_cast = "Hero_Wisp.Spirits.Target"
	EmitSoundOnLocationWithCaster( pos, sound_cast, caster )

	-- Create Particles
	local particle_cast = "particles/mod_units/heroes/hero_dark_willow/dark_willow_shadow_attack_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

