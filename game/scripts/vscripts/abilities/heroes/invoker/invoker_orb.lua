invoker_orb = class({})
LinkLuaModifier("modifier_invoker_orb", "abilities/heroes/invoker/modifier_invoker_orb", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_invoker_orb_quas", "abilities/heroes/invoker/modifier_invoker_orb", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_invoker_orb_exort", "abilities/heroes/invoker/modifier_invoker_orb", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_invoker_orb_wex", "abilities/heroes/invoker/modifier_invoker_orb", LUA_MODIFIER_MOTION_NONE)

function invoker_orb:CastFilterResult()
    local charges = self:GetCurrentCharges()

    if charges <= 0 then
        return UF_FAIL_CUSTOM
    end
	return UF_SUCCESS
end

function invoker_orb:GetCustomCastError()
    return "Not orb charges"
end

function invoker_orb:OnSpellStart()
    self:DecrementCharges()
    local caster = self:GetCaster()
    
    caster:AddNewModifier(caster, self, self:GetModifierName(), {})

    if RandomInt(0, 1) == 0 then
        caster:StartGestureWithPlaybackRate(ACT_DOTA_OVERRIDE_ABILITY_1, 1.0)
    else
        caster:StartGestureWithPlaybackRate(ACT_DOTA_OVERRIDE_ABILITY_2, 1.0)
    end
end

function invoker_orb:GetCurrentCharges()
    return self:GetCaster():FindModifierByName("modifier_invoker_helper"):GetStackCount()
end

function invoker_orb:DecrementCharges()
    return self:GetCaster():FindModifierByName("modifier_invoker_helper"):RemoveCharge()
end

function invoker_orb:GetModifierName()
    return ""
end

invoker_counter = class(invoker_orb)
invoker_special_attack = class(invoker_orb)
invoker_ultimate = class(invoker_orb)

function invoker_counter:GetModifierName()
    return "modifier_invoker_orb_quas"
end

function invoker_special_attack:GetModifierName()
    return "modifier_invoker_orb_exort"
end

function invoker_ultimate:GetModifierName()
    return "modifier_invoker_orb_wex"
end