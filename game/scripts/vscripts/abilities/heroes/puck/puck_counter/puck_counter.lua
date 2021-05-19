puck_counter = class({})
LinkLuaModifier("modifier_puck_counter_banish", "abilities/heroes/puck/puck_counter/modifier_puck_counter_banish", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_puck_counter_charges", "abilities/heroes/puck/puck_counter/modifier_puck_counter_charges", LUA_MODIFIER_MOTION_NONE)

function puck_counter:GetIntrinsicModifierName()
	return "modifier_puck_counter_charges"
end

function puck_counter:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	local point = CustomAbilitiesLegacy:GetCursorPosition(self)
	local banish_duration = self:GetSpecialValueFor("banish_duration")

	caster:AddNewModifier(caster, self, "modifier_puck_counter_banish", { duration = banish_duration })

	if self:GetLevel() >= 2 then
		caster:FindModifierByName("modifier_puck_basic_attack_cooldown"):Replenish()
	end
	local ability = caster:FindAbilityByName("puck_basic_attack")
	ability:LaunchProjectile(self:GetCaster():GetOrigin(), CustomAbilitiesLegacy:GetCursorPosition(ability))
end

