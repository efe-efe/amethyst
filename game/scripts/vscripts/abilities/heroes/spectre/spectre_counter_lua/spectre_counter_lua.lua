spectre_counter_lua = class({})
LinkLuaModifier( "modifier_spectre_counter_lua", "abilities/heroes/spectre/spectre_counter_lua/modifier_spectre_counter_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function spectre_counter_lua:OnSpellStart()
    local caster = self:GetCaster()
	local duration = self:GetDuration()

    caster:AddNewModifier(
        caster,
        self,
        "modifier_spectre_counter_lua",
        {duration = duration}
    )
end