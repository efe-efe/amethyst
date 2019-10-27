treant_special_attack = class({})
LinkLuaModifier( "modifier_treant_leeching_seed", "abilities/heroes/treant/treant_shared_modifiers/modifier_treant_leeching_seed", LUA_MODIFIER_MOTION_NONE )

function treant_special_attack:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()

	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	-- Extra data
	local slow_duration = self:GetSpecialValueFor("slow_duration")
    local mana_gain = self:GetSpecialValueFor("mana_gain")/100
    local leeching_duration = self:GetSpecialValueFor("leeching_duration")

	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()

	local damage = self:GetAbilityDamage()

	local projectile = {
		EffectName = "particles/mod_units/heroes/hero_treant/treant_leech_seed_projectile.vpcf",
		vSpawnOrigin = caster:GetAbsOrigin() + Vector(0,0,80),
		fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fUniqueRadius = hitbox,
		Source = caster,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_DESTROY,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and unit:GetTeamNumber() ~= _self.Source:GetTeamNumber() end,
		OnUnitHit = function(_self, unit) 
			local damage_table = {
				victim = unit,
				attacker = caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
			}
			ApplyDamage( damage_table )

            unit:AddNewModifier(caster, self, "modifier_treant_leeching_seed", { duration = leeching_duration }) 

            if _self.Source == caster then
				-- Give Mana
				local mana_gain_final = caster:GetMaxMana() * mana_gain
				caster:GiveMana(mana_gain_final)
			end
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}

	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnLaunch()
end


--------------------------------------------------------------------------------
-- Effects
function treant_special_attack:PlayEffectsOnFinish( pos )
	-- Create Sound
	local sound_cast = "Hero_Treant.LeechSeed.Target"
	EmitSoundOnLocationWithCaster( pos, sound_cast, self:GetCaster() )
	
	-- Create Particles
	local particle_cast = "particles/mod_units/heroes/hero_wisp/wisp_guardian_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function treant_special_attack:PlayEffectsOnLaunch( )
    EmitSoundOn( "Hero_Treant.NaturesGuise.On", self:GetCaster() )
end

if IsClient() then require("abilities") end
Abilities.Initialize( 
	treant_special_attack,
	{ activity = ACT_DOTA_ATTACK2, rate = 1.0 },
	{ movement_speed = 10, fixed_range = 1 }
)