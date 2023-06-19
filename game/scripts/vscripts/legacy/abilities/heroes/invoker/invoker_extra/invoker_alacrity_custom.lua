invoker_alacrity_custom = class({})
LinkLuaModifier("modifier_invoker_alacrity_custom", "abilities/heroes/invoker/invoker_extra/modifier_invoker_alacrity_custom", LUA_MODIFIER_MOTION_NONE)

function invoker_alacrity_custom:OnSpellStart()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
    caster:AddNewModifier(caster, self, "modifier_invoker_alacrity_custom", { duration = duration })
    
	EmitSoundOn("Hero_Invoker.Alacrity", caster)
end