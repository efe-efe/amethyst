pango_ultimate = class({})
LinkLuaModifier("modifier_pango_ultimate_displacement", "abilities/heroes/pango/pango_ultimate/modifier_pango_ultimate_displacement", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_pango_mobility_displacement_enemy", "abilities/heroes/pango/pango_ultimate/modifier_pango_mobility_displacement_enemy", LUA_MODIFIER_MOTION_BOTH)

function pango_ultimate:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_4 end
function pango_ultimate:GetPlaybackRateOverride() 	    return 1.0 end
function pango_ultimate:GetCastPointSpeed() 			return 0 end

function pango_ultimate:OnAbilityPhaseStart()
    self.efx = EFX("particles/units/heroes/hero_pangolier/pangolier_gyroshell_cast.vpcf", PATTACH_WORLDORIGIN, nil, {
        cp0 = self:GetCaster():GetAbsOrigin(),
        cp3 = self:GetCaster():GetAbsOrigin(),
        cp5 = self:GetCaster():GetAbsOrigin()
    })
    EmitSoundOn("Hero_Pangolier.Gyroshell.Cast", self:GetCaster())
    return true
end

function pango_ultimate:OnAbilityPhaseInterrupted()
	DEFX(self.efx, false)
	StopSoundOn("Hero_Pangolier.Gyroshell.Cast", self:GetCaster())
end

function pango_ultimate:OnSpellStart()
    DEFX(self.efx, false)
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	local point = self:GetCursorPosition()
	local direction = (point - origin):Normalized()
    local distance = self:GetCastRange(Vector(0,0,0), nil)

    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_pango_ultimate_displacement", -- modifier name
        {
            x = direction.x,
            y = direction.y,
            r = 2000,
            speed = 2500,
            peak = 1,
        }
    )

    EmitSoundOn("Hero_Pangolier.Swashbuckle.Cast", caster)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(pango_ultimate)