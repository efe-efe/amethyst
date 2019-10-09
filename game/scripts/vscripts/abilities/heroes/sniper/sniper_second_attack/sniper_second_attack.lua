sniper_second_attack = class({})
LinkLuaModifier( "modifier_generic_stunned", "abilities/generic/modifier_generic_stunned", LUA_MODIFIER_MOTION_NONE )

function sniper_second_attack:OnSpellStart()
    EmitGlobalSound( "Ability.AssassinateLoad")
end

function sniper_second_attack:OnCastPointEnd()
	-- Initialize variables
    local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = self:GetCursorPosition()
	local damage = self:GetAbilityDamage()

	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	local stun_duration = self:GetSpecialValueFor("stun_duration")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local reduction_per_hit = self:GetSpecialValueFor("reduction_per_hit")/100

	local projectile = {
		EffectName = "particles/mod_units/heroes/hero_sniper/sniper_assassinate.vpcf",
		vSpawnOrigin = {unit=caster, attach="attach_attack1", offset=Vector(0,0,0)},
		fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fUniqueRadius = self:GetSpecialValueFor("hitbox"),
		Source = caster,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_NOTHING,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 80,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and unit:GetTeamNumber() ~= _self.Source:GetTeamNumber() end,
		OnUnitHit = function(_self, unit)
			-- Count targets
			local counter = -1
			for k, v in pairs(_self.rehit) do
				counter = counter + 1
			end
			local final_damage = damage * (1 - (counter * reduction_per_hit))
			
			-- Damage
			local damage = {
				victim = unit,
				attacker = _self.Source,
				damage = final_damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}			
			
			-- Give Mana
			if counter < 1 then
				_self.Source:GiveManaPercent(mana_gain_pct)
			end
	
			ApplyDamage( damage )
			-- Stun
			unit:AddNewModifier(_self.Source, self , "modifier_generic_stunned", { duration = stun_duration})
	
			self:PlayEffectsOnHit(unit)
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}

    Projectiles:CreateProjectile(projectile)
	StartAnimation(caster, {duration=0.2, activity=ACT_DOTA_ATTACK, rate=1.5})
	
	self:PlayEffectsOnCast()
end


--------------------------------------------------------------------------------
-- Graphics & sounds
function sniper_second_attack:PlayEffectsOnCast()
	EmitSoundOn( "Ability.Assassinate", self:GetCaster() )
end

-- On hit wall 
function sniper_second_attack:PlayEffectsOnFinish( pos )
	local caster = self:GetCaster()
	EmitSoundOnLocationWithCaster( pos, "Hero_Sniper.AssassinateDamage", caster )

	-- Cast Particle
	local particle_cast = "particles/mod_units/heroes/hero_sniper/sniper_assassinate_impact_sparks.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:SetParticleControl( effect_cast, 1, pos )
	
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

--------------------------------------------------------------------------------
-- Graphics & sounds
function sniper_second_attack:PlayEffectsOnHit( hTarget )
	local caster = self:GetCaster()
	
	-- Cast Sound
	EmitSoundOn( "Hero_Sniper.AssassinateDamage", caster )

	-- Cast Particles
	local particle_cast = "particles/mod_units/heroes/hero_sniper/sniper_assassinate_impact_blood.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget )

	ParticleManager:SetParticleControl( effect_cast, 0, hTarget:GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, hTarget:GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

if IsClient() then require("abilities") end
Abilities.Initialize( 
	sniper_second_attack,
	{ activity = ACT_DOTA_CAST_ABILITY_1, rate = 1.3 },
	{ movement_speed = 0, fixed_range = 1, public = 1 }
)
