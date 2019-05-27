spectre_ex_mobility_lua = class({})
LinkLuaModifier( "modifier_spectre_ex_mobility_lua", "abilities/heroes/spectre/spectre_ex_mobility_lua/modifier_spectre_ex_mobility_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function spectre_ex_mobility_lua:OnSpellStart()

    local caster = self:GetCaster()
    local duration = self:GetDuration()

    caster:AddNewModifier(caster, self, "modifier_spectre_ex_mobility_lua", { duration = duration })

    -- Put CD on the non ex version of the ability
    local non_ex_version = caster:FindAbilityByName("spectre_mobility_lua")
    non_ex_version:StartCooldown(self:GetCooldown(0))
end

