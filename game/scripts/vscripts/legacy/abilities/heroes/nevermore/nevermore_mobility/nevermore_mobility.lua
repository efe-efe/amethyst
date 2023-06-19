nevermore_mobility = class({})
LinkLuaModifier("modifier_nevermore_mobility_hit", "abilities/heroes/nevermore/nevermore_mobility/modifier_nevermore_mobility_hit", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_mobility_displacement", "abilities/heroes/nevermore/nevermore_mobility/modifier_nevermore_mobility_displacement", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_nevermore_souls", "abilities/heroes/nevermore/nevermore_shared_modifiers/modifier_nevermore_souls", LUA_MODIFIER_MOTION_NONE)

function nevermore_mobility:GetCastAnimationCustom()		return ACT_DOTA_RAZE_1 end
function nevermore_mobility:GetPlaybackRateOverride() 		return 1.1 end
function nevermore_mobility:GetCastPointSpeed() 			return 0 end

function nevermore_mobility:OnSpellStart()
    local caster = self:GetCaster()
    local origin = caster:GetAbsOrigin()

    local min_range = self:GetSpecialValueFor("min_range")
	local point = ClampPosition(origin, CustomAbilitiesLegacy:GetCursorPosition(self), self:GetCastRange(Vector(0,0,0), nil), min_range)

    local direction = (point - origin):Normalized()
    local distance = (point - origin):Length2D()

    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_nevermore_mobility_displacement", -- modifier name
        {
            x = direction.x,
            y = direction.y,
            r = distance,
            speed = distance/0.4,
            peak = 0,
        }
   )

    self:PlayEffectsOnCast()
end


function nevermore_mobility:PlayEffectsOnCast()
    EmitSoundOn("Hero_Nevermore.Death", self:GetCaster())
end


if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(nevermore_mobility)