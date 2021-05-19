nevermore_special_attack = class({})
nevermore_ex_special_attack = class({})

LinkLuaModifier("modifier_nevermore_special_attack_thinker", "abilities/heroes/nevermore/nevermore_special_attack/modifier_nevermore_special_attack_thinker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_special_attack_charges", "abilities/heroes/nevermore/nevermore_special_attack/modifier_nevermore_special_attack_charges", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_special_attack_stacks", "abilities/heroes/nevermore/nevermore_special_attack/modifier_nevermore_special_attack_stacks", LUA_MODIFIER_MOTION_NONE)

function nevermore_special_attack:GetCastAnimationCustom()		return ACT_DOTA_RAZE_3 end
function nevermore_special_attack:GetPlaybackRateOverride()		return 1.3 end
function nevermore_special_attack:GetCastPointSpeed() 			return 10 end
function nevermore_special_attack:GetFadeGestureOnCast()			return false end

function nevermore_special_attack:OnAbilityPhaseStart()
	local random_number = RandomInt(0, 3)
	EmitSoundOn("nevermore_nev_cast_0" .. random_number, self:GetCaster())
	EmitSoundOn("Hero_Nevermore.Attack", self:GetCaster())
	
	return true
end

function nevermore_special_attack:GetIntrinsicModifierName()
	return 'modifier_nevermore_special_attack_charges'
end

function nevermore_special_attack:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = ClampPosition(origin, CustomAbilitiesLegacy:GetCursorPosition(self), self:GetCastRange(Vector(0,0,0), nil), nil)

	CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_nevermore_special_attack_thinker", --modifierName
		{}, --paramTable
		point, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)
	LinkAbilityCooldowns(caster, 'nevermore_ex_special_attack')
end

function nevermore_special_attack:OnUpgrade()
	if self:GetLevel() == 2 then
		self:GetCaster():FindModifierByName("modifier_nevermore_special_attack_charges"):AddCharge()
	end
end

function nevermore_ex_special_attack:GetCastAnimationCustom()		return ACT_DOTA_RAZE_2 end
function nevermore_ex_special_attack:GetPlaybackRateOverride() 		return 1.3 end
function nevermore_ex_special_attack:GetCastPointSpeed() 			return 0 end
function nevermore_ex_special_attack:GetFadeGestureOnCast()			return false end

function nevermore_ex_special_attack:OnSpellStart()
	self:GetCaster():RemoveGesture(self:GetCastAnimationCustom())

	local caster = self:GetCaster()
	local heal_per_soul = self:GetSpecialValueFor("heal_per_soul")
	local heal = self:GetSpecialValueFor("heal")
	local modifier = self:GetCaster():FindModifierByName('modifier_nevermore_souls')
	local souls = modifier:GetStackCount()
	modifier:SetStackCount(0)

	self:PlayEffects()
	caster:Heal(heal + (heal_per_soul * souls), caster)
	LinkAbilityCooldowns(caster, 'nevermore_special_attack')
end

function nevermore_ex_special_attack:PlayEffects()
	local caster = self:GetCaster()
	EmitSoundOn("DOTA_Item.SoulRing.Activate", caster)

	local particle_cast = "particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster)	
	ParticleManager:SetParticleControl(effect_cast, 0, caster:GetOrigin())
	ParticleManager:SetParticleControl(effect_cast, 60, Vector(68, 243, 0))
	ParticleManager:SetParticleControl(effect_cast, 61, Vector(1, 0, 0))
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(nevermore_special_attack)
Abilities.Castpoint(nevermore_ex_special_attack)