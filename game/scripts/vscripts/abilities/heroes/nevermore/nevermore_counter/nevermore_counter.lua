nevermore_counter = class({})
LinkLuaModifier( "modifier_nevermore_counter_banish", "abilities/heroes/nevermore/nevermore_counter/modifier_nevermore_counter_banish", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nevermore_counter_countering", "abilities/heroes/nevermore/nevermore_counter/modifier_nevermore_counter_countering", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nevermore_counter_thinker", "abilities/heroes/nevermore/nevermore_counter/modifier_nevermore_counter_thinker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nevermore_counter_fear", "abilities/heroes/nevermore/nevermore_counter/modifier_nevermore_counter_fear", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nevermore_counter_banish_no_indicator", "abilities/heroes/nevermore/nevermore_counter/modifier_nevermore_counter_banish_no_indicator", LUA_MODIFIER_MOTION_NONE )


function nevermore_counter:OnSpellStart()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("counter_duration")

    caster:AddNewModifier(
      caster, -- player source
      self, -- ability source
      "modifier_nevermore_counter_countering", -- modifier name
      { duration = duration } -- kv
    )
end