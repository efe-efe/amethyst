nevermore_extra = class({})
LinkLuaModifier("modifier_nevermore_extra", "abilities/heroes/nevermore/nevermore_extra/modifier_nevermore_extra", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_extra_debuff", "abilities/heroes/nevermore/nevermore_extra/modifier_nevermore_extra_debuff", LUA_MODIFIER_MOTION_NONE)

function nevermore_extra:OnAbilityPhaseStart()
	self.efx = EFX("particles/nevermore/nevermore_ex_second_attack_casting.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster(), {})
	EmitSoundOn("Hero_Nevermore.ROS.Arcana.Cast", self:GetCaster())
	return true
end

function nevermore_extra:OnAbilityPhaseInterrupted()
	DEFX(self.efx, true)
	StopSoundOn("Hero_Nevermore.ROS.Arcana.Cast", self:GetCaster())
end

function nevermore_extra:GetCastAnimationCustom()	return ACT_DOTA_TELEPORT end
function nevermore_extra:GetPlaybackRateOverride() 	return 1.2 end
function nevermore_extra:GetCastPointSpeed() 		return 100 end

function nevermore_extra:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor('duration')
	local modifier = self:GetCaster():FindModifierByName('modifier_nevermore_souls')
	local souls = modifier:GetStackCount()
	modifier:SetStackCount(0)

	caster:AddNewModifier(caster, self, 'modifier_nevermore_extra', { 
		duration = duration,
		souls = souls 
	})

	EmitSoundOn('Hero_Nevermore.Shadowraze.Arcana', caster)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(nevermore_extra)