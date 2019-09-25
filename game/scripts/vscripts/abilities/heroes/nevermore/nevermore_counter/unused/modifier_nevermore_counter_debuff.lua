modifier_nevermore_counter_debuff = class({})
--------------------------------------------------------------------------------
-- Classifications
function modifier_nevermore_counter_debuff:IsHidden()
	return false
end

function modifier_nevermore_counter_debuff:IsDebuff()
	return true
end

function modifier_nevermore_counter_debuff:IsStunDebuff()
	return false
end

function modifier_nevermore_counter_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_nevermore_counter_debuff:OnCreated( kv )
	-- references
	self.armor = -self:GetAbility():GetSpecialValueFor( "armor" ) -- special value

	if IsServer() then
		--Add stack
		local basic_attack = self:GetCaster():FindAbilityByName("nevermore_basic_attack")
		
		if self:GetParent():IsRealHero() then 
			self:GetCaster():AddNewModifier(
				self:GetCaster(),
				basic_attack,
				"modifier_nevermore_souls",
				{ duration = basic_attack:GetSpecialValueFor("duration") }
			)
		end
	end
end

--------------------------------------------------------------------------------
-- Refresh
function modifier_nevermore_counter_debuff:OnRefresh( kv )
	-- references
	self.armor = -self:GetAbility():GetSpecialValueFor( "armor" ) -- special value
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_nevermore_counter_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}

	return funcs
end

function modifier_nevermore_counter_debuff:GetModifierPhysicalArmorBonus()
	return self.armor
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_nevermore_counter_debuff:GetEffectName()
    return "particles/units/heroes/hero_dazzle/dazzle_armor_enemy.vpcf"
end

function modifier_nevermore_counter_debuff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end