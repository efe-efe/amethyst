modifier_upgrade_item_broom_handle = class({})

function modifier_upgrade_item_broom_handle:RemoveOnDeath() return false end
function modifier_upgrade_item_broom_handle:IsPurgable() return false end

function modifier_upgrade_item_broom_handle:GetExtraRadius()
    return 95
end

function modifier_upgrade_item_broom_handle:GetTexture()
    return 'item_broom_handle'
end