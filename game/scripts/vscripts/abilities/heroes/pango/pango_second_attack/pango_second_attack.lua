pango_second_attack = class({})
LinkLuaModifier("modifier_pango_second_attack_displacement", "abilities/heroes/pango/pango_second_attack/modifier_pango_second_attack_displacement", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_pango_second_attack_thinker", "abilities/heroes/pango/pango_second_attack/modifier_pango_second_attack_thinker", LUA_MODIFIER_MOTION_BOTH)

function pango_second_attack:GetCastAnimationCustom()		return ACT_DOTA_TELEPORT_END end 
function pango_second_attack:GetPlaybackRateOverride() 		return 2.0 end
function pango_second_attack:GetCastPointSpeed() 			return 80 end
function pango_second_attack:GetFadeGestureOnCast()			return false end

function pango_second_attack:OnSpellStart()
    local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	local point = self:GetCursorPosition()
    local distance = self:GetCastRange(Vector(0,0,0), nil)
    local direction = (point - origin):Normalized()

    if caster:GetDirection().x ~= 0 or caster:GetDirection().y ~=0 then
        direction = caster:GetDirection()
    else 
        distance = 1
    end

	self:Start(direction, distance)
end

function pango_second_attack:Start(vDirection, iDistance)
    local caster = self:GetCaster()

    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_pango_second_attack_displacement", -- modifier name
        {
            x = vDirection.x,
            y = vDirection.y,
            r = iDistance,
            speed = iDistance/0.2,
            peak = 1,
        }
    )
    EmitSoundOn("Hero_Pangolier.Swashbuckle.Cast", caster)
end


function pango_second_attack:Cut(vOrigin, vDirection, iDistance)
    local caster = self:GetCaster()
    local point = vOrigin + (vDirection * iDistance)

    CreateModifierThinker(
        caster,
        self,
        "modifier_pango_second_attack_thinker",
        {
            x = point.x,
            y = point.y
        },
        vOrigin,
        caster:GetTeamNumber(),
        false
    )
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(pango_second_attack)