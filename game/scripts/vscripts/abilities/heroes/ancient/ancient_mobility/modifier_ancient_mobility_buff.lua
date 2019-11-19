
modifier_ancient_mobility_buff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_ancient_mobility_buff:IsHidden()
	return false
end

function modifier_ancient_mobility_buff:IsDebuff()
	return false
end

function modifier_ancient_mobility_buff:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_ancient_mobility_buff:OnCreated( kv )
	self.ms_swing_pct = self:GetAbility():GetSpecialValueFor("ms_swing_pct")
    
	if IsServer() then 
		self:GetParent():AddStatusBar({
			label = "Haste", modifier = self, priority = 2, 
		})
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_ancient_mobility_buff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
	}

	return funcs
end

function modifier_ancient_mobility_buff:GetModifierMoveSpeedBonus_Percentage()
    return self.ms_swing_pct
end

function modifier_ancient_mobility_buff:GetModifierIgnoreMovespeedLimit( params )
    return 1
end

-- Graphics & Animations
function modifier_ancient_mobility_buff:GetEffectName()
	--return "particles/mod_units/heroes/hero_spectre/spectre_ti7_crimson_spectral_dagger_path_owner.vpcf"
end

function modifier_ancient_mobility_buff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
