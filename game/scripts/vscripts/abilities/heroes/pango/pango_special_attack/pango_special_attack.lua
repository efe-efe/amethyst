pango_special_attack = class({})
LinkLuaModifier("modifier_pango_special_attack_displacement", "abilities/heroes/pango/pango_special_attack/modifier_pango_special_attack_displacement", LUA_MODIFIER_MOTION_BOTH)


function pango_special_attack:GetCastAnimationCustom()		return ACT_DOTA_FORCESTAFF_END end
function pango_special_attack:GetPlaybackRateOverride() 	    return 0.5 end

function pango_special_attack:GetCastPointSpeed()
    return 20
end

function pango_special_attack:GetCastRange(vLocation, hTarget)
    if self:GetCaster():HasModifier("modifier_pango_mobility") then
        return self.BaseClass.GetCastRange(self, vLocation, hTarget) * 1.2
    end
    return self.BaseClass.GetCastRange(self, vLocation, hTarget)
end

function pango_special_attack:GetCastPoint()
    if self:GetCaster():HasModifier("modifier_pango_mobility") then
        return 0.0
    end
    return self.BaseClass.GetCastPoint(self)
end


function pango_special_attack:HasPriority()
    return true
end

function pango_special_attack:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	local point = CustomAbilitiesLegacy:GetCursorPosition(self)

	local direction = (point - origin):Normalized()
    local distance = self:GetCastRange(Vector(0,0,0), nil)
    local air_time = 0.4

    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_pango_special_attack_displacement", -- modifier name
        {
            x = direction.x,
            y = direction.y,
            r = distance,
            speed = distance/air_time,
            peak = 250,
        }
    )
    
    local modifier_pango_mobility = CustomEntitiesLegacy:SafeGetModifier(caster, "modifier_pango_mobility")
    if modifier_pango_mobility then
        modifier_pango_mobility:SetDuration(modifier_pango_mobility:GetRemainingTime() + air_time, true)
    end

    EmitSoundOn("Hero_Pangolier.TailThump.Cast", caster)
end

function pango_special_attack:Crash(iRadius)
    local caster = self:GetCaster()
    local origin = caster:GetAbsOrigin()
    local damage_block = self:GetSpecialValueFor("damage_block")
    local shield_duration = self:GetSpecialValueFor("duration")
    local shield_providers = 0
    local damage_table = {
        attacker = caster,
        damage = self:GetSpecialValueFor("ability_damage"),
        damage_type = DAMAGE_TYPE_PURE,
    }
	ApplyCallbackForUnitsInArea(caster, origin, iRadius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)
		damage_table.victim = unit
		ApplyDamage(damage_table)

		if not CustomEntitiesLegacy:IsObstacle(unit) then
			shield_providers = shield_providers + 1
		end
	end)

	if shield_providers ~= 0 then
		caster:AddNewModifier(caster, self, "modifier_shield", { duration = shield_duration, damage_block = damage_block * shield_providers })
	end

	EFX("particles/units/heroes/hero_pangolier/pangolier_tailthump.vpcf", PATTACH_WORLDORIGIN, nil, {
		cp0 = origin
	})
	CreateRadiusMarker(caster, origin, iRadius, RADIUS_SCOPE_PUBLIC, 0.1)
	EmitSoundOn("Hero_Pangolier.TailThump", caster)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(pango_special_attack)