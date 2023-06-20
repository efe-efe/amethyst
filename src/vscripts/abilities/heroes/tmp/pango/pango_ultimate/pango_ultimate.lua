pango_ultimate = class({})
LinkLuaModifier("modifier_pango_ultimate_displacement", "abilities/heroes/pango/pango_ultimate/modifier_pango_ultimate_displacement", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_pango_mobility_displacement_enemy", "abilities/heroes/pango/pango_ultimate/modifier_pango_mobility_displacement_enemy", LUA_MODIFIER_MOTION_BOTH)

GetAnimation(){		return GameActivity.DOTA_CAST_ABILITY_4 }
GetPlaybackRateOverride(){ 	    return 1.0 }
GetCastingCrawl(){ 			return 0 }

OnAbilityPhaseStart(){
    this.efx = EFX("particles/units/heroes/hero_pangolier/pangolier_gyroshell_cast.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
        cp0 = this.caster.GetAbsOrigin(),
        cp3 = this.caster.GetAbsOrigin(),
        cp5 = this.caster.GetAbsOrigin()
    })
    EmitSoundOn("Hero_Pangolier.Gyroshell.Cast", this.caster)
    return true
}

OnAbilityPhaseInterrupted(){
	DEFX(this.efx, false)
	StopSoundOn("Hero_Pangolier.Gyroshell.Cast", this.caster)
}

OnSpellStart(){
    DEFX(this.efx, false)
	
	const origin = this.caster.GetAbsOrigin()
	const point = CustomAbilitiesLegacy:GetCursorPosition(this)
	const direction = (point - origin):Normalized()
    const distance = this.GetCastRange(Vector(0,0,0), undefined)

    this.caster.AddNewModifier(
        this.caster, -- player source
        this, -- ability source
        "modifier_pango_ultimate_displacement", -- modifier name
        {
            x = direction.x,
            y = direction.y,
            r = 2000,
            speed = 2500,
            peak = 1,
        }
    )

    EmitSoundOn("Hero_Pangolier.Swashbuckle.Cast", this.caster)
}

if(IsClient() ) { require("wrappers/abilities") }
Abilities.Castpoint(pango_ultimate)