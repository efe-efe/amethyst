modifier_juggernaut_extra_shield = class({})

function modifier_juggernaut_extra_shield:GetStatusLabel() return "Totem Shield" end
function modifier_juggernaut_extra_shield:GetStatusPriority() return 3 end
function modifier_juggernaut_extra_shield:GetStatusStyle() return "Shield" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_juggernaut_extra_shield)
Modifiers.Shield(modifier_juggernaut_extra_shield)