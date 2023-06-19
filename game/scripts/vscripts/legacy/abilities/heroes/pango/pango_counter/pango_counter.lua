pango_counter = class({})
LinkLuaModifier("modifier_pango_counter_countering", "abilities/heroes/pango/pango_counter/modifier_pango_counter_countering", LUA_MODIFIER_MOTION_NONE)

function pango_counter:OnSpellStart()
    local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("counter_duration")

    caster:AddNewModifier(
		caster,
		self,
        "modifier_pango_counter_countering", 
		{ duration = duration }
	)
end