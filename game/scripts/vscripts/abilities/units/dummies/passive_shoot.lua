passive_shoot = class({})
LinkLuaModifier("modifier_passive_shoot", "abilities/units/dummies/modifier_passive_shoot", LUA_MODIFIER_MOTION_NONE)

function passive_shoot:GetIntrinsicModifierName()
    return 'modifier_passive_shoot'
end