modifier_juggernaut_swiftness = class({})

function modifier_juggernaut_swiftness:IsHidden() 	return 	false 	end
function modifier_juggernaut_swiftness:IsDebuff() 	return 	false 	end
function modifier_juggernaut_swiftness:IsPurgable() 	return 	true 	end

function modifier_juggernaut_swiftness:OnCreated(params)
	self.max_speed_pct = 100
	if IsServer() then
        self:SetStackCount(Clamp(params.swiftness_pct, self.max_speed_pct, 0))
    end
end

function modifier_juggernaut_swiftness:OnRefresh(params)
    if IsServer() then
        self:SetStackCount(Clamp(self:GetStackCount() + params.swiftness_pct, self.max_speed_pct, 0))
    end
end

function modifier_juggernaut_swiftness:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_juggernaut_swiftness:GetModifierMoveSpeedBonus_Percentage()
    return self:GetStackCount()
end

function modifier_juggernaut_swiftness:CheckState()
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_juggernaut_swiftness:GetEffectName()
	return "particles/items2_fx/butterfly_buff.vpcf"
end

function modifier_juggernaut_swiftness:GetTexture()
	return "modifier_swiftness"
end

function modifier_juggernaut_swiftness:GetStatusLabel() return "Swiftness" end
function modifier_juggernaut_swiftness:GetStatusPriority() return 1 end
function modifier_juggernaut_swiftness:GetStatusStyle() return "Swiftness" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_juggernaut_swiftness)