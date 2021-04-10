centaur_charge = class({})
LinkLuaModifier("modifier_centaur_charge_displacement", "abilities/heroes/centaur/centaur_charge/modifier_centaur_charge_displacement", LUA_MODIFIER_MOTION_BOTH)

function centaur_charge:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_1 end 
function centaur_charge:GetPlaybackRateOverride()       return 1.0 end
function centaur_charge:GetCastPointSpeed() 			return 100 end

function centaur_charge:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	local point = self:GetCursorPosition()

	local direction = (point - origin):Normalized()
    local distance = self:GetCastRange(Vector(0,0,0), nil)

    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_centaur_charge_displacement", -- modifier name
        {
            x = direction.x,
            y = direction.y,
            r = distance,
            speed = distance/1.0,
            peak = 30,
        }
   )

    self:PlayEffectsOnCast()
end

function centaur_charge:PlayEffectsOnCast()
    EmitSoundOn("Hero_PhantomAssassin.Strike.Start", self:GetCaster())

    local effect_cast = ParticleManager:CreateParticle("particles/blink_purple.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())

    ParticleManager:ReleaseParticleIndex(effect_cast)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(centaur_charge)