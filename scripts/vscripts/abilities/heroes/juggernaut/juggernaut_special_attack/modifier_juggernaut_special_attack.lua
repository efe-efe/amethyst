modifier_juggernaut_special_attack = class({})

-- Clasifications
--------------------------------------------------------------------------------
function modifier_juggernaut_special_attack:IsDebuff()
	return true
end

function modifier_juggernaut_special_attack:IsStunDebuff()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_juggernaut_special_attack:OnCreated( kv )
    self.duration = self:GetDuration()
    self.fading_slow = -self:GetAbility():GetSpecialValueFor("fading_slow")

    EmitSoundOn("DOTA_Item.DiffusalBlade.Activate", self:GetParent())
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_juggernaut_special_attack:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_juggernaut_special_attack:GetModifierMoveSpeedBonus_Percentage()
    return self.fading_slow
end


--------------------------------------------------------------------------------
--Graphics
function modifier_juggernaut_special_attack:GetEffectName()
	return "particles/generic_gameplay/generic_purge.vpcf"
end

function modifier_juggernaut_special_attack:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
