nevermore_special_attack = class({})
nevermore_ex_special_attack = class({})

LinkLuaModifier("modifier_nevermore_special_attack_thinker", "abilities/heroes/nevermore/nevermore_special_attack/modifier_nevermore_special_attack_thinker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_special_attack_charges", "abilities/heroes/nevermore/nevermore_special_attack/modifier_nevermore_special_attack_charges", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_special_attack_stacks", "abilities/heroes/nevermore/nevermore_special_attack/modifier_nevermore_special_attack_stacks", LUA_MODIFIER_MOTION_NONE)

GetAnimation(){		return GameActivity.DOTA_RAZE_3 }
GetPlaybackRateOverride(){		return 1.3 }
GetCastingCrawl(){ 			return 10 }
function nevermore_special_attack:GetFadeGestureOnCast()			return false }

OnAbilityPhaseStart(){
	const random_number = RandomInt(0, 3)
	EmitSoundOn("nevermore_nev_cast_0" .. random_number, this.caster)
	EmitSoundOn("Hero_Nevermore.Attack", this.caster)
	
	return true
}

GetIntrinsicModifierName(){
	return 'modifier_nevermore_special_attack_charges'
}

OnSpellStart(){
	
	const origin = this.caster.GetAbsOrigin()
	const point = ClampPosition(origin, CustomAbilitiesLegacy:GetCursorPosition(this), this.GetCastRange(Vector(0,0,0), undefined), undefined)

	CreateModifierThinker(
		this.caster, --hCaster
		this, --hAbility
		"modifier_nevermore_special_attack_thinker", --modifierName
		{}, --paramTable
		point, --vOrigin
		this.caster.GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)
	LinkAbilityCooldowns(this.caster, 'nevermore_ex_special_attack')
}

function nevermore_special_attack:OnUpgrade()
	if(this.GetLevel() == 2 ) {
		this.caster.FindModifierByName("modifier_nevermore_special_attack_charges"):AddCharge()
	}
}

GetAnimation(){		return GameActivity.DOTA_RAZE_2 }
GetPlaybackRateOverride(){ 		return 1.3 }
GetCastingCrawl(){ 			return 0 }
function nevermore_ex_special_attack:GetFadeGestureOnCast()			return false }

OnSpellStart(){
	this.caster.RemoveGesture(this.GetCastAnimationCustom())

	
	const heal_per_soul = this.GetSpecialValueFor("heal_per_soul")
	const heal = this.GetSpecialValueFor("heal")
	const modifier = this.caster.FindModifierByName('modifier_nevermore_souls')
	const souls = modifier:GetStackCount()
	modifier:SetStackCount(0)

	this.PlayEffects()
	this.caster.Heal(heal + (heal_per_soul * souls), this.caster)
	LinkAbilityCooldowns(this.caster, 'nevermore_special_attack')
}

PlayEffects(){
	
	EmitSoundOn("DOTA_Item.SoulRing.Activate", this.caster)

	const particle_cast = "particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf"
	const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.ABSORIGIN_FOLLOW, this.caster)	
	ParticleManager.SetParticleControl(particleId, 0, this.caster.GetAbsOrigin())
	ParticleManager.SetParticleControl(particleId, 60, Vector(68, 243, 0))
	ParticleManager.SetParticleControl(particleId, 61, Vector(1, 0, 0))
	ParticleManager.ReleaseParticleIndex(particleId)
}

if(IsClient() ) { require("wrappers/abilities") }
Abilities.Castpoint(nevermore_special_attack)
Abilities.Castpoint(nevermore_ex_special_attack)