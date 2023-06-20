mars_counter = class({})
LinkLuaModifier("modifier_mars_counter_countering", "abilities/heroes/mars/mars_counter/modifier_mars_counter_countering", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_mars_counter_displacement", "abilities/heroes/mars/mars_counter/modifier_mars_counter_displacement", LUA_MODIFIER_MOTION_BOTH)

OnSpellStart(){
    
    const duration = this.GetSpecialValueFor("counter_duration")

    EmitSoundOn("Hero_Mars.Shield.Block", this.caster)
    EmitSoundOn("Hero_Mars.Block_Projectile", this.caster)

    this.caster.AddNewModifier(
		this.caster, -- player source
		this, -- ability source
        "modifier_mars_counter_countering", 
		{ duration = duration } -- kv
   )

    const particleId = ParticleManager.CreateParticle("particles/econ/items/ogre_magi/ogre_ti8_immortal_weapon/ogre_ti8_immortal_bloodlust_buff_circle_outer_pulse.vpcf", ParticleAttachment.ABSORIGIN_FOLLOW, this.caster)
	ParticleManager.ReleaseParticleIndex(particleId)
}

