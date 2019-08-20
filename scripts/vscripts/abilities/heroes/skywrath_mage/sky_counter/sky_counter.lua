sky_counter = class({})
LinkLuaModifier( "modifier_sky_counter", "abilities/heroes/skywrath_mage/sky_counter/modifier_sky_counter", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function sky_counter:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()

	-- Animation and pseudo cast point
	StartAnimation(caster, { 
        duration = cast_point + self:GetDuration() + 0.1, 
        activity = ACT_DOTA_TELEPORT, 
        rate = 1.0
    })
	caster:AddNewModifier(
        caster, 
        self,
        "modifier_generic_pseudo_cast_point", 
        {
            duration = cast_point,
            can_walk = 0,
        }
    )
end


--------------------------------------------------------------------------------
-- Ability Start
function sky_counter:OnEndPseudoCastPoint( point )
    
    --load data
    local caster = self:GetCaster()
	local duration = self:GetDuration()

    caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_sky_counter", -- modifier name
		{ duration = duration } -- kv
    )
end
