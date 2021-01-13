modifier_phantom_counter_shield = class({})

function modifier_phantom_counter_shield:GetStatusLabel() return "Phantom Shield" end
function modifier_phantom_counter_shield:GetStatusPriority() return 3 end
function modifier_phantom_counter_shield:GetStatusStyle() return "Shield" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_phantom_counter_shield)
Modifiers.Shield(modifier_phantom_counter_shield)