pango_counter = class({})
LinkLuaModifier("modifier_pango_counter_countering", "abilities/heroes/pango/pango_counter/modifier_pango_counter_countering", LUA_MODIFIER_MOTION_NONE)

OnSpellStart(){
    
	const duration = this.GetSpecialValueFor("counter_duration")

    this.caster.AddNewModifier(
		this.caster,
		this,
        "modifier_pango_counter_countering", 
		{ duration = duration }
	)
}