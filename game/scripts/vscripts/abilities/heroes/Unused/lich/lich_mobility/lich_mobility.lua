lich_mobility = class({})

LinkLuaModifier( "modifier_lich_mobility", "abilities/heroes/lich/lich_mobility/modifier_lich_mobility", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
function lich_mobility:OnCastPointEnd()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor( "duration" )
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
            "modifier_lich_mobility",
            { duration = duration }
        )

        self:PlayEffectsOnTarget(target)
    end
end

function lich_mobility:PlayEffectsOnTarget( target )
    EmitSoundOn("Hero_Lich.IceAge", target)
end


if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	lich_mobility,
	{ activity = ACT_DOTA_ATTACK, rate = 1.0 },
	{ movement_speed = 100 }
)