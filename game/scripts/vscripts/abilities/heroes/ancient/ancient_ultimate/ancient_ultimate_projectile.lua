ancient_ultimate_projectile = class({})

function ancient_ultimate_projectile:OnCastPointEnd( )
	-- Initialize variables
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()
    local point = CalcRange(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)

	local ability = caster:FindAbilityByName("ancient_ultimate") -- Get special values from original
	local damage = ability:GetSpecialValueFor("ability_damage")

    local projectile_distance = (point - origin):Length2D()
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	-- Extra data
	local projectile = {
		EffectName = "particles/econ/items/ancient_apparition/aa_blast_ti_5/ancient_apparition_ice_blast_initial_ti5.vpcf",
		vSpawnOrigin = {unit=caster, attach="attach_attack1", offset=Vector(0,0,0)},
		fDistance = projectile_distance,
		fUniqueRadius = self:GetSpecialValueFor("hitbox"),
		fEndRadius = projectile_end_radius,
		Source = caster,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_NOTHING,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_NOTHING,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 80,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit)
			--self:PlayEffectsTarget(unit, _self.currentPosition)
		end,
		OnFinish = function(_self, pos)

			local enemies = FindUnitsInRadius( 
				caster:GetTeamNumber(), -- int, your team number
				pos, -- point, center point
				nil, -- handle, cacheUnit. (not known)
				self:GetSpecialValueFor("radius"), -- float, radius. or use FIND_UNITS_EVERYWHERE
				DOTA_UNIT_TARGET_TEAM_BOTH, -- int, team filter
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
				0, -- int, flag filter
				0, -- int, order filter
				false -- bool, can grow cache
			)
			for _,enemy in pairs(enemies) do
				local damage_table = {
					victim = enemy,
					attacker = caster,
					damage = 60,
					damage_type = DAMAGE_TYPE_PURE,
				}
				ApplyDamage( damage_table )

			end

			self:PlayEffectsProjectileImpact(pos)
		end,
	}

    Projectiles:CreateProjectile(projectile)
	--self:PlayEffectsOnCast()
end

-- On hit wall 
function ancient_ultimate_projectile:PlayEffectsProjectileImpact( pos )
	local caster = self:GetCaster()

	-- Cast Sound
	EmitSoundOn( "Hero_Sniper.AssassinateDamage", caster )

	-- Cast Particle
	local particle_cast = "particles/econ/items/ancient_apparition/aa_blast_ti_5/ancient_apparition_ice_blast_explode_ti5.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

if IsClient() then require("abilities") end
Abilities.Initialize( 
	ancient_ultimate_projectile,
	{ activity = ACT_DOTA_GENERIC_CHANNEL_1, rate = 1.0 },
	{ movement_speed = 0, disable_all = false }
)
