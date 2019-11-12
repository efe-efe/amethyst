ancient_second_attack = class({})
LinkLuaModifier( "modifier_ancient_second_attack", "abilities/heroes/ancient/ancient_second_attack/modifier_ancient_second_attack", LUA_MODIFIER_MOTION_NONE )

function ancient_second_attack:OnSpellStart()
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_ancient_second_attack", {} )
	EmitSoundOn("ancient_apparition_appa_ability_touch_01", self:GetCaster())
end


function ancient_second_attack:GetCastRange( vLocation, hTarget )
	local stacks = SafeGetModifierStacks("modifier_ancient_second_attack", self:GetCaster(), self:GetCaster())
    return self.BaseClass.GetCastRange(self, vLocation, hTarget) + stacks * 6
end

function ancient_second_attack:OnStopPseudoCastPoint()
	SafeDestroyModifier("modifier_ancient_second_attack", self:GetCaster(), self:GetCaster())
end

--------------------------------------------------------------------------------
-- Ability Start
function ancient_second_attack:OnCastPointEnd()

	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()
	local damage = self:GetSpecialValueFor("ability_damage")
	local name = self:GetAbilityName()
	local stacks = SafeGetModifierStacks("modifier_ancient_second_attack", caster, caster)

	-- load data
    local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	
	-- Dynamic data
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	local projectile = {
		EffectName = 			"particles/mod_units/heroes/hero_ancient/apparition_chilling_touch_projectile.vpcf",
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
			local damage_table = {
				victim = unit,
				attacker = caster,
				damage = damage + stacks/10,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}

			ApplyDamage( damage_table )

			if not string.ends(name, "_ultimate") then
				if _self.Source == caster then
					caster:GiveManaPercent(mana_gain_pct, unit)
				end
			end
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}
	SafeDestroyModifier("modifier_ancient_second_attack", self:GetCaster(), self:GetCaster())

	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

--------------------------------------------------------------------------------
-- Graphics & sounds
function ancient_second_attack:PlayEffectsOnFinish( pos )
	local caster = self:GetCaster()

	EmitSoundOnLocationWithCaster( pos, "Hero_Ancient_Apparition.ChillingTouch.Target", caster )

	-- Create Particles
	local particle_cast = "particles/units/heroes/hero_ancient_apparition/ancient_apparition_chilling_touch_projectile_hit.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, pos )
	ParticleManager:SetParticleControl( effect_cast, 1, pos )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function ancient_second_attack:PlayEffectsOnCast()
	EmitSoundOn( "Hero_Ancient_Apparition.ChillingTouch.Cast", self:GetCaster() )
end

function ancient_second_attack:CastOnRelease() return true end

if IsClient() then require("abilities") end
Abilities.Initialize( 
	ancient_second_attack,
	{ activity = ACT_DOTA_GENERIC_CHANNEL_1, rate = 1.0 },
	{ movement_speed = 80, fixed_range = 1}
)