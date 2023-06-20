nevermore_counter = class({})
nevermore_ex_counter = class({})

LinkLuaModifier("modifier_nevermore_counter_banish", "abilities/heroes/nevermore/nevermore_counter/modifier_nevermore_counter_banish", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_counter_countering", "abilities/heroes/nevermore/nevermore_counter/modifier_nevermore_counter_countering", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_counter_thinker", "abilities/heroes/nevermore/nevermore_counter/modifier_nevermore_counter_thinker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_counter_fear", "abilities/heroes/nevermore/nevermore_counter/modifier_nevermore_counter_fear", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_counter_banish_no_indicator", "abilities/heroes/nevermore/nevermore_counter/modifier_nevermore_counter_banish_no_indicator", LUA_MODIFIER_MOTION_NONE)


OnSpellStart(){
    
    const duration = this.GetSpecialValueFor("counter_duration")

    this.caster.AddNewModifier(
      this.caster, -- player source
      this, -- ability source
      "modifier_nevermore_counter_countering", -- modifier name
      { duration = duration } -- kv
   )
   LinkAbilityCooldowns(this.caster, 'nevermore_ex_counter')
}

function nevermore_counter:PlayEffectsFear()
   const origin = this.caster.GetAbsOrigin()

   EFX("particles/econ/events/ti4/blink_dagger_end_ti4.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
      cp0 = origin,
      release = true,
   })
   
   const efx = EFX("particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
      cp0 = origin,
   })
	ParticleManager.SetParticleControl(efx, 60, Vector(157, 0, 243))
	ParticleManager.SetParticleControl(efx, 61, Vector(1, 0, 0))
	ParticleManager.ReleaseParticleIndex(efx)
   
   EFX("particles/econ/items/outworld_devourer/od_ti8/od_ti8_santies_eclipse_area_shockwave.vpcf", ParticleAttachment.WORLDORIGIN, undefined, {
      cp0 = origin,
      release = true,
   })

	ScreenShake(origin, 100, 300, 0.45, 1000, 0, true)
}

nevermore_ex_counter.PlayEffectsFear = nevermore_counter.PlayEffectsFear

GetAnimation(){	return GameActivity.DOTA_RAZE_2 }
GetPlaybackRateOverride(){ 	return 1.3 }
GetCastingCrawl(){ 		return 0 }
OnSpellStart(){
   
   const origin = this.caster.GetAbsOrigin()
   const duration = this.GetSpecialValueFor('fear_duration')
   const radius = this.GetSpecialValueFor('radius')
   const damage_table = {
      attacker = this.caster,
      damage = this.GetSpecialValueFor("ability_damage"),
      damage_type = DamageTypes.PURE,
   }

   CreateRadiusMarker(this.caster, origin, radius, RADIUS_SCOPE_PUBLIC, 0.1)
   
   ApplyCallbackForUnitsInArea(this.caster, origin, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)
      damage_table.victim = unit
      ApplyDamage(damage_table)
      unit:AddNewModifier(this.caster, this, 'modifier_nevermore_counter_fear', { duration = duration })
   })

   this.PlayEffectsFear()
   EmitSoundOn('Hero_Nevermore.Shadowraze.Arcana', this.caster)
   EmitSoundOn('nevermore_nev_arc_ability_shadow_24', this.caster)
   LinkAbilityCooldowns(this.caster, 'nevermore_counter')
}

if(IsClient() ) { require("wrappers/abilities") }
Abilities.Castpoint(nevermore_ex_counter)

