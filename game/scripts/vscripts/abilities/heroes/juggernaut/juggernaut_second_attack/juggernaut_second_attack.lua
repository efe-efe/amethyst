juggernaut_second_attack = class({})

function juggernaut_second_attack:GetAlternateVersion()
    return self:GetCaster():FindAbilityByName("juggernaut_ex_second_attack")
end

--------------------------------------------------------------------------------
-- Ability Start
function juggernaut_second_attack:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()

	-- Animation and pseudo cast point
	StartAnimation(caster, {
		duration = cast_point + 0.1, 
		translate="odachi",
		activity = ACT_DOTA_SPAWN,
		rate = 3.0
	})
	caster:AddNewModifier(caster, self , "modifier_cast_point", { 
		duration = cast_point,
		movement_speed = 10
	})
end


function juggernaut_second_attack:OnCastPointEnd( pos )
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
			local stacks = SafeGetModifierStacks("modifier_juggernaut_basic_attack_stacks", caster, caster)
			local final_damage = damage + ( stacks * damage_per_stack )

			local damage_table = {
				victim = unit,
				attacker = _self.Source,
				damage = final_damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
			}

			ApplyDamage( damage_table )
			
			SendOverheadEventMessage(nil, OVERHEAD_ALERT_CRITICAL, unit, final_damage, nil )
			SafeDestroyModifier("modifier_juggernaut_basic_attack_stacks", caster, caster)

			if _self.Source == caster then
				-- Give Mana
				local mana_gain_final = caster:GetMaxMana() * mana_gain
				caster:GiveMana(mana_gain_final)
			end
			
			self:PlayEffects_a(unit, stacks)
		end,
		OnFinish = function(_self, pos)
			if next(_self.rehit) == nil then
				self:PlayEffects_b(pos)
			end

			SafeDestroyModifier("modifier_juggernaut_basic_attack_stacks", caster, caster)
		end,
	}


	-- Cast projectile
	Projectiles:CreateProjectile(projectile)

	-- Put CD on the alternate of the ability
	local alternate_version = caster:FindAbilityByName("juggernaut_ex_second_attack")
	alternate_version:StartCooldown(self:GetCooldown(0))
end

--------------------------------------------------------------------------------
-- Effects

-- On Projectile Hit enemy
function juggernaut_second_attack:PlayEffects_a( hTarget, stacks )
	-- Create Sound
	local sound_cast_a = "Hero_Juggernaut.BladeDance.Arcana"
	local sound_cast_b = "Hero_Juggernaut.BladeDance.Layer"
	local sound_cast_c = "Hero_Juggernaut.Attack"
	EmitSoundOn( sound_cast_a, hTarget )
	EmitSoundOn( sound_cast_b, hTarget )
	EmitSoundOn( sound_cast_c, hTarget )

	-- Create Particles
	local particle_cast = "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_crit_tgt.vpcf"

	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget )
    ParticleManager:SetParticleControl( effect_cast, 1, hTarget:GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 3, hTarget:GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

-- On Projectile Miss
function juggernaut_second_attack:PlayEffects_b(pos)
	local caster = self:GetCaster()

	-- Create Sound
	local sound_cast = "Hero_Juggernaut.BladeDance"
	EmitSoundOnLocationWithCaster( pos, sound_cast, caster )

	local position_final = caster:GetOrigin() + (pos - caster:GetOrigin()):Normalized() * 20

	-- Create Particles
	local particle_cast_a = "particles/econ/items/chaos_knight/chaos_knight_ti9_weapon/chaos_knight_ti9_weapon_blur_crit_arc.vpcf"
	local effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_POINT, caster )
    ParticleManager:SetParticleControl( 
		effect_cast_a, 
		0, 
		Vector(position_final.x, position_final.y, caster:GetOrigin().z - 100)
	)
	ParticleManager:ReleaseParticleIndex( effect_cast_a )
end

