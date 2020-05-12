item_energy_custom = class({})
LinkLuaModifier( "modifier_item_energy_custom", "items/item_energy_custom/modifier_item_energy_custom", LUA_MODIFIER_MOTION_HORIZONTAL )

function item_energy_custom:GetIntrinsicModifierName()
    return "modifier_item_energy_custom"
end