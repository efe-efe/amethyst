spectre_ex_second_attack = class({})
LinkLuaModifier( "modifier_spectre_ex_second_attack", "abilities/heroes/spectre/spectre_ex_second_attack/modifier_spectre_ex_second_attack", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spectre_desolate_lua", "abilities/heroes/spectre/spectre_shared_modifiers/modifier_spectre_desolate_lua/modifier_spectre_desolate_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- End casting
function spectre_ex_second_attack:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()
	
	-- load data
	local projectile_name = "particles/mod_units/heroes/hero_dark_willow/dark_willow_base_attack.vpcf"
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local hitbox = self:GetSpecialValueFor("hitbox")
    local projectile_vision = 0
	local damage = self:GetAbilityDamage()
	local debuff_duration = self:GetSpecialValueFor("debuff_duration")
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()

	-- logic
	local projectile = {
		EffectName = projectile_name,
		vSpawnOrigin = caster:GetAbsOrigin() + Vector(0,0,80),
		fDistance =	self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fUniqueRadius = hitbox,
		Source = caster,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_DESTROY,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 80,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit) 
			local damage = {
				victim = unit,
				attacker = _self.Source,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}
			ApplyDamage( damage )

			unit:AddNewModifier(
				_self.Source, 
				self, 
				"modifier_spectre_ex_second_attack", 
				{ duration = debuff_duration }
			)
			unit:AddNewModifier(
				_self.Source, 
				self, 
				"modifier_spectre_desolate_lua", 
				{ duration = debuff_duration }
			)
		end,
		OnFinish = function(_self, pos)
			self:PlayEffects(pos)
		end,
	}

	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
end


--Impact
function spectre_ex_second_attack:PlayEffects(pos)
	-- Get Resources
    local sound_cast = "Hero_Nevermore.RequiemOfSouls.Damage"
	local particle_cast = "particles/units/heroes/hero_spectre/spectre_ambient_endcap.vpcf"

	-- Create Sound
	EmitSoundOnLocationWithCaster( pos, sound_cast, self:GetCaster() )

	-- Create Particles
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

if IsClient() then require("abilities") end
Abilities.Initialize( 
	spectre_ex_second_attack,
	{ activity = ACT_DOTA_CAST_ABILITY_1, rate = 1.0 },
	{ movement_speed = 0, fixed_range = 1 }
)