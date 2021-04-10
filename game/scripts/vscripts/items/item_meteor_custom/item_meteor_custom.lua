item_meteor_custom = class({})
LinkLuaModifier("modifier_item_meteor_custom_thinker", "items/item_meteor_custom/modifier_item_meteor_custom_thinker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_meteor_custom", "items/item_meteor_custom/modifier_item_meteor_custom", LUA_MODIFIER_MOTION_NONE)

function item_meteor_custom:OnAbilityPhaseStart()
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_casting", { 
		duration = self:GetCastPoint(), 
		movement_speed = 10,
	})
	self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_GENERIC_CHANNEL_1, 1.0)
	EmitSoundOn("DOTA_Item.MeteorHammer.Cast", self:GetCaster())

	return true
end

function item_meteor_custom:OnAbilityPhaseInterrupted()
	self:GetCaster():FadeGesture(ACT_DOTA_GENERIC_CHANNEL_1)
	self:GetCaster():RemoveModifierByName("modifier_casting")

	StopSoundOn("DOTA_Item.MeteorHammer.Cast", self:GetCaster())
end

function item_meteor_custom:OnSpellStart()
	self:GetCaster():RemoveGesture(ACT_DOTA_GENERIC_CHANNEL_1)
	
	local caster = self:GetCaster()
	local point = ClampPosition(caster:GetOrigin(), CustomAbilities:GetCursorPosition(self), self:GetCastRange(Vector(0,0,0), nil), nil)
	local delay_time = self:GetSpecialValueFor("delay_time")
	local radius = self:GetSpecialValueFor("radius")

	CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_item_meteor_custom_thinker", --modifierName
		{ duration = delay_time + 0.2 }, --paramTable
		point, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)
end

--[[
if IsClient() then require("wrappers/abilities") end
Abilities.Initialize(
	item_meteor_custom,
	{ activity = ACT_DOTA_GENERIC_CHANNEL_1, rate = 1.0 },
	{ movement_speed = 10 }
)
]]