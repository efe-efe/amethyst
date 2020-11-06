juggernaut_counter = class({})
juggernaut_ex_counter = class({})

LinkLuaModifier("modifier_juggernaut_counter_countering", "abilities/heroes/juggernaut/juggernaut_counter/modifier_juggernaut_counter_countering", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_juggernaut_counter_recast", "abilities/heroes/juggernaut/juggernaut_counter/modifier_juggernaut_counter_recast", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_juggernaut_counter", "abilities/heroes/juggernaut/juggernaut_counter/modifier_juggernaut_counter", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_juggernaut_ex_counter", "abilities/heroes/juggernaut/juggernaut_counter/modifier_juggernaut_ex_counter", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_juggernaut_ex_counter_recast", "abilities/heroes/juggernaut/juggernaut_counter/modifier_juggernaut_ex_counter_recast", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_juggernaut_ex_counter_slashes", "abilities/heroes/juggernaut/juggernaut_counter/modifier_juggernaut_ex_counter_slashes", LUA_MODIFIER_MOTION_NONE)

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

function juggernaut_ex_counter:GetCastAnimationCustom()		return ACT_DOTA_TAUNT end
function juggernaut_ex_counter:GetPlaybackRateOverride() 	return 2.0 end
function juggernaut_ex_counter:GetCastPointSpeed() 			return 10 end
function juggernaut_ex_counter:GetAnimationTranslate()		return "odachi" end

function juggernaut_ex_counter:OnSpellStart()
   local caster = self:GetCaster()
   local origin = caster:GetOrigin()
   local min_range = self:GetSpecialValueFor("min_range")
   local point = Clamp(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), min_range)
   local damage = self:GetSpecialValueFor("ability_damage")
   local duration = self:GetSpecialValueFor("duration")

   FindClearSpaceForUnit(caster, point , true)

   local new_origin = caster:GetOrigin()

   local enemies = caster:FindUnitsInLine(
      new_origin, 
      origin, 
      100, 
      DOTA_UNIT_TARGET_TEAM_ENEMY, 
      DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
      DOTA_UNIT_TARGET_FLAG_NONE
   )

   local filtered_enemies = {}
   local counter = 0

   for _,enemy in pairs(enemies) do
      if  (not enemy:IsObstacle()) and 
      (not enemy:IsCountering())
      then
         counter = counter + 1
         filtered_enemies[counter] = enemy
      end
   end

   for _,enemy in pairs(enemies) do
      local damage_table = {
         victim = enemy,
         attacker = caster,
         damage = damage,
         damage_type = DAMAGE_TYPE_PHYSICAL,
      }
      ApplyDamage(damage_table)
      
      self:PlayEffectsOnTarget(enemy)
   end

   if #filtered_enemies > 0 then
      local modifier = caster:AddNewModifier(caster, self, 'modifier_juggernaut_ex_counter', { duration = duration })
      modifier:SetStackCount(#filtered_enemies)

      if self:GetLevel() >= 2 then
         local modifier = caster:AddNewModifier(
            caster,
            self,
            "modifier_juggernaut_ex_counter_slashes",
            {}
         )
         
         if modifier:GetStackCount() < self:GetSpecialValueFor("recasts") then
            caster:AddNewModifier(
               caster,
               self,
               "modifier_juggernaut_ex_counter_recast",
               { duration = 5.0 }
            )
         else
            caster:RemoveModifierByName("modifier_juggernaut_ex_counter_slashes")
         end
      end
   end

   self:PlayEffects(origin, new_origin)
end

function juggernaut_ex_counter:PlayEffects(origin, new_origin)
	EmitSoundOn("Hero_Juggernaut.BladeDance", self:GetCaster())
	local particle_cast = "particles/juggernaut/juggernaut_ex_counter.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect_cast, 0, origin)
	ParticleManager:SetParticleControl(effect_cast, 1, new_origin)
	ParticleManager:ReleaseParticleIndex(effect_cast)    
end

function juggernaut_ex_counter:PlayEffectsOnTarget(hTarget)
   EmitSoundOn("Hero_Juggernaut.BladeDance.Arcana", hTarget)
   EmitSoundOn("Hero_Juggernaut.BladeDance.Layer", hTarget)
   EmitSoundOn("Hero_Juggernaut.Attack", hTarget)
end

function juggernaut_ex_counter:PlayEffectsOnMiss()
   EmitSoundOn("Hero_Juggernaut.Attack", self:GetCaster())
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(juggernaut_ex_counter)
Abilities.Tie(juggernaut_ex_counter, 'juggernaut_counter')
Abilities.Tie(juggernaut_counter, 'juggernaut_ex_counter')