spectre_extra = class({})
spectre_extra_recast = class({})
LinkLuaModifier("modifier_spectre_extra", "abilities/heroes/spectre/spectre_extra/modifier_spectre_extra", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spectre_debuff", "abilities/heroes/spectre/spectre_extra/modifier_spectre_debuff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spectre_extra_recast", "abilities/heroes/spectre/spectre_extra/modifier_spectre_extra_recast", LUA_MODIFIER_MOTION_NONE)

function spectre_extra:OnSpellStart()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
	caster:FindAbilityByName('spectre_extra_recast'):ResetDamage()

    caster:AddNewModifier(caster, self, "modifier_spectre_extra", { duration = duration })
end

function spectre_extra_recast:GetCastAnimationCustom()     return ACT_DOTA_CAST_ABILITY_1 end
function spectre_extra_recast:GetPlaybackRateOverride()    return 1.0 end
function spectre_extra_recast:GetCastPointSpeed() 			return 80 end
function spectre_extra_recast:GetIgnoreActivationCycle()   return true end

function spectre_extra_recast:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()

	local spectre_extra = caster:FindAbilityByName('spectre_extra')
	local damage = spectre_extra:GetSpecialValueFor("recast_damage")
	local max_damage = spectre_extra:GetSpecialValueFor("max_damage")

	if self.extra_damage then
		damage = Clamp(damage + self.extra_damage, max_damage, 0)
	end
	
	local projectile_direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	local projectile = {
        EffectName =			"particles/spectre/spectre_extra_recast.vpcf",
		vSpawnOrigin = 			origin + Vector(projectile_direction.x * 45, projectile_direction.y * 45, 96),
		fDistance = 			self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fStartRadius =			self:GetSpecialValueFor("hitbox"),
		Source = 				caster,
		vVelocity = 			projectile_direction * projectile_speed,
		UnitBehavior = 			PROJECTILES_DESTROY,
		WallBehavior = 			PROJECTILES_DESTROY,
		TreeBehavior = 			PROJECTILES_NOTHING,
		GroundBehavior = 		PROJECTILES_NOTHING,
		fGroundOffset = 		0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit) 
			local damage_table = {
				victim = unit,
				attacker = caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}

			ApplyDamage(damage_table)
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end
	}

	EmitSoundOn("Hero_Nevermore.Raze_Flames", caster)
	Projectiles:CreateProjectile(projectile)
end

function spectre_extra_recast:PlayEffectsOnFinish(vOrigin)
	EFX('particles/units/heroes/hero_arc_warden/arc_warden_wraith_cast.vpcf', PATTACH_WORLDORIGIN, self:GetCaster(), {
		cp0 = vOrigin,
		cp1 = vOrigin,
		cp2 = vOrigin,
		release = true,
	})
end

function spectre_extra_recast:AddDamage(iDamage)
	if self.extra_damage == nil then
		self.extra_damage = 0
	end
	self.extra_damage = self.extra_damage + iDamage
end

function spectre_extra_recast:ResetDamage()
	self.extra_damage = 0
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(spectre_extra_recast)