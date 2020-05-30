phantom_counter = class({})
LinkLuaModifier("modifier_phantom_counter_banish", "abilities/heroes/phantom/phantom_counter/modifier_phantom_counter_banish", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phantom_counter_countering", "abilities/heroes/phantom/phantom_counter/modifier_phantom_counter_countering", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phantom_counter", "abilities/heroes/phantom/phantom_counter/modifier_phantom_counter", LUA_MODIFIER_MOTION_NONE)

function phantom_counter:OnSpellStart()
    local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("counter_duration")

    caster:AddNewModifier(
		caster,
		self,
        "modifier_phantom_counter_countering", 
		{ duration = duration }
    )
end