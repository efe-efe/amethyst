
juggernaut_ex_special_attack = class({})

function juggernaut_ex_special_attack:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()
	local damage = self:GetAbilityDamage()

	local fading_slow_duration = self:GetSpecialValueFor("fading_slow_duration")

	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()

	local projectile = {
		EffectName = "particles/mod_units/heroes/hero_silencer/silencer_ti8_glaive.vpcf",
		vSpawnOrigin = caster:GetAbsOrigin() + Vector(0,0,80),
		fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fUniqueRadius = self:GetSpecialValueFor("hitbox"),
		Source = caster,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_DESTROY,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit) 
			local damage_table = {
				victim = unit,
				attacker = _self.Source,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}
			ApplyDamage( damage_table )

			unit:AddNewModifier(_self.Source, self, "modifier_generic_fading_slow", { 
				duration = fading_slow_duration,
				effect_name = "particles/generic_gameplay/generic_purge.vpcf"
			})

            local particle_cast = "particles/econ/events/nexon_hero_compendium_2014/blink_dagger_start_nexon_hero_cp_2014.vpcf"
            local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, _self.Source )
            ParticleManager:ReleaseParticleIndex( effect_cast )
            
            FindClearSpaceForUnit( _self.Source, unit:GetOrigin() , true )
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}

	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end


--------------------------------------------------------------------------------
-- Effects
function juggernaut_ex_special_attack:PlayEffectsOnFinish( pos )
	-- Create Sound
	local sound_cast = "Hero_Juggernaut.Attack"
	EmitSoundOnLocationWithCaster( pos, sound_cast, self:GetCaster() )
	
	-- Create Particles
	local particle_cast = "particles/units/heroes/hero_luna/luna_base_attack_impact.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 1, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function juggernaut_ex_special_attack:PlayEffectsOnCast()
	EmitSoundOn("juggernaut_jug_spawn_02", self:GetCaster())
	EmitSoundOn("Hero_Juggernaut.ArcanaTrigger", self:GetCaster())	 
	EmitSoundOn( "Hero_Juggernaut.BladeDance", self:GetCaster() )
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	juggernaut_ex_special_attack,
	{ activity = ACT_DOTA_TAUNT, rate = 1.3, translate = "odachi" },
	{ movement_speed = 10, fixed_range = 1 }
)