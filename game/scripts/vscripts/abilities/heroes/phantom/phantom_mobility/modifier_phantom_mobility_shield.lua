modifier_phantom_mobility_shield = class({})

function modifier_phantom_mobility_shield:GetStatusLabel() return "Dash Shield" end
function modifier_phantom_mobility_shield:GetStatusPriority() return 3 end
function modifier_phantom_mobility_shield:GetStatusStyle() return "Shield" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_phantom_mobility_shield)
Modifiers.Shield(modifier_phantom_mobility_shield)