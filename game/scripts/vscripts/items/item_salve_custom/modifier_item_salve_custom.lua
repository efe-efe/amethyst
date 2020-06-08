modifier_item_salve_custom = class({})

function modifier_item_salve_custom:OnCreated(params)
    if IsServer() then
        self.think_interval = params.think_interval
        self.heal_per_tick = params.heal_per_tick
        self:StartIntervalThink(self.think_interval)
    end
end

function modifier_item_salve_custom:OnIntervalThink()
    self:GetParent():Heal(self.heal_per_tick, self:GetCaster())
end

function modifier_item_salve_custom:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}

	return funcs
end

function modifier_item_salve_custom:GetModifierIncomingDamage_Percentage(params)
	if IsServer() then
		self:Destroy()	
        return 0
	end
end

function modifier_item_salve_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_item_salve_custom:GetStatusEffectName()
	return "particles/items_fx/healing_flask.vpcf"
end

function modifier_item_salve_custom:GetStatusLabel() return "Healing Salve" end
function modifier_item_salve_custom:GetStatusPriority() return 1 end
function modifier_item_salve_custom:GetStatusStyle() return "Heal" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_item_salve_custom)
