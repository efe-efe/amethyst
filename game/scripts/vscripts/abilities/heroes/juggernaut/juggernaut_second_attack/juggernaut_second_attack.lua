juggernaut_second_attack = class({})

function juggernaut_second_attack:OnCastPointEnd( )
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()
	local damage = self:GetAbilityDamage()

	local damage_per_stack = self:GetSpecialValueFor("damage_per_stack")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")

	-- Dinamyc data
	local projectile_speed = 2000
	local projectile_direction = ( Vector( point.x - origin.x, point.y - origin.y, 0)):Normalized()
	local offset = 80

	local projectile = {
		vSpawnOrigin = origin + Vector(projectile_direction.x * offset, projectile_direction.y * offset, 0),
		fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fUniqueRadius = self:GetSpecialValueFor("hitbox"),
		Source = caster,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_DESTROY,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 0,
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
				caster:GiveManaPercent(mana_gain_pct)
			end
			
			self:PlayEffectsOnImpact(unit, stacks)
		end,
		OnFinish = function(_self, pos)
			if next(_self.rehit) == nil then
				self:PlayEffectsOnFinish(pos)
			end

			SafeDestroyModifier("modifier_juggernaut_basic_attack_stacks", caster, caster)
		end,
	}

	Projectiles:CreateProjectile(projectile)
end

--------------------------------------------------------------------------------
-- Effects
-- On Projectile Hit enemy
function juggernaut_second_attack:PlayEffectsOnImpact( hTarget, stacks )
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
function juggernaut_second_attack:PlayEffectsOnFinish(pos)
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

if IsClient() then require("abilities") end
Abilities.Initialize( 
	juggernaut_second_attack,
	{ activity = ACT_DOTA_SPAWN, translate = "odachi", rate = 3.0 },
	{ movement_speed = 10 }
)