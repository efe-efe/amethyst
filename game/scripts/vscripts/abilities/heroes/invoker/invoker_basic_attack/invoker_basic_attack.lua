invoker_basic_attack = class({})
LinkLuaModifier("modifier_invoker_basic_attack", "abilities/heroes/invoker/invoker_basic_attack/modifier_invoker_basic_attack", LUA_MODIFIER_MOTION_NONE)

function invoker_basic_attack:GetIntrinsicModifierName()
    return "modifier_invoker_basic_attack"
end

function invoker_basic_attack:OnSpellStart()
    for i = 0, 23 do
        local ability = self:GetCaster():GetAbilityByIndex(i)
        if ability then
            print(ability:GetName(), i)
        end
    end

end
