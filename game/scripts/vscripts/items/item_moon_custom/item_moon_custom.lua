item_moon_custom = class({})
LinkLuaModifier("modifier_item_moon_custom", "items/item_moon_custom/modifier_item_moon_custom", LUA_MODIFIER_MOTION_HORIZONTAL)

function item_moon_custom:GetIntrinsicModifierName()
    return "modifier_item_moon_custom"
end