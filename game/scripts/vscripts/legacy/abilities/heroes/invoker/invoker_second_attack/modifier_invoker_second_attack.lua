modifier_invoker_second_attack = class({})

function modifier_invoker_second_attack:OnCreated(table)
    if IsServer() then
        self.damage_table = {
            victim = self:GetParent(),
            attacker = self:GetCaster(),
            damage = 1,
            damage_type = DAMAGE_TYPE_PURE,
        }
        self:StartIntervalThink(1.0)
    end
end

function modifier_invoker_second_attack:OnIntervalThink()
    ApplyDamage(self.damage_table)
end

function modifier_invoker_second_attack:GetStatusLabel() return "Burning" end
function modifier_invoker_second_attack:GetStatusPriority() return 2 end
function modifier_invoker_second_attack:GetStatusStyle() return "Burning" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_invoker_second_attack)