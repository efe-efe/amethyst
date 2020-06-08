treant_extra = class({})
LinkLuaModifier("modifier_treant_extra", "abilities/heroes/treant/treant_extra/modifier_treant_extra", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------
function treant_extra:OnCastPointEnd()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
    local point = self:GetCursorPosition()

    local allies = FindUnitsInRadius(
        caster:GetTeamNumber(), -- int, your team number
        point, -- point, center point
        nil, -- handle, cacheUnit. (not known)
        FIND_UNITS_EVERYWHERE, -- float, radius. or use FIND_UNITS_EVERYWHERE
        DOTA_UNIT_TARGET_TEAM_FRIENDLY, -- int, team filter
        DOTA_UNIT_TARGET_HERO,	-- int, type filter
        0, -- int, flag filter
        FIND_CLOSEST, -- int, order filter
        false -- bool, can grow cache
   )

    if #allies > 0 then
        local target = allies[1]
        
        target:AddNewModifier(
            caster,
            self,
            "modifier_treant_extra",
            { duration = duration }
       )

        self:PlayEffectsOnTarget(target)
    end
end

function treant_extra:PlayEffectsOnTarget(target)
    EmitSoundOn("Hero_Treant.LivingArmor.Target", target)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize(
	treant_extra,
	{ activity = ACT_DOTA_ATTACK, rate = 1.0 },
	{ movement_speed = 100 }
)