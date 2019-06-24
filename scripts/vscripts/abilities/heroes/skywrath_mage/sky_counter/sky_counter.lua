sky_counter = class({})
LinkLuaModifier( "modifier_sky_counter", "abilities/heroes/skywrath_mage/sky_counter/modifier_sky_counter", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function sky_counter:OnSpellStart()
    
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
