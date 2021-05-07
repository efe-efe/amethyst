modifier_item_clarity_custom = class({})

function modifier_item_clarity_custom:OnCreated(params)
    if IsServer() then
        self.think_interval = params.think_interval
        self.mana_per_tick = params.mana_per_tick
        self:StartIntervalThink(self.think_interval)
    end
end

function modifier_item_clarity_custom:OnIntervalThink()
    CustomEntitiesLegacy:GiveManaAndEnergy(self:GetParent(), self.mana_per_tick, true)
end

function modifier_item_clarity_custom:DeclareFunctions()
	return { MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE, }
end

function modifier_item_clarity_custom:GetModifierIncomingDamage_Percentage(params)
	if IsServer() then
		self:Destroy()	
        return 0
	end
end

function modifier_item_clarity_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_item_clarity_custom:GetStatusEffectName()
	return "particles/items_fx/healing_clarity.vpcf"
end

function modifier_item_clarity_custom:GetStatusLabel() return "Clarity Potion" end
function modifier_item_clarity_custom:GetStatusPriority() return 0 end
function modifier_item_clarity_custom:GetStatusStyle() return "Mana" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_item_clarity_custom)
