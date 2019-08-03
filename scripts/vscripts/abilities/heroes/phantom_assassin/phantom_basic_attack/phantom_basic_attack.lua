phantom_basic_attack = class({})
LinkLuaModifier( "modifier_phantom_assassin_strike_stack_lua", "abilities/heroes/phantom_assassin/phantom_assassin_shared_modifiers/modifier_phantom_assassin_strike_stack_lua", LUA_MODIFIER_MOTION_NONE )

function phantom_basic_attack:GetAOERadius()
	return self:GetSpecialValueFor( "hitbox" )
end

--------------------------------------------------------------------------------
-- Ability Start
function phantom_basic_attack:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = caster:GetAttackAnimationPoint()
	StartAnimation(caster, {duration = 0.4, activity=ACT_DOTA_SPAWN, rate=1.8})
	
	caster:AddNewModifier( caster, self, "modifier_generic_pseudo_cast_point", { 
		duration = cast_point, 
		movement_speed = 90,
	})
end

function phantom_basic_attack:OnEndPseudoCastPoint( pos )
	local caster = self:GetCaster()
	local offset = 20

	-- Projectile data
    local projectile_name = ""
	local projectile_start_radius = 50
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_speed = 2000

	local attacks_per_second = caster:GetAttacksPerSecond()
	local attack_speed = ( 1 / attacks_per_second )

	-- Extra data
	local cooldown_reduction = self:GetSpecialValueFor("cooldown_reduction")

	-- Dinamyc data
	local origin = caster:GetOrigin()
	local direction_normalized = (pos - origin):Normalized()
	local final_position = origin + Vector(direction_normalized.x * offset, direction_normalized.y * offset, 0)
	local projectile_direction = (Vector( pos.x-origin.x, pos.y-origin.y, 0 )):Normalized()

	local projectile = {
		EffectName = projectile_name,
		vSpawnOrigin = final_position + Vector(0,0,80),
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
			-- perform the actual attack
			caster:PerformAttack(
				unit, -- handle hTarget 
				true, -- bool bUseCastAttackOrb, 
				true, -- bool bProcessProcs,
				true, -- bool bSkipCooldown
				false, -- bool bIgnoreInvis
				false, -- bool bUseProjectile
				false, -- bool bFakeAttack
				true -- bool bNeverMiss
			)

			if unit:IsRealHero() and _self.Source == caster then 
				-- Add modifier
				caster:AddNewModifier(
					caster, -- player source
					self, -- ability source
					"modifier_phantom_assassin_strike_stack_lua", -- modifier name
					{} -- kv
				)
			end

			-- Reduce the cd of the second attack by 1
			local second_attack = caster:FindAbilityByName("phantom_second_attack")
			local second_attack_cd = second_attack:GetCooldownTimeRemaining()
			local new_cd = second_attack_cd - cooldown_reduction

			if (new_cd) < 0 then 
				second_attack:EndCooldown()
			else
				second_attack:EndCooldown()
				second_attack:StartCooldown(new_cd)
			end

			self:PlayEffects_b(unit)
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
	self:StartCooldown(attack_speed)
end

--------------------------------------------------------------------------------
-- Misc
-- Add mana on attack modifier. Only first time upgraded
function phantom_basic_attack:OnUpgrade()
	if self:GetLevel()==1 then
		local caster = self:GetCaster()
		-- Gain mana
		caster:AddNewModifier(caster, self , "modifier_mana_on_attack", {})
	end
end

--------------------------------------------------------------------------------
-- Graphics & sounds

-- On Projectile Finish
function phantom_basic_attack:PlayEffects_a( pos )
	local caster = self:GetCaster()
	local offset = 40
	local origin = caster:GetOrigin()
	local direction_normalized = (pos - origin):Normalized()
	local final_position = origin + Vector(direction_normalized.x * offset, direction_normalized.y * offset, 0)

	-- Create Particles
	local particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_attack_blinkb.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, final_position )
	ParticleManager:SetParticleControlForward(effect_cast, 0, direction_normalized)	
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

-- On Projectile Hit enemy
function phantom_basic_attack:PlayEffects_b( hTarget )
	local sound_cast = "Hero_PhantomAssassin.Attack"
	EmitSoundOn( sound_cast, hTarget )
end

-- On Projectile miss
function phantom_basic_attack:PlayEffects_c( pos )
	local sound_cast = "Hero_PhantomAssassin.PreAttack"
	EmitSoundOnLocationWithCaster( pos, sound_cast, self:GetCaster() )
end

