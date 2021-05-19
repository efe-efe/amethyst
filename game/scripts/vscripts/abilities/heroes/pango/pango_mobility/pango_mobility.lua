pango_mobility = class({})
LinkLuaModifier("modifier_pango_mobility", "abilities/heroes/pango/pango_mobility/modifier_pango_mobility", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pango_roll_end_animation", "abilities/heroes/pango/modifier_pango_roll_end_animation", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pango_mobility_displacement", "abilities/heroes/pango/pango_mobility/modifier_pango_mobility_displacement", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_pango_mobility_marker", "abilities/heroes/pango/pango_mobility/modifier_pango_mobility_marker", LUA_MODIFIER_MOTION_BOTH)

function pango_mobility:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_4 end
function pango_mobility:GetPlaybackRateOverride() 	    return 2.0 end
function pango_mobility:GetCastPointSpeed() 			return 80 end

function pango_mobility:OnAbilityPhaseStart()
	self.efx = ParticleManager:CreateParticle('particles/pango/pango_mobility.vpcf', PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControlEnt(self.efx, 1, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, 'attach_hitloc', self:GetCaster():GetAbsOrigin(), false)
    EmitSoundOn("Hero_Pangolier.Gyroshell.Cast", self:GetCaster())
    return true
end

function pango_mobility:OnAbilityPhaseInterrupted()
	DEFX(self.efx, false)
	StopSoundOn("Hero_Pangolier.Gyroshell.Cast", self:GetCaster())
end

function pango_mobility:OnSpellStart()
    DEFX(self.efx, false)
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")

    caster:AddNewModifier(caster, self, "modifier_pango_mobility", { duration = duration })
    StopSoundOn("Hero_Pangolier.Gyroshell.Cast", caster)
    
    if self:GetLevel() >= 2 then
        caster:FindAbilityByName("pango_special_attack"):EndCooldown()
    end
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(pango_mobility)