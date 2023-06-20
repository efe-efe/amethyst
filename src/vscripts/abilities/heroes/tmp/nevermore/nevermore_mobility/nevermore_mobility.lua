nevermore_mobility = class({})
LinkLuaModifier("modifier_nevermore_mobility_hit", "abilities/heroes/nevermore/nevermore_mobility/modifier_nevermore_mobility_hit", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_mobility_displacement", "abilities/heroes/nevermore/nevermore_mobility/modifier_nevermore_mobility_displacement", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_nevermore_souls", "abilities/heroes/nevermore/nevermore_shared_modifiers/modifier_nevermore_souls", LUA_MODIFIER_MOTION_NONE)

GetAnimation(){		return GameActivity.DOTA_RAZE_1 }
GetPlaybackRateOverride(){ 		return 1.1 }
GetCastingCrawl(){ 			return 0 }

OnSpellStart(){
    
    const origin = this.caster.GetAbsOrigin()

    const min_range = this.GetSpecialValueFor("min_range")
	const point = ClampPosition(origin, CustomAbilitiesLegacy:GetCursorPosition(this), this.GetCastRange(Vector(0,0,0), undefined), min_range)

    const direction = (point - origin):Normalized()
    const distance = (point - origin):Length2D()

    this.caster.AddNewModifier(
        this.caster, -- player source
        this, -- ability source
        "modifier_nevermore_mobility_displacement", -- modifier name
        {
            x = direction.x,
            y = direction.y,
            r = distance,
            speed = distance/0.4,
            peak = 0,
        }
   )

    this.PlayEffectsOnCast()
}


PlayEffectsOnCast(){
    EmitSoundOn("Hero_Nevermore.Death", this.caster)
}


if(IsClient() ) { require("wrappers/abilities") }
Abilities.Castpoint(nevermore_mobility)