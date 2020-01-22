modifier_juggernaut_ex_second_attack = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_juggernaut_ex_second_attack:IsHidden()
	return false
end

function modifier_juggernaut_ex_second_attack:IsDebuff()
	return false
end

function modifier_juggernaut_ex_second_attack:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_juggernaut_ex_second_attack:OnCreated( kv )
	self.speed_buff_pct = self:GetAbility():GetSpecialValueFor("speed_buff_pct")
	
	if IsServer() then 
		self:GetParent():AddStatusBar({
			label = "Invisible", modifier = self, priority = 3, 
		})
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_juggernaut_ex_second_attack:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
        MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
	}

	return funcs
end

function modifier_juggernaut_ex_second_attack:GetModifierInvisibilityLevel()
	return 1
end

function modifier_juggernaut_ex_second_attack:GetModifierIgnoreMovespeedLimit( params )
    return 1
end

function modifier_juggernaut_ex_second_attack:GetModifierMoveSpeedBonus_Percentage()
    return self.speed_buff_pct
end

function modifier_juggernaut_ex_second_attack:OnAbilityFullyCast( params )
	if IsServer() then
		if params.unit ~= self:GetParent() then
			return
		end

		if 	params.ability:GetName() == "item_death_orb" or
			params.ability:GetName() == "item_mana_orb" or
			params.ability:GetName() == "item_health_orb" or
			params.ability:GetName() == "item_shield_orb" 
		then
			return
		end

		-- Wait to be read on basic attack before destroying
		Timers:CreateTimer(params.ability:GetCastPoint() + 0.1, function()
			self:Destroy()
		end)
	end
end


--------------------------------------------------------------------------------
-- Status Effects
function modifier_juggernaut_ex_second_attack:CheckState()
	local state = {
        [MODIFIER_STATE_INVISIBLE] = true,
        [MODIFIER_STATE_TRUESIGHT_IMMUNE] = false,
	}

	return state
end
