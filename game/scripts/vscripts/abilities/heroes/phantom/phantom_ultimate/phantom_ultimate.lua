phantom_ultimate = class({})

function phantom_ultimate:OnCastPointEnd()
    --Initialize variables
    local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = self:GetCursorPosition()
	
    local max_range = self:GetSpecialValueFor("range")
    local damage = self:GetAbilityDamage()
    local damage_per_stack = self:GetSpecialValueFor("damage_per_stack")

	-- load data
	local projectile_name = "particles/mod_units/heroes/hero_luna/luna_base_attack.vpcf"
	local projectile_start_radius = 70
	local projectile_end_radius = 100
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()
	local projectile_speed = 4500

	local projectile = {
		EffectName = projectile_name,
		vSpawnOrigin = {unit=caster, attach="attach_attack1", offset=Vector(0,0,0)},
		fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fStartRadius = projectile_start_radius,
		fEndRadius = projectile_end_radius,
		Source = caster,
		bIsReflectable = false,
		bIsSlowable = false,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_DESTROY,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_NOTHING,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 80,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and unit:GetTeamNumber() ~= _self.Source:GetTeamNumber() end,
		OnUnitHit = function(_self, unit) 
			local stacks = SafeGetModifierStacks("modifier_phantom_strike_stack", caster, caster)
			local final_damage = damage + ( stacks * damage_per_stack )

			local damage_table = {
				victim = unit,
				attacker = _self.Source,
				damage = final_damage,
				damage_type = DAMAGE_TYPE_PURE,
			}
			
			ApplyDamage( damage_table )

            FindClearSpaceForUnit( caster, unit:GetOrigin() , true )

			SendOverheadEventMessage(nil, OVERHEAD_ALERT_CRITICAL, unit, final_damage, nil )

            self:PlayEffectsOnImpact(unit)
		end,
        OnFinish = function(_self, pos)
			SafeDestroyModifier("modifier_phantom_strike_stack", caster, caster)
			self:PlayEffectsOnFinish(pos)
		end,
	}
	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

-- On projectile finish
function phantom_ultimate:PlayEffectsOnFinish(pos)
	-- Cast Sound
    EmitSoundOn( "Hero_PhantomAssassin.Strike.End", self:GetCaster())
	EmitSoundOn( "Hero_PhantomAssassin.Arcana_Layer", self:GetCaster() )
end

-- On Projectile hit an enemy
function phantom_ultimate:PlayEffectsOnImpact(hTarget)
    EmitSoundOn("Hero_PhantomAssassin.Spatter", hTarget)
    EmitSoundOn("Hero_PhantomAssassin.CoupDeGrace", hTarget)

    -- Cast Particles
	local particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_impact_dagger_arcana.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget )
    ParticleManager:SetParticleControl( effect_cast, 1, hTarget:GetOrigin() )
    ParticleManager:SetParticleControlForward( effect_cast, 1, hTarget:GetForwardVector() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	
	particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_end.vpcf"
	effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

-- On spell start
function phantom_ultimate:PlayEffectsOnCast()
    -- Cast Particles
    local particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_start.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end


if IsClient() then require("abilities") end
Abilities.Initialize( 
	phantom_ultimate,
	{ activity = ACT_DOTA_CAST_ABILITY_3, rate = 0.7 },
	{ movement_speed = 0, fixed_range = 1 }
)