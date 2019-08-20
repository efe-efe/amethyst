modifier_juggernaut_counter_buff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_juggernaut_counter_buff:IsHidden()
	return false
end

function modifier_juggernaut_counter_buff:IsDebuff()
	return false
end

function modifier_juggernaut_counter_buff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_juggernaut_counter_buff:OnCreated( kv )
	self.attack_speed_bonus = self:GetAbility():GetSpecialValueFor( "attack_speed_bonus" )
    self.speed_buff_pct = self:GetAbility():GetSpecialValueFor( "speed_buff_pct" )
	if IsServer() then
		EmitSoundOn("Hero_Juggernaut.ArcanaHaste.Anim", self:GetParent())
	end
end

--------------------------------------------------------------------------------
-- Refresh
function modifier_juggernaut_counter_buff:OnRefresh( kv )
	self.attack_speed_bonus = self:GetAbility():GetSpecialValueFor( "attack_speed_bonus" )
    self.speed_buff_pct = self:GetAbility():GetSpecialValueFor( "speed_buff_pct" )
	if IsServer() then
		EmitSoundOn("Hero_Juggernaut.ArcanaHaste.Anim", self:GetParent())
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_juggernaut_counter_buff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_juggernaut_counter_buff:GetModifierAttackSpeedBonus_Constant()
	return self.attack_speed_bonus
end

function modifier_juggernaut_counter_buff:GetModifierMoveSpeedBonus_Percentage()
    return self.speed_buff_pct
end

function modifier_juggernaut_counter_buff:GetModifierIgnoreMovespeedLimit( params )
    return 1
end

--------------------------------------------------------------------------------
--Graphics & Animations
function modifier_juggernaut_counter_buff:GetEffectName()
	return "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_trigger.vpcf"
end

function modifier_juggernaut_counter_buff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
