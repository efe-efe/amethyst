item_vitality_custom = class({})
LinkLuaModifier( "modifier_item_vitality_custom", "items/item_vitality_custom/modifier_item_vitality_custom", LUA_MODIFIER_MOTION_HORIZONTAL )

function item_vitality_custom:GetIntrinsicModifierName()
    return "modifier_item_vitality_custom"
end