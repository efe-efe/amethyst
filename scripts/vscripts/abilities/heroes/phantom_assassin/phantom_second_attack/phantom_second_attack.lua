phantom_second_attack = class({})

--------------------------------------------------------------------------------
-- Ability Start
function phantom_second_attack:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()

	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=0.2, activity=ACT_DOTA_ATTACK_EVENT, rate=2.0})
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point", { duration = cast_point})
end


function phantom_second_attack:OnEndPseudoCastPoint( pos )
	local caster = self:GetCaster()
	local offset = 20

	-- load data
    local projectile_name = ""
	local projectile_start_radius = 50
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_speed = 2000

	-- Extra data
	local damage = self:GetAbilityDamage()
	local damage_per_stack = self:GetSpecialValueFor("damage_per_stack")
	local mana_gain = self:GetSpecialValueFor("mana_gain")/100

	self:SetActivated(true)
	
	-- Dinamyc data
	local origin = caster:GetOrigin()
	local direction_normal = (pos - origin):Normalized()
	local initial_position = origin + Vector(direction_normal.x * offset, direction_normal.y * offset, 0)
	local projectile_direction = (Vector( pos.x-origin.x, pos.y-origin.y, 0 )):Normalized()

	local projectile = {
		EffectName = projectile_name,
		vSpawnOrigin = initial_position + Vector(0,0,80),
		fDistance = projectile_distance,
		fStartRadius = projectile_start_radius,
		fEndRadius = projectile_end_radius,
		Source = caster,
		fExpireTime = 8.0,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_DESTROY,
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
			
			if stacks == 3 then
				local mobility = caster:FindAbilityByName("phantom_mobility")
				local new_cd = mobility:GetCooldownTimeRemaining()/2
				mobility:EndCooldown()
				mobility:StartCooldown(new_cd)
			end

			SendOverheadEventMessage(nil, OVERHEAD_ALERT_CRITICAL, unit, final_damage, nil )
			SafeDestroyModifier("modifier_phantom_assassin_strike_stack_lua", caster, caster)

			-- Give Mana
			local mana_gain_final = caster:GetMaxMana() * mana_gain
			caster:GiveMana(mana_gain_final)

			self:PlayEffects_a(unit, stacks)
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
function phantom_second_attack:PlayEffects_a( hTarget, stacks )
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
function phantom_second_attack:PlayEffects_b(pos)
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

