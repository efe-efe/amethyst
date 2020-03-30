item_orchid_custom = class({})

function item_orchid_custom:OnCastPointEnd()
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()
	local point = self:GetCursorPosition()

	local duration = self:GetSpecialValueFor("duration")

	-- Dynamic data
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()
    local projectile_speed = self:GetSpecialValueFor("projectile_speed")
    
    local projectile = {
		EffectName = 			"particles/orchid_proj.vpcf",
		vSpawnOrigin = 			caster:GetAbsOrigin() + Vector(0,0,80),
		fDistance = 			self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fUniqueRadius =			self:GetSpecialValueFor("hitbox"),
		Source = 				caster,
		vVelocity = 			projectile_direction * projectile_speed,
		UnitBehavior = 			PROJECTILES_DESTROY,
		WallBehavior = 			PROJECTILES_DESTROY,
		TreeBehavior = 			PROJECTILES_NOTHING,
		GroundBehavior = 		PROJECTILES_NOTHING,
		fGroundOffset = 		80,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit)
			unit:AddNewModifier(_self.Source, self, "modifier_generic_silenced", { duration = duration })
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}

	-- Cast projectile
    Projectiles:CreateProjectile(projectile)
    self:PlayEffectsOnCast()
end

function item_orchid_custom:PlayEffectsOnFinish(pos)
	local caster = self:GetCaster()
	EmitSoundOnLocationWithCaster( pos, "DOTA_Item.Orchid.Activate", caster )

	-- Create Particles
	local particle_cast = "particles/orchid_proj_impact.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function item_orchid_custom:PlayEffectsOnCast()
	EmitSoundOn( "DOTA_Item.Orchid.Activate", self:GetCaster() )
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
    item_orchid_custom,
	{ activity = ACT_DOTA_ATTACK, rate = 1.0 },
	{ movement_speed = 10, fixed_range = 1 }
)
