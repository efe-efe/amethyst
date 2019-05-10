wisp_basic_attack_lua = class ({})
LinkLuaModifier( "modifier_wisp_basic_attack_lua", "abilities/heroes/wisp/wisp_basic_attack_lua/modifier_wisp_basic_attack_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function wisp_basic_attack_lua:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = self:GetCursorPosition()
	local ability = self
	local attacks_per_second = caster:GetAttacksPerSecond()
	local attack_speed = ( 1 / attacks_per_second )
	local ex_ultimate_modifier = caster:FindModifierByNameAndCaster( "modifier_wisp_ex_ultimate_lua", caster )


	-- load data
	local projectile_name = "particles/mod_units/heroes/hero_wisp/wisp_base_attack.vpcf"
	local projectile_start_radius = self:GetSpecialValueFor("hitbox")
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local modifier_duration_bonus = self:GetSpecialValueFor("modifier_duration_bonus")
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()
	local projectile_speed = 400--self:GetSpecialValueFor("projectile_speed")

	-- If have the ex-ultimate, change the visuals
	if ex_ultimate_modifier ~= nil then
		projectile_name="particles/mod_units/heroes/hero_batrider/batrider_base_attack.vpcf"
	end
	
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
		draw = true,
		fRehitDelay = 1.0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and unit:GetTeamNumber() ~= caster:GetTeamNumber() end,
		OnUnitHit = function(_self, unit)
			DebugPrint("Hello") 
			--[[local special_behavior = unit:FindModifierByName("modifier_generic_projectile_special_behavior_lua")
			if special_behavior ~= nil then
				if not special_behavior:IsNull() then
					DebugPrint("Special")
					return
				end
			end]]
			
			--Blocked
			--------------------
			local is_slower = unit:FindModifierByName("modifier_generic_projectile_blocker_lua")
			if is_slower ~= nil then
				if not is_slower:IsNull() then
					_self.SetVelocity(0, projectile_direction * projectile_speed * 0.15)
					return
				end
			end

			-- Hit
			--------------------
			local guardian_essence = unit:FindModifierByNameAndCaster( "modifier_wisp_guardian_essence_lua", caster )
			local modifier_attack_bonus = nil

			-- If have the debuff, adds extra attack and extends debuff duration
			if guardian_essence ~= nil then
				local new_duration = guardian_essence:GetRemainingTime() + modifier_duration_bonus
				guardian_essence:SetDuration(new_duration, true)
				modifier_attack_bonus = caster:AddNewModifier(caster, ability , "modifier_wisp_basic_attack_lua", {})
			end

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

			--Remove the extra attack
			if modifier_attack_bonus ~= nil then
				if not modifier_attack_bonus:IsNull() then
					modifier_attack_bonus:Destroy()
				end
			end

			self:PlayEffects_b(_self:GetPosition())
			_self.Destroy()
		end,
		OnFinish = function(_self, pos)
			self:PlayEffects_b(pos)
		end,
	}

	--self:StartCooldown(attack_speed)
	self:PlayEffects_a()

	-- Cast projectile
	Projectiles:CreateProjectile(projectile)

end

--------------------------------------------------------------------------------
-- Graphics & sounds
function wisp_basic_attack_lua:PlayEffects_a()
	-- Get Resources
	local sound_cast = "Hero_Wisp.Attack"

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end

-- On hit wall 
function wisp_basic_attack_lua:PlayEffects_b( pos )
	local caster = self:GetCaster()
	
	-- Cast Sound
	local sound_cast = "Hero_Wisp.ProjectileImpact"
	EmitSoundOnLocationWithCaster( pos, sound_cast, caster )

	-- Cast Particle
	local particle_cast = "particles/mod_units/heroes/hero_wisp/wisp_base_attack_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:SetParticleControl( effect_cast, 1, pos )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )
	
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

-- Add mana on attack modifier. Only first time upgraded
function wisp_basic_attack_lua:OnUpgrade()
	if self:GetLevel()==1 then
		local caster = self:GetCaster()
		-- Gain mana
		caster:AddNewModifier(caster, self , "modifier_mana_on_attack", {})
	end
end