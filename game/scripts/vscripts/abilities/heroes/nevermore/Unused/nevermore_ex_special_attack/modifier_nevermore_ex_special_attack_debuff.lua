modifier_nevermore_ex_special_attack_debuff = class({})
--------------------------------------------------------------------------------
-- Classifications
function modifier_nevermore_ex_special_attack_debuff:IsHidden() return false
end

function modifier_nevermore_ex_special_attack_debuff:IsDebuff()
	return true
end

function modifier_nevermore_ex_special_attack_debuff:IsStunDebuff()
	return false
end

function modifier_nevermore_ex_special_attack_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_nevermore_ex_special_attack_debuff:OnCreated( kv )
	-- references
	self.armor = -self:GetAbility():GetSpecialValueFor( "armor" ) -- special value

	if IsServer() then
		self:SetStackCount(1)
	end
end

--------------------------------------------------------------------------------
-- Refresh
function modifier_nevermore_ex_special_attack_debuff:OnRefresh( kv )
	-- references
	self.armor = -self:GetAbility():GetSpecialValueFor( "armor" ) -- special value

	if IsServer() then
		self:IncrementStackCount()
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_nevermore_ex_special_attack_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}

	return funcs
end

function modifier_nevermore_ex_special_attack_debuff:GetModifierPhysicalArmorBonus()
	return self:GetStackCount() * self.armor
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_nevermore_ex_special_attack_debuff:GetEffectName()
    return "particles/units/heroes/hero_dazzle/dazzle_armor_enemy.vpcf"
end

function modifier_nevermore_ex_special_attack_debuff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end