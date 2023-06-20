mars_mobility = class({})
LinkLuaModifier("modifier_mars_mobility_banish", "abilities/heroes/mars/mars_mobility/modifier_mars_mobility_banish", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_mars_mobility_thinker", "abilities/heroes/mars/mars_mobility/modifier_mars_mobility_thinker", LUA_MODIFIER_MOTION_NONE)

GetAnimation(){		return GameActivity.DOTA_GENERIC_CHANNEL_1 }
GetPlaybackRateOverride(){    return 1.5 }
GetCastingCrawl(){ 			return 0 }

OnAbilityPhaseStart(){
    const particle_cast = "particles/econ/events/ti10/fountain_regen_ti10_lvl3.vpcf"
	this.particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.ABSORIGIN_FOLLOW, this.caster)

    EmitSoundOn("mars_mars_spawn_01", this.caster)

    return true
}

OnAbilityPhaseInterrupted(){
    this.StopEffects()
}

OnSpellStart(){
    
    const origin = this.caster.GetAbsOrigin()
    const min_range = this.GetSpecialValueFor("min_range")

    const point = ClampPosition(origin, CustomAbilitiesLegacy:GetCursorPosition(this), this.GetCastRange(Vector(0,0,0), undefined), min_range)
    const delay = this.GetSpecialValueFor("delay_time")

    CreateModifierThinker(
        this.caster, --hCaster
        this, --hAbility
        "modifier_mars_mobility_thinker", --modifierName
        { duration = delay + 0.2 },
        point, --vOrigin
        this.caster.GetTeamNumber(), --nTeamNumber
        false --bPhantomBlocker
   )

    this.PlayEffectsOnCast()
    this.StopEffects()
}

function mars_mobility:StopEffects()
    ParticleManager.DestroyParticle(this.particleId, false)
    ParticleManager.ReleaseParticleIndex(this.particleId)
}

PlayEffectsOnCast(){
    const particle_cast = "particles/mars/mars_mobility_start.vpcf"
	const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.POINT, this.caster)
	ParticleManager.SetParticleControl(particleId, 0, this.caster.GetAbsOrigin())
	ParticleManager.SetParticleControl(particleId, 1, Vector(250, 1, 1))
    ParticleManager.ReleaseParticleIndex(particleId)
    
    particle_cast = "particles/econ/events/ti10/blink_dagger_start_ti10_lvl2.vpcf"
	particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.POINT, this.caster)
    ParticleManager.ReleaseParticleIndex(particleId)
	ParticleManager.SetParticleControl(particleId, 0, this.caster.GetAbsOrigin())
}

if(IsClient() ) { require("wrappers/abilities") }
Abilities.Castpoint(mars_mobility)