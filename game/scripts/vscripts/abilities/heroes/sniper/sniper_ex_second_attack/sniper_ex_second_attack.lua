sniper_ex_second_attack = class({})

--------------------------------------------------------------------------------
-- Ability Start
function sniper_ex_second_attack:OnSpellStart()
	self:PlayEffectsOnPhase()
end

function sniper_ex_second_attack:OnCastPointEnd( pos )
	-- Initialize variables
    local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = self:GetCursorPosition()
	local damage = self:GetSpecialValueFor("ability_damage")

	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	local root_duration = self:GetSpecialValueFor("root_duration")

	local projectile = {
		EffectName = "particles/mod_units/heroes/hero_sniper/sniper_assassinate.vpcf",
		vSpawnOrigin = origin + Vector(0,0, 96),
		fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fUniqueRadius = self:GetSpecialValueFor("hitbox"),
		Source = caster,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_NOTHING,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 80,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit)
			-- Damage
			local damage = {
				victim = unit,
				attacker = _self.Source,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}			

			ApplyDamage( damage )
			-- Stun
			unit:AddNewModifier(_self.Source, self , "modifier_generic_rooted_lua", { duration = root_duration })
	
			self:PlayEffectsOnImpact(unit)
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}
	
    Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end


--------------------------------------------------------------------------------
-- Graphics & sounds

function sniper_ex_second_attack:PlayEffectsOnPhase()
    EmitGlobalSound( "Ability.AssassinateLoad")
end

function sniper_ex_second_attack:PlayEffectsOnCast()
	EmitSoundOn( "Ability.Assassinate", self:GetCaster() )
end

-- On hit wall 
function sniper_ex_second_attack:PlayEffectsOnFinish( pos )
	local caster = self:GetCaster()
	
	-- Cast Sound
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
function sniper_ex_second_attack:PlayEffectsOnImpact( hTarget )
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

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	sniper_ex_second_attack,
	{ activity = ACT_DOTA_ATTACK, rate = 0.8 },
	{ movement_speed = 0, fixed_range = 1, public = 1 }
)
