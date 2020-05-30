juggernaut_counter = class({})
LinkLuaModifier( "modifier_juggernaut_counter_countering", "abilities/heroes/juggernaut/juggernaut_counter/modifier_juggernaut_counter_countering", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_juggernaut_counter_recast", "abilities/heroes/juggernaut/juggernaut_counter/modifier_juggernaut_counter_recast", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_juggernaut_counter", "abilities/heroes/juggernaut/juggernaut_counter/modifier_juggernaut_counter", LUA_MODIFIER_MOTION_NONE )

function juggernaut_counter:OnSpellStart()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("counter_duration")
    
    caster:AddNewModifier(
      caster, -- player source
      self, -- ability source
      "modifier_juggernaut_counter_countering", -- modifier name
      { duration = duration }
    )
end