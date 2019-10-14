phantom_counter = class({})
LinkLuaModifier( "modifier_phantom_counter", "abilities/heroes/phantom/phantom_counter/modifier_phantom_counter", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_charges", "abilities/generic/modifier_generic_charges", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function phantom_counter:GetIntrinsicModifierName()
	return "modifier_generic_charges"
end

--------------------------------------------------------------------------------
-- Ability Start
function phantom_counter:OnSpellStart()
	--load data
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")

    caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_phantom_counter", -- modifier name
		{ duration = duration } -- kv
    )
end
