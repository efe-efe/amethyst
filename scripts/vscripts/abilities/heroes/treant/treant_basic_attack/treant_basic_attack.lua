treant_basic_attack = class({})
LinkLuaModifier( "modifier_treant_natures_punishment", "abilities/heroes/treant/treant_shared_modifiers/modifier_treant_natures_punishment", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function treant_basic_attack:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = caster:GetAttackAnimationPoint()
	StartAnimation(caster, {duration = cast_point + 0.1, activity=ACT_DOTA_ATTACK, rate=1.8})
	
	caster:AddNewModifier( caster, self, "modifier_generic_pseudo_cast_point", { 
		duration = cast_point, 
		movement_speed = 90,
		placeholder = 0,
	})
end

function treant_basic_attack:OnEndPseudoCastPoint( point )
	local caster = self:GetCaster()

	-- Projectile data
    local projectile_name = "particles/mod_units/heroes/hero_necrolyte/necrolyte_base_attack_ka.vpcf"
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	local reduction_per_hit = self:GetSpecialValueFor("reduction_per_hit_pct")/100
	
	local attacks_per_second = caster:GetAttacksPerSecond()
	local attack_speed = ( 1 / attacks_per_second )

	local attack_damage = caster:GetAttackDamage()
	local mana_gain = self:GetSpecialValueFor("mana_gain")/100
	local heal = self:GetSpecialValueFor("heal")
	local debuff_duration = self:GetSpecialValueFor("debuff_duration")

	-- Dinamyc data
	local origin = caster:GetOrigin()
	local direction = (point - origin):Normalized()
	local final_position = origin + Vector(direction.x, direction.y, 0)
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
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" end,
		OnUnitHit = function(_self, unit)
			-- Count targets
			local counter = -1
			for k, v in pairs(_self.rehit) do
				counter = counter + 1
			end

			local final_damage = attack_damage * (1 - (counter * reduction_per_hit))
			local final_heal = heal * (1 - (counter * reduction_per_hit))

			-- ENEMIES
			if unit:GetTeamNumber() ~= _self.Source:GetTeamNumber() then
				local damage_table = {
					victim = unit,
					attacker = _self.Source,
					damage = final_damage,
					damage_type = DAMAGE_TYPE_PHYSICAL,
				}
				ApplyDamage( damage_table )

				if unit:IsRealHero() then
					unit:AddNewModifier(_self.Source, self, "modifier_treant_natures_punishment", { duration = debuff_duration })
				end
			end

			-- ALLIES
			if unit:GetTeamNumber() == _self.Source:GetTeamNumber() then
				unit:Heal(final_heal, _self.Source )
			end

			-- Give Mana
			if counter < 1 then
				local mana_gain_final = _self.Source:GetMaxMana() * mana_gain
				_self.Source:GiveMana(mana_gain_final)
			end

			self:PlayEffectsOnImpact(unit, _self.currentPosition)
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}
	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
	self:StartCooldown(attack_speed)

	self:PlayEffectsOnCast()
end

--------------------------------------------------------------------------------
-- Misc
-- Add mana on attack modifier. Only first time upgraded
function treant_basic_attack:OnUpgrade()
	if self:GetLevel()==1 then
		local caster = self:GetCaster()
		-- Gain mana
		caster:AddNewModifier(caster, self , "modifier_mana_on_attack", {})
	end
end

--------------------------------------------------------------------------------
-- Graphics & sounds

-- On Projectile Finish
function treant_basic_attack:PlayEffectsOnFinish( pos )
	local caster = self:GetCaster()
	-- Create Particles
	local particle_cast = "particles/econ/items/necrolyte/necronub_base_attack/necrolyte_base_attack_ka_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function treant_basic_attack:PlayEffectsOnCast( )
	local sound_cast = "Hero_Treant.PreAttack"
	EmitSoundOn( sound_cast, self:GetCaster() )
end

-- On Projectile Hit enemy
function treant_basic_attack:PlayEffectsOnImpact( hTarget, pos )
	local sound_cast = "Hero_Treant.Attack.Impact"
	EmitSoundOn( sound_cast, hTarget )
end
