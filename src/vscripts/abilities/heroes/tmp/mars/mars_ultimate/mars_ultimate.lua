mars_ultimate = class({})
LinkLuaModifier("modifier_mars_soldier", "abilities/heroes/mars/modifier_mars_soldier", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_mars_soldier_debuff", "abilities/heroes/mars/modifier_mars_soldier_debuff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_mars_soldier_displacement", "abilities/heroes/mars/modifier_mars_soldier_displacement", LUA_MODIFIER_MOTION_BOTH)

LinkLuaModifier("modifier_mars_ultimate_thinker", "abilities/heroes/mars/mars_ultimate/modifier_mars_ultimate_thinker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_mars_ultimate_area_check", "abilities/heroes/mars/mars_ultimate/modifier_mars_ultimate_area_check", LUA_MODIFIER_MOTION_NONE)

GetAnimation(){		return GameActivity.DOTA_CAST_ABILITY_1 } 
GetPlaybackRateOverride(){    return 1.0 }
GetCastingCrawl(){ 			return 0 }

OnAbilityPhaseStart(){
    
    const delay = this.GetCastPoint()
    const duration = this.GetSpecialValueFor("duration")

    this.thinker = CreateModifierThinker(
        this.caster, --hCaster
        this, --hAbility
        "modifier_mars_ultimate_thinker", --modifierName
        { duration = delay + duration },
        this.caster.GetAbsOrigin(), --vOrigin
        this.caster.GetTeamNumber(), --nTeamNumber
        true --bPhantomBlocker
    )      

    return true
}

OnAbilityPhaseInterrupted(){
    this.thinker:Destroy()
}


if(IsClient() ) { require("wrappers/abilities") }
Abilities.Castpoint(mars_ultimate)