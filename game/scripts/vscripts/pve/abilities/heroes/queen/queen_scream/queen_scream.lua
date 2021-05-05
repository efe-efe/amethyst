queen_scream = class({})
LinkLuaModifier("modifier_queen_scream", "pve/abilities/heroes/queen/queen_scream/modifier_queen_scream", LUA_MODIFIER_MOTION_NONE)

function queen_scream:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_3 end
function queen_scream:GetPlaybackRateOverride()    return 0.8 end
function queen_scream:GetCastPointSpeed() 			return 0 end

function queen_scream:OnSpellStart()
    local caster = self:GetCaster()
    local screams = 3
    
    caster:AddNewModifier(
        caster, 
        self, 
        "modifier_queen_scream", 
        { screams = screams }
    )
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(queen_scream)
