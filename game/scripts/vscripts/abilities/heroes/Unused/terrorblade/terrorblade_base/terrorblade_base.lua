terrorblade_base = class({})
LinkLuaModifier("modifier_terrorblade_base", "abilities/heroes/terrorblade/terrorblade_base/modifier_terrorblade_base", LUA_MODIFIER_MOTION_NONE)

function terrorblade_base:GetIntrinsicModifierName()
    return "modifier_terrorblade_base"
end