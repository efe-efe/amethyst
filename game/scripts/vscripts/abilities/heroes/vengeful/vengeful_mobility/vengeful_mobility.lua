vengeful_mobility = class({})
LinkLuaModifier("modifier_vengeful_mobility_displacement", "abilities/heroes/vengeful/vengeful_mobility/modifier_vengeful_mobility_displacement", LUA_MODIFIER_MOTION_BOTH)

function vengeful_mobility:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_1 end
function vengeful_mobility:GetPlaybackRateOverride() 	return 2.0 end

function vengeful_mobility:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	local min_range = self:GetSpecialValueFor("min_range")
	local point = ClampPosition(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), min_range)

	local direction = (point - origin):Normalized()
	local distance = (point - origin):Length2D()

    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_vengeful_mobility_displacement", -- modifier name
        {
            x = direction.x,
            y = direction.y,
            r = distance,
            speed = (distance/0.3),
			peak = 100,
        }
	)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(vengeful_mobility)