invoker_helper = class({})
LinkLuaModifier("modifier_invoker_helper", "abilities/heroes/invoker/modifier_invoker_helper", LUA_MODIFIER_MOTION_NONE)

function invoker_helper:GetIntrinsicModifierName()
    return "modifier_invoker_helper"
end