centaur_rage = class({})

LinkLuaModifier("modifier_centaur_rage_channeling", "pve/abilities/heroes/centaur/centaur_rage/modifier_centaur_rage_channeling", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_centaur_rage_thinker", "pve/abilities/heroes/centaur/centaur_rage/modifier_centaur_rage_thinker", LUA_MODIFIER_MOTION_NONE)

function centaur_rage:GetCastAnimationCustom()		return ACT_DOTA_CENTAUR_STAMPEDE end
function centaur_rage:GetPlaybackRateOverride()     return 1.5 end
function centaur_rage:GetCastPointSpeed() 			return 0 end

function centaur_rage:OnSpellStart()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
    
    caster:AddNewModifier(
        caster, 
        self, 
        "modifier_centaur_rage_channeling", 
        { duration = duration }
    ) 
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(centaur_rage)