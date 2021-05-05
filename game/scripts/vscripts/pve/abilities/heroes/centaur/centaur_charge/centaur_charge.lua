centaur_charge = class({})
LinkLuaModifier("modifier_centaur_charge_displacement", "pve/abilities/heroes/centaur/centaur_charge/modifier_centaur_charge_displacement", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_centaur_charge_knockback_displacement", "pve/abilities/heroes/centaur/centaur_charge/modifier_centaur_charge_knockback_displacement", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_centaur_debuff", "pve/abilities/heroes/centaur/centaur_charge/modifier_centaur_debuff", LUA_MODIFIER_MOTION_NONE)


function centaur_charge:GetCastAnimationCustom()		return ACT_DOTA_CENTAUR_STAMPEDE end 
function centaur_charge:GetPlaybackRateOverride()       return 2.0 end
function centaur_charge:GetCastPointSpeed() 			return 0 end

function centaur_charge:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	local point = self:GetCursorPosition()
    local direction = (point - origin):Normalized()

    CustomEntities:FullyFaceTowards(caster, direction)
    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_centaur_charge_displacement", -- modifier name
        {
            x = direction.x,
            y = direction.y,
            r = self:GetCastRange(Vector(0,0,0), nil),
            speed = 1200,
            peak = 30,
        }
   )

    self:PlayEffectsOnCast()
end

function centaur_charge:PlayEffectsOnCast()
    EmitSoundOn("Hero_Centaur.Stampede.Cast", self:GetCaster())

    local effect_cast = ParticleManager:CreateParticle("particles/blink_purple.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())

    ParticleManager:ReleaseParticleIndex(effect_cast)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(centaur_charge)