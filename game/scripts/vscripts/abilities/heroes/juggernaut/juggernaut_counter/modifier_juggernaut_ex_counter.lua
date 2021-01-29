modifier_juggernaut_ex_counter = class({})

function modifier_juggernaut_ex_counter:OnCreated(kv)
	if IsServer() then
		self:SetStackCount(1)
	end
end

function modifier_juggernaut_ex_counter:OnRefresh(kv)
	if IsServer() then
        self:IncrementStackCount()
	end
end

function modifier_juggernaut_ex_counter:OnStackCountChanged(iStackCount)
    if IsServer() then
        if self:GetStackCount() <= 0 then
            self:Destroy()
        end
	end
end

function modifier_juggernaut_ex_counter:DeclareFunctions()
    return { 
        MODIFIER_EVENT_ON_ATTACK,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
    }
end

function modifier_juggernaut_ex_counter:OnEvent(params)
    if params.iEventId == MODIFIER_EVENTS.ON_BASIC_ATTACK_LANDED or params.iEventId == MODIFIER_EVENTS.ON_BASIC_ATTACK_MISSED then
        self:DecrementStackCount()
    end
end
 
function modifier_juggernaut_ex_counter:GetModifierPreAttack_BonusDamage(event)
	return self:GetAbility():GetSpecialValueFor("extra_damage")
end

function modifier_juggernaut_ex_counter:GetTexture()
	return "modifier_juggernaut_ex_counter"
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.OnEvent(modifier_juggernaut_ex_counter)