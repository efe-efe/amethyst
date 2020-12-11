modifier_phantom_bleed = class({})

function modifier_phantom_bleed:OnCreated(params)
    if IsServer() then
        self.bleed_damage_per_stack = 1
		self.max_stacks = 3
		local interval_time = 1.0
		
		self.damage_table = {
            victim = self:GetParent(),
			attacker = self:GetCaster(),
			damage_type = DAMAGE_TYPE_PURE,
		}

        self:SetStackCount(1)
        self:OnIntervalThink()
        self:StartIntervalThink(interval_time)
	end
end

function modifier_phantom_bleed:OnRefresh(params)
	if IsServer() then
		if self:GetStackCount() < self.max_stacks then
			self:IncrementStackCount()
		end
	end
end

function modifier_phantom_bleed:OnIntervalThink()
    self.damage_table.damage = self.bleed_damage_per_stack * self:GetStackCount()
    ApplyDamage(self.damage_table)
end

function modifier_phantom_bleed:GetStatusLabel() return "Bleeding" end
function modifier_phantom_bleed:GetStatusPriority() return 3 end
function modifier_phantom_bleed:GetStatusStyle() return "Bleeding" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_phantom_bleed)