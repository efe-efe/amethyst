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
	local point = self:GetCursorPosition()
	local offset = 20
	local damage = self:GetSpecialValueFor("damage")
	local damage_per_stack = self:GetSpecialValueFor("damage_per_stack")
	local mana_gain = self:GetSpecialValueFor("mana_gain")

	-- load data
    local projectile_name = ""
	local projectile_start_radius = 50
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_speed = 9999
	
	-- Animation and pseudo cast point
	self:Animate(point)
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point_lua", { duration = cast_point})

	Timers:CreateTimer(cast_point, function()
		-- Dinamyc data
        local origin = caster:GetOrigin()
		local direction_normal = (point - origin):Normalized()
		local initial_position = origin + Vector(direction_normal.x * offset, direction_normal.y * offset, 0)
		local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()

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

				self:PlayEffects_b(unit)
				_self.Destroy()
			end,
			OnFinish = function(_self, pos)
				SafeDestroyModifier("modifier_phantom_assassin_strike_stack_lua", caster, caster)

				self:PlayEffects_a(pos)
			end,
		}
		-- Cast projectile
		Projectiles:CreateProjectile(projectile)
		end
	)
end

--------------------------------------------------------------------------------
-- Effects

-- On Miss
function phantom_assassin_second_attack_lua:PlayEffects_a( pos )
	local caster = self:GetCaster()
	local offset = 40
	local origin = caster:GetOrigin()
	local direction_normalized = (pos - origin):Normalized()
	local final_position = origin + Vector(direction_normalized.x * offset, direction_normalized.y * offset, 0)

	-- Create Sound
	local sound_cast = "Hero_PhantomAssassin.PreAttack"
	EmitSoundOnLocationWithCaster( pos, sound_cast, caster )
	
	-- Create Particles
	local particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_arcana_swoop_r.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT, caster )
    ParticleManager:SetParticleControl( effect_cast, 1, pos )
    ParticleManager:SetParticleControlForward( effect_cast, 1, (self:GetCaster():GetOrigin()-pos):Normalized() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

-- On hit enemy
function phantom_assassin_second_attack_lua:PlayEffects_b( hTarget )
    local caster = self:GetCaster()
    local pos = hTarget:GetOrigin()

		-- Create Sound
	local sound_cast_a = "Hero_PhantomAssassin.Arcana_Layer"
	EmitSoundOn( sound_cast_a, hTarget )
	local sound_cast_b = "Hero_PhantomAssassin.Attack"
	EmitSoundOnLocationWithCaster( pos, sound_cast_b, caster )
	
	local particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_arcana_swoop_r.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT, hTarget )
    ParticleManager:SetParticleControl( effect_cast, 1, pos )
    ParticleManager:SetParticleControlForward( effect_cast, 1, (self:GetCaster():GetOrigin()-hTarget:GetOrigin()):Normalized() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
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