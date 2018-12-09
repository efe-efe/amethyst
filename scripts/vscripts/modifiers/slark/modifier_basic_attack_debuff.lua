modifier_basic_attack_debuff = class({})
local tempTable = require("util/tempTable")
--------------------------------------------------------------------------------
-- Classifications
function modifier_basic_attack_debuff:IsHidden()
	return false
end

function modifier_basic_attack_debuff:IsDebuff()
	return true
end

function modifier_basic_attack_debuff:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_basic_attack_debuff:OnCreated( kv )
	-- references
	self.duration = kv.stack_duration
	self.attackspeed_variation = kv.attackspeed_variation
	self.damage_variation = kv.damage_variation

	if IsServer() then
		self:AddStack( self.duration )
	end
end

function modifier_basic_attack_debuff:OnRefresh( kv )
	-- references
	self.duration = kv.stack_duration
	self.attackspeed_variation = kv.attackspeed_variation
    self.damage_variation = kv.damage_variation
    
	if IsServer() then
		self:AddStack( self.duration )
	end
end

function modifier_basic_attack_debuff:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_basic_attack_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
	}

	return funcs
end

function modifier_basic_attack_debuff:GetModifierBaseAttack_BonusDamage( params )
	return - ( self:GetStackCount() * self.damage_variation )
end

function modifier_basic_attack_debuff:GetModifierAttackSpeedBonus_Constant( params )
	return - ( self:GetStackCount() * self.attackspeed_variation )
end

--------------------------------------------------------------------------------
-- Helper
function modifier_basic_attack_debuff:AddStack( duration )
	-- Add modifier
	local parent = tempTable:AddATValue( self )
	self:GetParent():AddNewModifier(
		self:GetParent(),
		self:GetAbility(),
		"modifier_stack",
		{
			duration = self.duration,
			modifier = parent,
		}
	)

	-- Add stack
	self:IncrementStackCount()
end

function modifier_basic_attack_debuff:RemoveStack()
	self:DecrementStackCount()

	if self:GetStackCount()<=0 then
		self:Destroy()
	end
end