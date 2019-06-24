spectre_ex_mobility = class({})
LinkLuaModifier( "modifier_spectre_ex_mobility", "abilities/heroes/spectre/spectre_ex_mobility/modifier_spectre_ex_mobility", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function spectre_ex_mobility:OnSpellStart()

    local caster = self:GetCaster()
    local duration = self:GetDuration()

    caster:AddNewModifier(caster, self, "modifier_spectre_ex_mobility", { duration = duration })

    -- Put CD on the alternate version of the ability
    local alternate_version = caster:FindAbilityByName("spectre_mobility")
    alternate_version:StartCooldown(self:GetCooldown(0))
end

