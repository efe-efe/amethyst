item_boots_custom = class({})
LinkLuaModifier( "modifier_item_boots_custom", "items/item_boots_custom/modifier_item_boots_custom", LUA_MODIFIER_MOTION_HORIZONTAL )

function item_boots_custom:GetIntrinsicModifierName()
    return "modifier_item_boots_custom"
end