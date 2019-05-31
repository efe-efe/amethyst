phantom_assassin_basic_attack_lua = class({})
LinkLuaModifier( "modifier_phantom_assassin_strike_stack_lua", "abilities/heroes/phantom_assassin/phantom_assassin_shared_modifiers/modifier_phantom_assassin_strike_stack_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_pseudo_cast_point_lua", "abilities/generic/modifier_generic_pseudo_cast_point_lua", LUA_MODIFIER_MOTION_NONE )

function phantom_assassin_basic_attack_lua:GetAOERadius()
	return self:GetSpecialValueFor( "hitbox" )
end

--------------------------------------------------------------------------------
-- Ability Start
function phantom_assassin_basic_attack_lua:OnSpellStart()
	self:SetActivated(false)
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
	local point = self:GetCursorPosition()
	local attacks_per_second = caster:GetAttacksPerSecond()
	local attack_speed = ( 1 / attacks_per_second )
	local offset = 20

	-- Projectile data
    local projectile_name = ""
	local projectile_start_radius = 50
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_speed = 9999
	
	-- Animation and pseudo cast point
	self:Animate(point)
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point_lua", { duration = cast_point})

	Timers:CreateTimer(cast_point, function()
		self:StartCooldown(attack_speed)
		self:SetActivated(true)
		-- Dinamyc data
        local origin = caster:GetOrigin()
		local direction_normalized = (point - origin):Normalized()
		local final_position = origin + Vector(direction_normalized.x * offset, direction_normalized.y * offset, 0)
		local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()

		local projectile = {
			EffectName = projectile_name,
			vSpawnOrigin = final_position + Vector(0,0,80),
			fDistance = projectile_distance,
			fStartRadius = projectile_start_radius,
			fEndRadius = projectile_end_radius,
			Source = caster,
			fExpireTime = 8.0,
			vVelocity = projectile_direction * projectile_speed,
			UnitBehavior = PROJECTILES_NOTHING,
			bMultipleHits = false,
			bIgnoreSource = true,
			TreeBehavior = PROJECTILES_NOTHING,
			bCutTrees = true,
			bTreeFullCollision = false,
			WallBehavior = PROJECTILES_DESTROY,
			GroundBehavior = PROJECTILES_NOTHING,
			fGroundOffset = 0,
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
			UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and unit:GetTeamNumber() ~= _self.Source:GetTeamNumber() end,
			OnUnitHit = function(_self, unit) 
				-- perform the actual attack
				caster:PerformAttack(
					unit, -- handle hTarget 
					true, -- bool bUseCastAttackOrb, 
					true, -- bool bProcessProcs,
					true, -- bool bSkipCooldown
					false, -- bool bIgnoreInvis
					false, -- bool bUseProjectile
					false, -- bool bFakeAttack
					false -- bool bNeverMiss
				)

				-- Add modifier
				caster:AddNewModifier(
					caster, -- player source
					self, -- ability source
					"modifier_phantom_assassin_strike_stack_lua", -- modifier name
					{} -- kv
				)

				-- Reduce the cd of the second attack by 1
				local second_attack = caster:FindAbilityByName("phantom_assassin_second_attack_lua")
				local second_attack_cd = second_attack:GetCooldownTimeRemaining()
				local new_cd = second_attack_cd - 1.0

				if (new_cd) < 0 then 
					second_attack:EndCooldown()
				else
					second_attack:EndCooldown()
					second_attack:StartCooldown(new_cd)
				end

				self:PlayEffects_b(unit)
				_self.Destroy()
			end,
			OnFinish = function(_self, pos)
				if next(_self.rehit) == nil then
					self:PlayEffects_c(pos)
				end
				self:PlayEffects_a(pos)
			end,
		}
		-- Cast projectile
		Projectiles:CreateProjectile(projectile)
		end
	)
end

--------------------------------------------------------------------------------
-- Misc
-- Add mana on attack modifier. Only first time upgraded
function phantom_assassin_basic_attack_lua:OnUpgrade()
	if self:GetLevel()==1 then
		local caster = self:GetCaster()
		-- Gain mana
		caster:AddNewModifier(caster, self , "modifier_mana_on_attack", {})
	end
end

--------------------------------------------------------------------------------
-- Graphics & sounds

-- On Projectile Finish
function phantom_assassin_basic_attack_lua:PlayEffects_a( pos )
	local caster = self:GetCaster()
	local offset = 40
	local origin = caster:GetOrigin()
	local direction_normalized = (pos - origin):Normalized()
	local final_position = origin + Vector(direction_normalized.x * offset, direction_normalized.y * offset, 0)

	-- Create Particles
	local particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_attack_blinkb.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, final_position )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

-- On Projectile Hit enemy
function phantom_assassin_basic_attack_lua:PlayEffects_b( hTarget )
	local sound_cast = "Hero_PhantomAssassin.Attack"
	EmitSoundOn( sound_cast, hTarget )
end

-- On Projectile miss
function phantom_assassin_basic_attack_lua:PlayEffects_c( pos )
	local sound_cast = "Hero_PhantomAssassin.PreAttack"
	EmitSoundOnLocationWithCaster( pos, sound_cast, self:GetCaster() )
end

function phantom_assassin_basic_attack_lua:Animate(point)
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local angles = caster:GetAngles()

	local direction = (point - origin)
	local directionAsAngle = VectorToAngles(direction)
	caster:SetAngles(angles.x, directionAsAngle.y, angles.z)
	caster:SetForwardVector(direction:Normalized())
	StartAnimation(caster, {duration=1.0, activity=ACT_DOTA_SPAWN, rate=2.0})
end

