
modifier_puck_ex_basic_attack_shield = class({})

function modifier_puck_ex_basic_attack_shield:GetStatusLabel() return "Fairy Shield" end
function modifier_puck_ex_basic_attack_shield:GetStatusPriority() return 3 end
function modifier_puck_ex_basic_attack_shield:GetStatusStyle() return "Shield" end
function modifier_puck_ex_basic_attack_shield:GetStackeable() return true end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_puck_ex_basic_attack_shield)
Modifiers.Shield(modifier_puck_ex_basic_attack_shield)