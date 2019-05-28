phantom_assassin_counter_lua = class({})
LinkLuaModifier( "modifier_phantom_assassin_counter_lua", "abilities/heroes/phantom_assassin/phantom_assassin_counter_lua/modifier_phantom_assassin_counter_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function phantom_assassin_counter_lua:OnSpellStart()
    
	--load data
  local caster = self:GetCaster()
	local duration = self:GetDuration()

    caster:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_phantom_assassin_counter_lua", -- modifier name
			{ duration = duration } -- kv
    )
end
