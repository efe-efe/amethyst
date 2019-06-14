phantom_assassin_second_attack_lua = class({})
LinkLuaModifier( "modifier_phantom_assassin_second_attack_lua", "abilities/heroes/spectre/phantom_assassin_second_attack_lua/modifier_phantom_assassin_second_attack_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_pseudo_cast_point_lua", "abilities/generic/modifier_generic_pseudo_cast_point_lua", LUA_MODIFIER_MOTION_NONE )

function phantom_assassin_second_attack_lua:GetAOERadius()
	return self:GetSpecialValueFor( "hitbox" )
end

--------------------------------------------------------------------------------
-- Ability Start
function phantom_assassin_second_attack_lua:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
	self.point = self:GetCursorPosition()

	-- Animation and pseudo cast point
	self:Animate(self.point)
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point_lua", { duration = cast_point})
end


function phantom_assassin_second_attack_lua:OnEndPseudoCastPoint()
	local caster = self:GetCaster()
	local offset = 20

	-- load data
    local projectile_name = ""
	local projectile_start_radius = 50
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_speed = 2000

	-- Extra data
	local damage = self:GetSpecialValueFor("damage")
	local damage_per_stack = self:GetSpecialValueFor("damage_per_stack")
	local mana_gain = self:GetSpecialValueFor("mana_gain")

	self:SetActivated(true)
	
	-- Dinamyc data
	local origin = caster:GetOrigin()
	local direction_normal = (self.point - origin):Normalized()
	local initial_position = origin + Vector(direction_normal.x * offset, direction_normal.y * offset, 0)
	local projectile_direction = (Vector( self.point.x-origin.x, self.point.y-origin.y, 0 )):Normalized()

	local projectile = {
		EffectName = projectile_name,
		vSpawnOrigin = initial_position + Vector(0,0,80),
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
			
			-- Count targets
			local counter = 0
			for k, v in pairs(_self.rehit) do
				counter = counter + 1
			end

			if counter > 0 then return end

			local stacks = SafeGetModifierStacks("modifier_phantom_assassin_strike_stack_lua", caster, caster)
			local final_damage = damage + ( stacks * damage_per_stack )

			local damage_table = {
				victim = unit,
				attacker = _self.Source,
				damage = final_damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}

			ApplyDamage( damage_table )
			
			SafeDestroyModifier("modifier_phantom_assassin_strike_stack_lua", caster, caster)

			-- Give Mana
			local mana_gain_final = caster:GetMaxMana() * mana_gain
			caster:GiveMana(mana_gain_final)

			self:PlayEffects_a(unit, stacks)
			_self.Destroy()
		end,
		OnFinish = function(_self, pos)
			if next(_self.rehit) == nil then
				self:PlayEffects_b(pos)
			end

			SafeDestroyModifier("modifier_phantom_assassin_strike_stack_lua", caster, caster)
		end,
	}
	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
end

--------------------------------------------------------------------------------
-- Effects

-- On Projectile Hit enemy
function phantom_assassin_second_attack_lua:PlayEffects_a( hTarget, stacks )
	-- Create Sound
	local sound_cast_a = "Hero_PhantomAssassin.Arcana_Layer"
	local sound_cast_b = "Hero_PhantomAssassin.Attack"
	local sound_cast_c = "Hero_PhantomAssassin.Spatter"

	EmitSoundOn( sound_cast_a, hTarget )
	EmitSoundOn( sound_cast_b, hTarget )

	
	-- Create Particles
	local caster = self:GetCaster()
	local offset = 100
	local origin = caster:GetOrigin()
	local direction_normalized = (hTarget:GetOrigin() - origin):Normalized()
	local final_position = origin + Vector(direction_normalized.x * offset, direction_normalized.y * offset, 0)

	local particle_cast = ""

	if stacks == 3 then 
		particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_arcana_swoop.vpcf"
		EmitSoundOn( sound_cast_c, hTarget )
	else 
		particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_arcana_swoop_r.vpcf"
	end

	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT, caster )
    ParticleManager:SetParticleControl( effect_cast, 1, final_position )
    ParticleManager:SetParticleControlForward( effect_cast, 1, (origin - final_position):Normalized() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

-- On Projectile Miss
function phantom_assassin_second_attack_lua:PlayEffects_b(pos)
	local caster = self:GetCaster()

	-- Create Sound
	local sound_cast = "Hero_PhantomAssassin.PreAttack"
	EmitSoundOnLocationWithCaster( pos, sound_cast, caster )

	-- Create Particles
	local offset = 100
	local origin = caster:GetOrigin()
	local direction_normalized = (pos - origin):Normalized()
	local final_position = origin + Vector(direction_normalized.x * offset, direction_normalized.y * offset, 0)

	local particle_cast_a = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_arcana_swoop_a.vpcf"
	local particle_cast_b = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_arcana_swoop_b.vpcf"
	local particle_cast_c = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_arcana_swoop_c.vpcf"

	local effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_POINT, caster )
	local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_POINT, caster )
	local effect_cast_c = ParticleManager:CreateParticle( particle_cast_c, PATTACH_POINT, caster )

	ParticleManager:SetParticleControl( effect_cast_a, 1, final_position )
	ParticleManager:SetParticleControl( effect_cast_b, 1, final_position )
	ParticleManager:SetParticleControl( effect_cast_c, 1, final_position )

	ParticleManager:SetParticleControlForward( effect_cast_a, 1, (origin - final_position):Normalized() )
	ParticleManager:SetParticleControlForward( effect_cast_b, 1, (origin - final_position):Normalized() )
	ParticleManager:SetParticleControlForward( effect_cast_c, 1, (origin - final_position):Normalized() )

	ParticleManager:ReleaseParticleIndex( effect_cast_a )
	ParticleManager:ReleaseParticleIndex( effect_cast_b )
	ParticleManager:ReleaseParticleIndex( effect_cast_c )
end

function phantom_assassin_second_attack_lua:Animate(point)
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local angles = caster:GetAngles()

	local direction = (point - origin)
	local directionAsAngle = VectorToAngles(direction)
	caster:SetAngles(angles.x, directionAsAngle.y, angles.z)
	caster:SetForwardVector(direction:Normalized())
	StartAnimation(caster, {duration=1.0, activity=ACT_DOTA_SPAWN, rate=2.0})
end