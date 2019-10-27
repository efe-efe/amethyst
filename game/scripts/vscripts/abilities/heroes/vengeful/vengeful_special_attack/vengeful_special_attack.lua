vengeful_special_attack = class({})
vengeful_special_attack_ultimate = class({})
LinkLuaModifier( "modifier_vengeful_special_attack_link", "abilities/heroes/vengeful/vengeful_special_attack/modifier_vengeful_special_attack_link", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_vengeful_special_attack_link_ultimate", "abilities/heroes/vengeful/vengeful_special_attack/modifier_vengeful_special_attack_link", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function vengeful_special_attack:OnCastPointEnd()
	local caster = self:GetCaster()
	local ability = caster:FindAbilityByName("vengeful_special_attack")
	local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()
	local damage = ability:GetSpecialValueFor("ability_damage")

	-- load data
    local mana_gain_pct = ability:GetSpecialValueFor("mana_gain_pct")
	local link_duration = ability:GetSpecialValueFor("link_duration")
	
	-- Dynamic data
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()
	local projectile_speed = ability:GetSpecialValueFor("projectile_speed")

	local projectile = {
		EffectName = 			"particles/mod_units/heroes/hero_venge/vengeful_magic_missle.vpcf",
		vSpawnOrigin = 			caster:GetAbsOrigin() + Vector(0,0,80),
		fDistance = 			ability:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fUniqueRadius =			ability:GetSpecialValueFor("hitbox"),
		Source = 				caster,
		vVelocity = 			projectile_direction * projectile_speed,
		UnitBehavior = 			PROJECTILES_DESTROY,
		WallBehavior = 			PROJECTILES_NOTHING,
		TreeBehavior = 			PROJECTILES_NOTHING,
		GroundBehavior = 		PROJECTILES_NOTHING,
		fGroundOffset = 		80,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and unit:GetTeamNumber() ~= _self.Source:GetTeamNumber() end,
		OnUnitHit = function(_self, unit) 
			local damage_table = {
				victim = unit,
				attacker = caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}

			ApplyDamage( damage_table )

			if not string.ends(self:GetAbilityName(), "_ultimate") then
				if _self.Source == caster then
					caster:GiveManaPercent(mana_gain_pct, unit)
				end
			end
			local modifier_name = string.ends(self:GetAbilityName(), "_ultimate") and
            "modifier_vengeful_special_attack_link_ultimate" or 
			"modifier_vengeful_special_attack_link"
			
            unit:AddNewModifier(_self.Source, self, modifier_name, { duration = link_duration })
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}

	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

--------------------------------------------------------------------------------
-- Graphics & sounds

function vengeful_special_attack:PlayEffectsOnFinish( pos )
	local caster = self:GetCaster()

	EmitSoundOnLocationWithCaster( pos, "Hero_VengefulSpirit.MagicMissileImpact", caster )

	-- Create Particles
	local particle_cast = "particles/units/heroes/hero_vengeful/vengeful_magic_missle_end.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function vengeful_special_attack:PlayEffectsOnCast()
	EmitSoundOn( "Hero_VengefulSpirit.MagicMissile", self:GetCaster() )
end

vengeful_special_attack_ultimate.OnCastPointEnd = vengeful_special_attack.OnCastPointEnd
vengeful_special_attack_ultimate.PlayEffectsOnFinish = vengeful_special_attack.PlayEffectsOnFinish
vengeful_special_attack_ultimate.PlayEffectsOnCast = vengeful_special_attack.PlayEffectsOnCast

if IsClient() then require("abilities") end
Abilities.Initialize( 
	vengeful_special_attack,
	{ activity = ACT_DOTA_CAST_ABILITY_1, rate = 1.0 },
	{ movement_speed = 0, fixed_range = 1}
)
if IsClient() then require("abilities") end
Abilities.Initialize( 
	vengeful_special_attack_ultimate,
	{ activity = ACT_DOTA_CAST_ABILITY_1, rate = 1.0 },
	{ movement_speed = 0, fixed_range = 1}
)