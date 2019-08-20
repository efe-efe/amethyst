sky_ex_ultimate = class({})
LinkLuaModifier( "modifier_sky_ex_ultimate", "abilities/heroes/skywrath_mage/sky_ex_ultimate/modifier_sky_ex_ultimate", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function sky_ex_ultimate:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()

    -- Animation and pseudo cast point
	StartAnimation(caster, {
		duration = cast_point + 0.1, 
		activity = ACT_DOTA_ATTACK, 
		rate = 1.0
	})
	caster:AddNewModifier(
		caster, 
		self, 
		"modifier_generic_pseudo_cast_point", 
		{ 
			duration = cast_point,
		}
	)
end

--------------------------------------------------------------------------------
function sky_ex_ultimate:OnEndPseudoCastPoint( point )
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor( "duration" )

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
            "modifier_sky_ex_ultimate",
            { duration = duration }
        )
    end
end