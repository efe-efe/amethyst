invoker_walk_custom = class({})
LinkLuaModifier("modifier_invoker_walk_custom", "abilities/heroes/invoker/invoker_extra/modifier_invoker_walk_custom", LUA_MODIFIER_MOTION_NONE)

function invoker_walk_custom:GetCastAnimationCustom()		return ACT_DOTA_CAST_GHOST_WALK end
function invoker_walk_custom:GetPlaybackRateOverride() 	    return 1.2 end
function invoker_walk_custom:GetCastPointSpeed() 			return 100 end

function invoker_walk_custom:OnSpellStart()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
    caster:AddNewModifier(caster, self, "modifier_invoker_walk_custom", { duration = duration })
    
    EFX("particles/units/heroes/hero_invoker/invoker_ghost_walk.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster, {
        release = true
    })
	EmitSoundOn("Hero_Invoker.GhostWalk", caster)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(invoker_walk_custom)

