spectre_ex_second_attack_projectile = class({})

--------------------------------------------------------------------------------
-- End casting
function spectre_ex_second_attack_projectile:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()
	local ability = caster:FindAbilityByName("spectre_ex_second_attack")
	
	local hitbox = self:GetSpecialValueFor("hitbox")
	local damage = self:GetAbilityDamage()

	local heal = ability:GetSpecialValueFor("heal")

	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	-- logic
	local projectile = {
		EffectName = "particles/mod_units/heroes/hero_dark_willow/dark_willow_base_attack.vpcf",
		vSpawnOrigin = caster:GetAbsOrigin() + Vector(0,0,80),
		fDistance =	self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		bUniqueRadius = hitbox,
		Source = caster,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_DESTROY,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 80,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and unit:GetTeamNumber() ~= _self.Source:GetTeamNumber() end,
		OnUnitHit = function(_self, unit) 
			local damage = {
				victim = unit,
				attacker = _self.Source,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}
			ApplyDamage( damage )
			_self.Source:Heal(heal, _self.Source)
		end,
		OnFinish = function(_self, pos)
			self:PlayEffects(pos)
		end,
	}

	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
end


--Impact
function spectre_ex_second_attack_projectile:PlayEffects(pos)
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
	spectre_ex_second_attack_projectile,
	{ activity = ACT_DOTA_CAST_ABILITY_1, rate = 1.3 },
	{ movement_speed = 100, fixed_range = 1 }
)