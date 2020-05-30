modifier_item_soul_custom = class({})

function modifier_item_soul_custom:OnCreated(params)
    if IsServer() then
        local current_mana = params.current_mana
        local max_mana = params.max_mana
        local given_mana = self:GetAbility():GetSpecialValueFor("mana") - self:GetAbility():GetManaCost(-1)
        local missing_mana = max_mana - current_mana

        if missing_mana < given_mana then
            given_mana = missing_mana
        end

        if given_mana <= 0 then
            self:Destroy()
        else
            self:SetStackCount(given_mana)
        end
    end
end

function modifier_item_soul_custom:OnStackCountChanged(iStackCount)
    if self:GetStackCount() <= 0 then
        self:Destroy()
    end
end

function modifier_item_soul_custom:OnDestroy()
    if IsServer() then
        self:GetCaster():ReduceMana(self:GetStackCount())
    end
end

function modifier_item_soul_custom:DeclareFunctions()
	return {
        MODIFIER_EVENT_ON_SPENT_MANA
	}
end

function modifier_item_soul_custom:OnSpentMana(params)
    if params.unit == self:GetCaster() and params.ability ~= self:GetAbility() then
        self:SetStackCount(self:GetStackCount() - params.cost)
    end
end


function modifier_item_soul_custom:GetStatusLabel() return "Sacrifice" end
function modifier_item_soul_custom:GetStatusPriority() return 1 end
function modifier_item_soul_custom:GetStatusStyle() return "Sacrifice" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_item_soul_custom)