storm_counter = class({})
LinkLuaModifier("modifier_storm_counter_countering", "abilities/heroes/storm/storm_counter/modifier_storm_counter_countering", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_storm_counter_displacement", "abilities/heroes/storm/storm_counter/modifier_storm_counter_displacement", LUA_MODIFIER_MOTION_BOTH)

function storm_counter:OnSpellStart()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("counter_duration")
    
    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_storm_counter_countering", -- modifier name
        { duration = duration }
    )
end

