juggernaut_counter_helper = class({})
juggernaut_counter = class({})

LinkLuaModifier("modifier_juggernaut_counter_countering", "abilities/heroes/juggernaut/juggernaut_counter/modifier_juggernaut_counter_countering", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_juggernaut_counter_recast", "abilities/heroes/juggernaut/juggernaut_counter/modifier_juggernaut_counter_recast", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_juggernaut_counter", "abilities/heroes/juggernaut/juggernaut_counter/modifier_juggernaut_counter", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_juggernaut_ex_counter", "abilities/heroes/juggernaut/juggernaut_counter/modifier_juggernaut_ex_counter", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_juggernaut_ex_counter_recast", "abilities/heroes/juggernaut/juggernaut_counter/modifier_juggernaut_ex_counter_recast", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_juggernaut_ex_counter_slashes", "abilities/heroes/juggernaut/juggernaut_counter/modifier_juggernaut_ex_counter_slashes", LUA_MODIFIER_MOTION_NONE)

function juggernaut_counter:OnSpellStart()
   local caster = self:GetCaster()
   local duration = self:GetSpecialValueFor("counter_duration")
   caster:AddNewModifier(caster, self, "modifier_juggernaut_counter_countering", { duration = duration })
   LinkAbilityCooldowns(caster, 'juggernaut_ex_counter')
end

function juggernaut_counter_helper:Slash(vPoint, iDamage)
   local caster = self:GetCaster()
   local modifier = caster:AddNewModifier(caster, self, self:GetRecastCounterModifierName(), {})
   local recasts = modifier:GetStackCount()
   local origin = caster:GetOrigin()
   
   FindClearSpaceForUnit(caster, vPoint, true)

   local valid_targets = 0
	local new_origin = caster:GetOrigin()
	local enemies = caster:FindUnitsInLine(
		new_origin, 
		origin, 
		100, 
		DOTA_UNIT_TARGET_TEAM_ENEMY, 
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
		DOTA_UNIT_TARGET_FLAG_NONE
   )
   local damage_table = {
      attacker = caster,
      damage = iDamage,
      damage_type = DAMAGE_TYPE_PHYSICAL,
   }
	
   for _,enemy in pairs(enemies) do
      if self:ProvidesRecast(enemy) then
         valid_targets = valid_targets + 1
      end
   end

	for _,enemy in pairs(enemies) do
      damage_table.victim = enemy
		ApplyDamage(damage_table)
		self:PlayEffectsOnTarget(enemy)
	end

   if valid_targets >= 1 then
      self:OnSlashHitValidTargets(caster, valid_targets)
      if self:ShouldRecast(recasts) then
         self:RecastLogic(caster)
      else
         caster:RemoveModifierByName(self:GetRecastCounterModifierName())
         self:PlayEffectsOnMiss(caster)
      end
   else
      caster:RemoveModifierByName(self:GetRecastCounterModifierName())
      self:PlayEffectsOnMiss(caster)
   end
   
   self:PlayEffectsOnSlash(origin, new_origin)
end

function juggernaut_counter_helper:ProvidesRecast(hTarget)
   return not(hTarget:IsObstacle() or hTarget:IsCountering())
end

function juggernaut_counter_helper:ShouldRecast(iRecasts) 
   return iRecasts < self:GetMaxRecasts() and self:GetLevel() >= self:GetRecastLevelRequired()
end

function juggernaut_counter_helper:RecastLogic(hCaster)
   hCaster:AddNewModifier(
      hCaster,
      self:GetRecastAbility(),
      self:GetRecastModifierName(),
      { duration = 5.0 }
   )
end

function juggernaut_counter_helper:PlayEffectsOnTarget(hTarget)
   EmitSoundOn("Hero_Juggernaut.BladeDance.Arcana", hTarget)
   EmitSoundOn("Hero_Juggernaut.BladeDance.Layer", hTarget)
   EmitSoundOn("Hero_Juggernaut.Attack", hTarget)
end

function juggernaut_counter_helper:PlayEffectsOnMiss(hCaster)
   EmitSoundOn("Hero_Juggernaut.Attack", hCaster)
end

function juggernaut_counter_helper:GetRecastLevelRequired()
   return 1
end

function juggernaut_counter_helper:GetRecastAbility() 
   return self 
end

function juggernaut_counter_helper:OnSlashHitValidTargets(hCaster, iValidTargets) end
function juggernaut_counter_helper:PlayEffectsOnSlash(vOrigin, vNewOrigin) end
function juggernaut_counter_helper:GetRecastCounterModifierName() end
function juggernaut_counter_helper:GetMaxRecasts()
   return self:GetRecastAbility():GetSpecialValueFor("recasts")
end
function juggernaut_counter_helper:GetRecastModifierName(hCaster) end

juggernaut_counter_recast = class(juggernaut_counter_helper)
juggernaut_ex_counter = class(juggernaut_counter_helper)

function juggernaut_counter_recast:OnSpellStart()
   local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local min_range = self:GetSpecialValueFor("min_range")
	local point = ClampPosition(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), min_range)
   local damage = self:GetRecastAbility():GetSpecialValueFor("ability_damage")
   local juggernaut_ex_counter = caster:FindAbilityByName("juggernaut_ex_counter")
   self:Slash(point, damage)

   self:GetRecastAbility():StartCooldown(self:GetRecastAbility():GetCooldown(0))
   juggernaut_ex_counter:StartCooldown(juggernaut_ex_counter:GetCooldown(0))
end

function juggernaut_counter_recast:GetRecastCounterModifierName() return   "modifier_juggernaut_counter" end
function juggernaut_counter_recast:GetRecastModifierName() return          "modifier_juggernaut_counter_recast" end
function juggernaut_counter_recast:GetRecastAbility() return               self:GetCaster():FindAbilityByName("juggernaut_counter") end

function juggernaut_counter_recast:PlayEffectsOnSlash(vOrigin, vNewOrigin)
   EFX("particles/juggernaut/juggernaut_counter_recast.vpcf", PATTACH_WORLDORIGIN, nil, {
      cp0 = vOrigin,
      cp1 = vNewOrigin,
      release = true
   })  
end

function juggernaut_ex_counter:GetCastAnimationCustom()		return ACT_DOTA_TAUNT end
function juggernaut_ex_counter:GetPlaybackRateOverride() 	return 2.0 end
function juggernaut_ex_counter:GetCastPointSpeed() 			return 10 end
function juggernaut_ex_counter:GetAnimationTranslate()		return "odachi" end

function juggernaut_ex_counter:OnSpellStart()
   local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local min_range = self:GetSpecialValueFor("min_range")
	local point = ClampPosition(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), min_range)
   local damage = self:GetRecastAbility():GetSpecialValueFor("ability_damage")

   self:Slash(point, damage)
   LinkAbilityCooldowns(caster, 'juggernaut_counter')
end

function juggernaut_ex_counter:GetManaCost(iLevel)
   if self:GetCaster():HasModifier('modifier_juggernaut_ex_counter_recast') then
       return 0
   end
   return self.BaseClass.GetManaCost( self, iLevel )
end

function juggernaut_ex_counter:GetRecastCounterModifierName() return       "modifier_juggernaut_ex_counter_slashes" end
function juggernaut_ex_counter:GetRecastModifierName() return              "modifier_juggernaut_ex_counter_recast" end
function juggernaut_ex_counter:GetRecastLevelRequired() return             2 end

function juggernaut_ex_counter:OnSlashHitValidTargets(hCaster, iValidTargets)
   local duration = self:GetSpecialValueFor("duration")
   hCaster:AddNewModifier(hCaster, self, 'modifier_juggernaut_ex_counter', { 
      duration = duration,
      stacks =  iValidTargets
   })
end

function juggernaut_ex_counter:PlayEffectsOnSlash(vOrigin, vNewOrigin)
   EmitSoundOn("Hero_Juggernaut.BladeDance", self:GetCaster())
   
   EFX("particles/juggernaut/juggernaut_ex_counter.vpcf", PATTACH_WORLDORIGIN, nil, {
      cp0 = vOrigin,
      cp1 = vNewOrigin,
      release = true
   })  
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(juggernaut_ex_counter)