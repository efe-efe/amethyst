modifier_weaver_shukuchi_lua = class({})
LinkLuaModifier( "modifier_weaver_shukuchi_damage", "abilities/weaver/weaver_shukuchi_lua/modifier_weaver_shukuchi_damage", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Classifications
function modifier_weaver_shukuchi_lua:IsHidden()
	return false
end

function modifier_weaver_shukuchi_lua:IsDebuff()
	return false
end

function modifier_weaver_shukuchi_lua:IsPurgable()
	return false
end

function modifier_weaver_shukuchi_lua:GetPriority()
	return MODIFIER_PRIORITY_HIGH
end


--------------------------------------------------------------------------------
-- Aura
function modifier_weaver_shukuchi_lua:IsAura()
	if self:GetCaster() == self:GetParent() then
		return true
	end
	
	return false
end

function modifier_weaver_shukuchi_lua:GetModifierAura()
	return "modifier_weaver_shukuchi_damage"
end

function modifier_weaver_shukuchi_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_weaver_shukuchi_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_weaver_shukuchi_lua:GetAuraRadius()
	return self.radius
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_weaver_shukuchi_lua:OnCreated( kv )
	-- references
	local fade_time = self:GetAbility():GetSpecialValueFor("fade_time") 
	local mana_gain = self:GetAbility():GetSpecialValueFor("mana_gain")
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
end

function modifier_weaver_shukuchi_lua:OnRefresh( kv )-- references
	local fade_time = self:GetAbility():GetSpecialValueFor("fade_time") 
	local mana_gain = self:GetAbility():GetSpecialValueFor("mana_gain")
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
end

function modifier_weaver_shukuchi_lua:OnAbilityExecuted( params )
	if IsServer() then
		if params.unit~=self:GetParent() then return end
		self:Destroy()
	end
end


--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_weaver_shukuchi_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
		MODIFIER_EVENT_ON_ABILITY_EXECUTED,
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
	}

	return funcs
end

function modifier_weaver_shukuchi_lua:GetModifierInvisibilityLevel()
	return 2
end

function modifier_weaver_shukuchi_lua:GetModifierMoveSpeed_Absolute()
	return 650
end

-- Status Effects
function modifier_weaver_shukuchi_lua:CheckState()
	local state = {
		[MODIFIER_STATE_INVISIBLE] = true,
	}

	return state
end

-- Graphics & Animations
function modifier_weaver_shukuchi_lua:GetEffectName()
	return "particles/units/heroes/hero_weaver/weaver_shukuchi.vpcf"
end

function modifier_weaver_shukuchi_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end