phantom_extra = class({})
LinkLuaModifier("modifier_phantom_extra_displacement", "abilities/heroes/phantom/phantom_extra/modifier_phantom_extra_displacement", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_phantom_extra", "abilities/heroes/phantom/phantom_extra/modifier_phantom_extra", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phantom_extra_recast", "abilities/heroes/phantom/phantom_extra/modifier_phantom_extra_recast", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phantom_extra_slashes", "abilities/heroes/phantom/phantom_extra/modifier_phantom_extra_slashes", LUA_MODIFIER_MOTION_NONE)

function phantom_extra:GetCastAnimationCustom()		return ACT_DOTA_ATTACK_EVENT end
function phantom_extra:GetPlaybackRateOverride()    return 0.7 end
function phantom_extra:GetCastPointSpeed() 			return 0 end

function phantom_extra:GetManaCost(iLevel)
    if self:GetCaster():HasModifier('modifier_phantom_extra_recast') then
        return 0
    end
    return self.BaseClass.GetManaCost( self, iLevel )
end

function phantom_extra:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	local point = CustomAbilitiesLegacy:GetCursorPosition(self)

	local direction = (point - origin):Normalized()
    local distance = self:GetCastRange(Vector(0,0,0), nil)

    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_phantom_extra_displacement", -- modifier name
        {
            x = direction.x,
            y = direction.y,
            r = distance,
            speed = distance/0.20,
            peak = 30,
        }
   )

    self:PlayEffectsOnCast()
end

function phantom_extra:PlayEffectsOnCast()
    EmitSoundOn("Hero_PhantomAssassin.Strike.Start", self:GetCaster())
    local effect_cast = ParticleManager:CreateParticle("particles/blink_purple.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:ReleaseParticleIndex(effect_cast)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(phantom_extra)