vengeful_ex_counter = class({})
vengeful_ex_counter_ultimate = class({})
LinkLuaModifier( "modifier_vengeful_ex_counter", "abilities/heroes/vengeful/vengeful_ex_counter/modifier_vengeful_ex_counter", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function vengeful_ex_counter:OnCastPointEnd()
	local caster = self:GetCaster()
	local ability = caster:FindAbilityByName("vengeful_ex_counter")
	local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()
	local damage = ability:GetSpecialValueFor("ability_damage")
	local counter = 0

	-- load data
    local mana_gain_pct = ability:GetSpecialValueFor("mana_gain_pct")
	local link_duration = ability:GetSpecialValueFor("link_duration")
	local backwards_damage = ability:GetSpecialValueFor("backwards_damage")
	local heal_per_target = ability:GetSpecialValueFor("heal_per_target")
	local speed_per_target_pct = ability:GetSpecialValueFor("speed_per_target_pct")
	local duration_per_target = ability:GetSpecialValueFor("duration_per_target")
	
	-- Dynamic data
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()
	local projectile_speed = ability:GetSpecialValueFor("projectile_speed")

	--local targets = 0

	local projectile_forward = {
		EffectName = 			"particles/econ/items/vengeful/vengeful_weapon_talon/vengeful_wave_of_terror_weapon_talon.vpcf",
		vSpawnOrigin = 			caster:GetAbsOrigin() + Vector(0,0,80),
		fDistance = 			ability:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fUniqueRadius =			ability:GetSpecialValueFor("hitbox"),
		Source = 				caster,
		vVelocity = 			projectile_direction * projectile_speed,
		UnitBehavior = 			PROJECTILES_NOTHING,
		WallBehavior = 			PROJECTILES_NOTHING,
		TreeBehavior = 			PROJECTILES_NOTHING,
        GroundBehavior = 		PROJECTILES_NOTHING,
        bIsReflectable =        false,
        bIsSlowable =           false,
		fGroundOffset = 		80,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit)
			local damage_table = {
				victim = unit,
				attacker = caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = self,
			}

			--targets = targets + 1
			--_self.Source:Heal(heal_per_target, _self.Source)
			ApplyDamage( damage_table )
			self:PlayEffectsOnImpact(unit)
		end,
		OnFinish = function(_self, pos)
			--local modifier = caster:AddNewModifier(caster, self, "modifier_vengeful_ex_counter", { duration = duration_per_target * targets })
			--modifier:SetStackCount(targets * speed_per_target_pct)
			self:PlayEffectsOnFinish(pos, _self.Source)
		end,
    }

	-- Cast projectile
	Projectiles:CreateProjectile(projectile_forward)
	self:PlayEffectsOnCast()
end

--------------------------------------------------------------------------------
-- Graphics & sounds

function vengeful_ex_counter:PlayEffectsOnFinish( pos, caster )
	-- Create Particles
	local particle_cast = "particles/meteor_hammer_spell_ground_impact.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )
	ParticleManager:SetParticleControl( effect_cast, 4, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function vengeful_ex_counter:PlayEffectsOnCast()
	EmitSoundOn( "Hero_VengefulSpirit.WaveOfTerror", self:GetCaster() )
end

function vengeful_ex_counter:PlayEffectsOnReCast(caster)
	EmitSoundOn( "Hero_VengefulSpirit.Death", caster )
end


function vengeful_ex_counter:PlayEffectsOnImpactCaster(caster)
	local particle_cast = "particles/items4_fx/meteor_hammer_spell_impact_ember.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, caster:GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 3, caster:GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 4, caster:GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function vengeful_ex_counter:PlayEffectsOnImpact(hTarget)
	local particle_cast = "particles/units/heroes/hero_vengeful/vengeful_wave_of_terror_recipient.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, hTarget )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function vengeful_ex_counter:PlayEffectsProjectile(pos, vel)
	local particle_cast = "particles/econ/items/vengeful/vengeful_weapon_talon/vengeful_wave_of_terror_talon_child.vpcf"
	self.effect_cast_projectile = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( self.effect_cast_projectile, 0, pos )
	ParticleManager:SetParticleControl( self.effect_cast_projectile, 1, vel )
	ParticleManager:SetParticleControlForward(self.effect_cast_projectile, 0, vel:Normalized())

end

function vengeful_ex_counter:StopEffectsProjectile()
	if self.effect_cast_projectile then
		ParticleManager:DestroyParticle(self.effect_cast_projectile, false)
		ParticleManager:ReleaseParticleIndex( self.effect_cast_projectile )
	end
end

vengeful_ex_counter_ultimate.OnCastPointEnd = vengeful_ex_counter.OnCastPointEnd
vengeful_ex_counter_ultimate.PlayEffectsOnFinish = vengeful_ex_counter.PlayEffectsOnFinish
vengeful_ex_counter_ultimate.PlayEffectsOnCast = vengeful_ex_counter.PlayEffectsOnCast
vengeful_ex_counter_ultimate.PlayEffectsProjectile = vengeful_ex_counter.PlayEffectsProjectile
vengeful_ex_counter_ultimate.StopEffectsProjectile = vengeful_ex_counter.StopEffectsProjectile
vengeful_ex_counter_ultimate.PlayEffectsOnReCast = vengeful_ex_counter.PlayEffectsOnReCast
vengeful_ex_counter_ultimate.PlayEffectsOnImpact = vengeful_ex_counter.PlayEffectsOnImpact
vengeful_ex_counter_ultimate.PlayEffectsOnImpactCaster = vengeful_ex_counter.PlayEffectsOnImpactCaster

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	vengeful_ex_counter,
	{ activity = ACT_DOTA_CAST_ABILITY_2, rate = 1.0 },
	{ movement_speed = 0, fixed_range = 1}
)
if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	vengeful_ex_counter_ultimate,
	{ activity = ACT_DOTA_CAST_ABILITY_2, rate = 1.0 },
	{ movement_speed = 0, fixed_range = 1}
)

