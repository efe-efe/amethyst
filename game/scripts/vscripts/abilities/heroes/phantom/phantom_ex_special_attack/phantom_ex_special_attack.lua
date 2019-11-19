
phantom_ex_special_attack = class({})
LinkLuaModifier( "modifier_generic_sleep_lua", "abilities/generic/modifier_generic_sleep_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phantom_ex_special_attack_charges", "abilities/heroes/phantom/phantom_ex_special_attack/modifier_phantom_ex_special_attack_charges", LUA_MODIFIER_MOTION_NONE )


--------------------------------------------------------------------------------
-- Passive Modifier
function phantom_ex_special_attack:GetIntrinsicModifierName()
	return "modifier_phantom_ex_special_attack_charges"
end

function phantom_ex_special_attack:HasCharges()
	return true
end


--------------------------------------------------------------------------------
-- Ability Start
function phantom_ex_special_attack:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()
	local damage = self:GetSpecialValueFor("ability_damage")
	
	local sleep_duration = self:GetSpecialValueFor("sleep_duration")
	local sleep_per_stack = self:GetSpecialValueFor("sleep_per_stack")
	local should_lifesteal = caster:HasModifier("modifier_phantom_ex_basic_attack")

	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()
	local stacks = SafeGetModifierStacks("modifier_phantom_strike_stack", caster, caster)

	local projectile = {
		EffectName = "particles/mod_units/heroes/hero_phantom_assassin/phantom_assassin_stifling_dagger.vpcf",
		vSpawnOrigin = caster:GetAbsOrigin() + Vector(0,0,80),
		fDistance =	self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
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
			local damage = {
				victim = unit,
				attacker = _self.Source,
				damage = damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
			}
	
			ApplyDamage( damage )
	
			-- Add modifier
			unit:AddNewModifier(
				caster, -- player source
				self, -- ability source
				"modifier_generic_sleep_lua", -- modifier name
				{ duration = sleep_duration + (stacks * sleep_per_stack) } -- kv
			)

			if should_lifesteal then
				local ability = caster:FindAbilityByName("phantom_ex_basic_attack")
				local heal = ability:GetSpecialValueFor( "heal" )
				caster:Heal(heal, caster)
			end
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}
	SafeDestroyModifier("modifier_phantom_strike_stack", caster, caster)
	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

--------------------------------------------------------------------------------
-- Effects
function phantom_ex_special_attack:PlayEffectsOnFinish( pos )
	-- Create Sound
	EmitSoundOnLocationWithCaster( pos, "Hero_PhantomAssassin.Dagger.Target", self:GetCaster() )
	
	-- Create Particles
	local particle_cast = "particles/mod_units/heroes/hero_phantom_assassin/phantom_assassin_stifling_dagger_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

-- On ability start
function phantom_ex_special_attack:PlayEffectsOnCast( )
	EmitSoundOn( "Hero_PhantomAssassin.Dagger.Cast", self:GetCaster() )
end


if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	phantom_ex_special_attack,
	{ activity = ACT_DOTA_CAST_ABILITY_3, rate = 1.3 },
	{ movement_speed = 0, fixed_range = 1}
)