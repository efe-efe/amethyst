modifier_vengeful_extra = class({})

function modifier_vengeful_extra:GetStackeable()
    return true
end

function modifier_vengeful_extra:GetStatusLabel() return "Nether Shield" end
function modifier_vengeful_extra:GetStatusPriority() return 3 end
function modifier_vengeful_extra:GetStatusStyle() return "Shield" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_vengeful_extra)
Modifiers.Shield(modifier_vengeful_extra)