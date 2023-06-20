modifier_vengeful_extra = class({})

function modifier_vengeful_extra:GetStackeable()
    return true
}

function modifier_vengeful_extra:GetStatusLabel() return "Nether Shield" }
function modifier_vengeful_extra:GetStatusPriority() return 3 }
function modifier_vengeful_extra:GetStatusStyle() return "Shield" }

if(IsClient() ) { require("wrappers/modifiers") }
Modifiers.Status(modifier_vengeful_extra)
Modifiers.Shield(modifier_vengeful_extra)