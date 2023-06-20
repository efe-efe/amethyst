nevermore_special_attack = class({})
LinkLuaModifier("modifier_nevermore_special_attack_thinker", "abilities/heroes/nevermore/nevermore_special_attack/modifier_nevermore_special_attack_thinker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_special_attack_displacement", "abilities/heroes/nevermore/nevermore_special_attack/modifier_nevermore_special_attack_displacement", LUA_MODIFIER_MOTION_BOTH)

GetAnimation(){		return GameActivity.DOTA_RAZE_3 }
GetPlaybackRateOverride(){		return 1.3 }
GetCastingCrawl(){ 			return 10 }
function nevermore_special_attack:GetFadeGestureOnCast()			return false }

OnAbilityPhaseStart(){
	this.particleId = ParticleManager.CreateParticle("particles/econ/items/sven/sven_warcry_ti5/sven_spell_warcry_ti_5.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.caster)

	const random_number = RandomInt(0, 3)
	EmitSoundOn("nevermore_nev_cast_0" .. random_number, this.caster)
	EmitSoundOn("Hero_Nevermore.Attack", this.caster)
	
	return true
}

OnAbilityPhaseInterrupted(){
	ParticleManager.DestroyParticle(this.particleId, false)
	ParticleManager.ReleaseParticleIndex(this.particleId)
}

OnSpellStart(){
	
	const origin = this.caster.GetAbsOrigin()
	const point = ClampPosition(origin, CustomAbilitiesLegacy:GetCursorPosition(this), this.GetCastRange(Vector(0,0,0), undefined), undefined)

	CreateModifierThinker(
		this.caster, --hCaster
		this, --hAbility
		"modifier_nevermore_special_attack_thinker", --modifierName
		{ duration = this.GetSpecialValueFor("delay_time") + 0.2 }, --paramTable
		point, --vOrigin
		this.caster.GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)

	ParticleManager.DestroyParticle(this.particleId, false)
	ParticleManager.ReleaseParticleIndex(this.particleId)
}

if(IsClient() ) { require("wrappers/abilities") }
Abilities.Castpoint(nevermore_special_attack)