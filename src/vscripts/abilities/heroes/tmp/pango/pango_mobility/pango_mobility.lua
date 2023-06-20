pango_mobility = class({})
LinkLuaModifier("modifier_pango_mobility", "abilities/heroes/pango/pango_mobility/modifier_pango_mobility", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pango_roll_end_animation", "abilities/heroes/pango/modifier_pango_roll_end_animation", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pango_mobility_displacement", "abilities/heroes/pango/pango_mobility/modifier_pango_mobility_displacement", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_pango_mobility_marker", "abilities/heroes/pango/pango_mobility/modifier_pango_mobility_marker", LUA_MODIFIER_MOTION_BOTH)

GetAnimation(){		return GameActivity.DOTA_CAST_ABILITY_4 }
GetPlaybackRateOverride(){ 	    return 2.0 }
GetCastingCrawl(){ 			return 80 }

OnAbilityPhaseStart(){
	this.efx = ParticleManager.CreateParticle('particles/pango/pango_mobility.vpcf', ParticleAttachment.ABSORIGIN_FOLLOW, this.caster)
	ParticleManager.SetParticleControlEnt(this.efx, 1, this.caster, ParticleAttachment.ABSORIGIN_FOLLOW, 'attach_hitloc', this.caster.GetAbsOrigin(), false)
    EmitSoundOn("Hero_Pangolier.Gyroshell.Cast", this.caster)
    return true
}

OnAbilityPhaseInterrupted(){
	DEFX(this.efx, false)
	StopSoundOn("Hero_Pangolier.Gyroshell.Cast", this.caster)
}

OnSpellStart(){
    DEFX(this.efx, false)
    
    const duration = this.GetSpecialValueFor("duration")

    this.caster.AddNewModifier(this.caster, this, "modifier_pango_mobility", { duration = duration })
    StopSoundOn("Hero_Pangolier.Gyroshell.Cast", this.caster)
    
    if(this.GetLevel() >= 2 ) {
        this.caster.FindAbilityByName("pango_special_attack"):EndCooldown()
    }
}

if(IsClient() ) { require("wrappers/abilities") }
Abilities.Castpoint(pango_mobility)