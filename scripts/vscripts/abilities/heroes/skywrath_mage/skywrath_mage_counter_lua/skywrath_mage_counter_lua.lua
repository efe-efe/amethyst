skywrath_mage_counter_lua = class({})

LinkLuaModifier( "modifier_skywrath_mage_counter_lua", "abilities/heroes/skywrath_mage/skywrath_mage_counter_lua/modifier_skywrath_mage_counter_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function skywrath_mage_counter_lua:OnSpellStart()
    
    --load data
    local caster = self:GetCaster()
		local duration = self:GetDuration()

    caster:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_skywrath_mage_counter_lua", -- modifier name
			{ duration = duration } -- kv
    )

end
