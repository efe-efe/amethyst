modifier_item_mekansm_custom = class({})

function modifier_item_mekansm_custom:OnCreated()
    self.think_interval = self:GetAbility():GetSpecialValueFor("think_interval")
    self.heal_per_tick = self:GetAbility():GetSpecialValueFor("heal_per_tick")
    
    if IsServer() then
        self:StartIntervalThink(self.think_interval)
    end
end

function modifier_item_mekansm_custom:OnIntervalThink()
    self:GetParent():Heal(self.heal_per_tick, self:GetCaster())
end

function modifier_item_mekansm_custom:GetStatusLabel() return "Mekansm" end
function modifier_item_mekansm_custom:GetStatusPriority() return 3 end
function modifier_item_mekansm_custom:GetStatusStyle() return "Mekansm" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_item_mekansm_custom)