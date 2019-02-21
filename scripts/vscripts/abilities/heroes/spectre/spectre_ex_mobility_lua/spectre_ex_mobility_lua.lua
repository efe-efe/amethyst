spectre_ex_mobility_lua = class({})
LinkLuaModifier( "modifier_spectre_ex_mobility_lua", "abilities/heroes/spectre/spectre_ex_mobility_lua/modifier_spectre_ex_mobility_lua", LUA_MODIFIER_MOTION_NONE )

-- This function is used to change between abilities and ex abilities
--------------------------------------------------------------------------------
function spectre_ex_mobility_lua:GetRelatedName()
    return "spectre_mobility_lua"
end

--------------------------------------------------------------------------------
-- Ability Start
function spectre_ex_mobility_lua:OnSpellStart()

    local caster = self:GetCaster()

    caster:AddNewModifier(caster, self, "modifier_spectre_ex_mobility_lua", { duration = 10.0 })
end

