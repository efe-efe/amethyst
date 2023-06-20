nevermore_extra = class({})
LinkLuaModifier("modifier_nevermore_extra", "abilities/heroes/nevermore/nevermore_extra/modifier_nevermore_extra", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_extra_debuff", "abilities/heroes/nevermore/nevermore_extra/modifier_nevermore_extra_debuff", LUA_MODIFIER_MOTION_NONE)

OnAbilityPhaseStart(){
	this.efx = EFX("particles/nevermore/nevermore_ex_second_attack_casting.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.caster, {})
	EmitSoundOn("Hero_Nevermore.ROS.Arcana.Cast", this.caster)
	return true
}

OnAbilityPhaseInterrupted(){
	DEFX(this.efx, true)
	StopSoundOn("Hero_Nevermore.ROS.Arcana.Cast", this.caster)
}

GetAnimation(){	return GameActivity.DOTA_TELEPORT }
GetPlaybackRateOverride(){ 	return 1.2 }
GetCastingCrawl(){ 		return 100 }

OnSpellStart(){
	
	const duration = this.GetSpecialValueFor('duration')
	const modifier = this.caster.FindModifierByName('modifier_nevermore_souls')
	const souls = modifier:GetStackCount()
	modifier:SetStackCount(0)

	this.caster.AddNewModifier(this.caster, this, 'modifier_nevermore_extra', { 
		duration = duration,
		souls = souls 
	})

	EmitSoundOn('Hero_Nevermore.Shadowraze.Arcana', this.caster)
}

if(IsClient() ) { require("wrappers/abilities") }
Abilities.Castpoint(nevermore_extra)