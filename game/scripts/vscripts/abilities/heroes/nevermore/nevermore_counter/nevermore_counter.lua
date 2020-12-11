nevermore_counter = class({})
nevermore_ex_counter = class({})

LinkLuaModifier("modifier_nevermore_counter_banish", "abilities/heroes/nevermore/nevermore_counter/modifier_nevermore_counter_banish", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_counter_countering", "abilities/heroes/nevermore/nevermore_counter/modifier_nevermore_counter_countering", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_counter_thinker", "abilities/heroes/nevermore/nevermore_counter/modifier_nevermore_counter_thinker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_counter_fear", "abilities/heroes/nevermore/nevermore_counter/modifier_nevermore_counter_fear", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_counter_banish_no_indicator", "abilities/heroes/nevermore/nevermore_counter/modifier_nevermore_counter_banish_no_indicator", LUA_MODIFIER_MOTION_NONE)


function nevermore_counter:OnSpellStart()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("counter_duration")

    caster:AddNewModifier(
      caster, -- player source
      self, -- ability source
      "modifier_nevermore_counter_countering", -- modifier name
      { duration = duration } -- kv
   )
   LinkAbilityCooldowns(caster, 'nevermore_ex_counter')
end

function nevermore_counter:PlayEffectsFear()
   local origin = self:GetCaster():GetAbsOrigin()

   EFX("particles/econ/events/ti4/blink_dagger_end_ti4.vpcf", PATTACH_WORLDORIGIN, nil, {
      cp0 = origin,
      release = true,
   })
   
   local efx = EFX("particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf", PATTACH_WORLDORIGIN, nil, {
      cp0 = origin,
   })
	ParticleManager:SetParticleControl(efx, 60, Vector(157, 0, 243))
	ParticleManager:SetParticleControl(efx, 61, Vector(1, 0, 0))
	ParticleManager:ReleaseParticleIndex(efx)
   
   EFX("particles/econ/items/outworld_devourer/od_ti8/od_ti8_santies_eclipse_area_shockwave.vpcf", PATTACH_WORLDORIGIN, nil, {
      cp0 = origin,
      release = true,
   })

	ScreenShake(origin, 100, 300, 0.45, 1000, 0, true)
end

nevermore_ex_counter.PlayEffectsFear = nevermore_counter.PlayEffectsFear

function nevermore_ex_counter:GetCastAnimationCustom()	return ACT_DOTA_RAZE_2 end
function nevermore_ex_counter:GetPlaybackRateOverride() 	return 1.3 end
function nevermore_ex_counter:GetCastPointSpeed() 		return 0 end
function nevermore_ex_counter:OnSpellStart()
   local caster = self:GetCaster()
   local origin = caster:GetAbsOrigin()
   local duration = self:GetSpecialValueFor('fear_duration')
   local radius = self:GetSpecialValueFor('radius')
   local damage_table = {
      attacker = caster,
      damage = self:GetSpecialValueFor("ability_damage"),
      damage_type = DAMAGE_TYPE_PURE,
   }

   CreateRadiusMarker(caster, origin, radius, RADIUS_SCOPE_PUBLIC, 0.1)
   
   ApplyCallbackForUnitsInArea(caster, origin, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)
      damage_table.victim = unit
      ApplyDamage(damage_table)
      unit:AddNewModifier(caster, self, 'modifier_nevermore_counter_fear', { duration = duration })
   end)

   self:PlayEffectsFear()
   EmitSoundOn('Hero_Nevermore.Shadowraze.Arcana', caster)
   EmitSoundOn('nevermore_nev_arc_ability_shadow_24', caster)
   LinkAbilityCooldowns(caster, 'nevermore_counter')
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(nevermore_ex_counter)

