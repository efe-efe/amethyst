vengeful_ultimate = class({})
LinkLuaModifier("modifier_vengeful_ultimate", "abilities/heroes/vengeful/vengeful_ultimate/modifier_vengeful_ultimate", LUA_MODIFIER_MOTION_NONE)

function vengeful_ultimate:GetIntrinsicModifierName()
    return "modifier_vengeful_ultimate"
end