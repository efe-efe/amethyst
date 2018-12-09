modifier_basic_attack = class({})
local tempTable = require("util/tempTable")

--------------------------------------------------------------------------------
-- Classifications
function modifier_basic_attack:IsHidden()
    return false
end

function modifier_basic_attack:IsDebuff()
	return false
end

function modifier_basic_attack:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_basic_attack:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_basic_attack:OnCreated( kv )
	-- references
	self.duration = self:GetAbility():GetSpecialValueFor( "stacks_duration" )
	self.attackspeed_variation = self:GetAbility():GetSpecialValueFor( "attackspeed_variation" )
	self.damage_variation = self:GetAbility():GetSpecialValueFor( "damage_variation" )
	self.max_stacks = self:GetAbility():GetSpecialValueFor( "max_stacks" )
end

function modifier_basic_attack:OnRefresh( kv )
	-- references
	self.duration = self:GetAbility():GetSpecialValueFor( "stacks_duration" )
	self.attackspeed_variation = self:GetAbility():GetSpecialValueFor( "attackspeed_variation" )
	self.damage_variation = self:GetAbility():GetSpecialValueFor( "damage_variation" )
	self.max_stacks = self:GetAbility():GetSpecialValueFor( "max_stacks" )
end

function modifier_basic_attack:GetModifierProcAttack_Feedback( params )
	if IsServer() and (not self:GetParent():PassivesDisabled()) then
		-- filter enemy
		local target = params.target
		if (not target:IsHero()) or target:IsIllusion() then
			return
		end

		if ( self:GetStackCount() == self.max_stacks ) then
			return
		end
		
		-- Apply debuff to enemy
		local debuff = params.target:AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_basic_attack_debuff",
			{
				stack_duration = self.duration,
				attackspeed_variation = self.attackspeed_variation,
				damage_variation = self.damage_variation,
			}
		)

		-- Apply buff to self
		self:AddStack( )

        -- Play effects
		self:PlayEffects( params.target )
	end
end

function modifier_basic_attack:GetModifierBaseAttack_BonusDamage( params )
	return self:GetStackCount() * self.damage_variation
end

function modifier_basic_attack:GetModifierAttackSpeedBonus_Constant( params )
	return self:GetStackCount() * self.attackspeed_variation
end



--------------------------------------------------------------------------------
-- Helper
function modifier_basic_attack:AddStack( duration )
	-- Add counter
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

function modifier_basic_attack:RemoveStack()
	self:DecrementStackCount()
end

-- Graphics & Animations
function modifier_basic_attack:PlayEffects( target )
	local particle_cast = "particles/units/heroes/hero_slark/slark_essence_shift.vpcf"

	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControl( effect_cast, 1, self:GetParent():GetOrigin() + Vector( 0, 0, 64 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end