spectre_extra = class({})
LinkLuaModifier("modifier_spectre_extra", "abilities/heroes/spectre/spectre_extra/modifier_spectre_extra", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spectre_debuff", "abilities/heroes/spectre/spectre_extra/modifier_spectre_debuff", LUA_MODIFIER_MOTION_NONE)

function spectre_extra:OnSpellStart()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")

    caster:AddNewModifier(caster, self, "modifier_spectre_extra", { duration = duration })
end
