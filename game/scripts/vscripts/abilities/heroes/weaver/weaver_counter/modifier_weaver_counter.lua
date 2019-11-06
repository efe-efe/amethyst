modifier_weaver_counter = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_weaver_counter:IsHidden()
	return false
end

function modifier_weaver_counter:IsDebuff()
	return false
end

function modifier_weaver_counter:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_weaver_counter:OnCreated( kv )
	self.speed_buff_pct = self:GetAbility():GetSpecialValueFor("speed_buff_pct")
	
	if IsServer() then 
		self:GetParent():AddStatusBar({
			label = "Invisible", modifier = self, priority = 3, 
		})
	end
end

function modifier_weaver_counter:OnDestroy( kv )
	if IsServer() then 
		self:GetAbility():StartCooldown(self:GetAbility():GetCooldown(0))
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_weaver_counter:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
	}

	return funcs
end

function modifier_weaver_counter:GetModifierInvisibilityLevel()
	return 2
end

function modifier_weaver_counter:GetModifierMoveSpeedBonus_Percentage()
    return self.speed_buff_pct
end

function modifier_weaver_counter:GetModifierIgnoreMovespeedLimit( params )
    return 1
end


--------------------------------------------------------------------------------
-- Status Effects
function modifier_weaver_counter:CheckState()
	local state = {
		[MODIFIER_STATE_INVISIBLE] = true,
		[MODIFIER_STATE_TRUESIGHT_IMMUNE] = false,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}

	return state
end

--------------------------------------------------------------------------------
--Graphics
function modifier_weaver_counter:GetEffectName()
	return "particles/mod_units/heroes/hero_weaver/weaver_shukuchi.vpcf"
end

function modifier_weaver_counter:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
