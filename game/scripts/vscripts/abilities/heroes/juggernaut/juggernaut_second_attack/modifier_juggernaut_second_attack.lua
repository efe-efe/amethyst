modifier_juggernaut_second_attack = class({})

function modifier_juggernaut_second_attack:GetStatusLabel() return "Blade Shield" end
function modifier_juggernaut_second_attack:GetStatusPriority() return 3 end
function modifier_juggernaut_second_attack:GetStatusStyle() return "Shield" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_juggernaut_second_attack)
Modifiers.Shield(modifier_juggernaut_second_attack)
