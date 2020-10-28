passive_walk = class({})
LinkLuaModifier("modifier_passive_walk", "abilities/units/dummies/modifier_passive_walk", LUA_MODIFIER_MOTION_NONE)

function passive_walk:GetIntrinsicModifierName()
    return 'modifier_passive_walk'
end