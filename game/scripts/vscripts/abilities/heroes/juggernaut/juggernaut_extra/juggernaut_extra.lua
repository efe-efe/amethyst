juggernaut_extra = class({})
juggernaut_extra_recast = class({})
LinkLuaModifier("modifier_juggernaut_extra_ward", "abilities/heroes/juggernaut/juggernaut_extra/modifier_juggernaut_extra_ward", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_juggernaut_extra_recast", "abilities/heroes/juggernaut/juggernaut_extra/modifier_juggernaut_extra_recast", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_juggernaut_extra", "abilities/heroes/juggernaut/juggernaut_extra/modifier_juggernaut_extra", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_juggernaut_extra_shield", "abilities/heroes/juggernaut/juggernaut_extra/modifier_juggernaut_extra_shield", LUA_MODIFIER_MOTION_NONE)

function juggernaut_extra:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_2 end
function juggernaut_extra:GetPlaybackRateOverride() 	return 2.0 end
function juggernaut_extra:GetCastPointSpeed() 			return 10 end

function juggernaut_extra:OnSpellStart()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
    local radius = self:GetSpecialValueFor("radius")
    local shield = self:GetSpecialValueFor("shield")    
	local point = ClampPosition(caster:GetOrigin(), CustomAbilitiesLegacy:GetCursorPosition(self), self:GetCastRange(Vector(0,0,0), nil), nil)

    local healing_ward = CreateUnitByName(
        "npc_dota_creature_juggernaut_healing_totem", 
        point, 
        true, 
        caster, 
        caster, 
        caster:GetTeam()
   )

	healing_ward:SetControllableByPlayer(caster:GetPlayerID(), true)
    if self:GetLevel() >= 2 then
        ApplyCallbackForUnitsInArea(caster, point, radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, function(unit)
            if unit ~= healing_ward then
                unit:AddNewModifier(unit, self, "modifier_juggernaut_extra_shield", { duration = 6.0, damage_block = shield })
            end
        end)
    end

	-- Prevent nearby units from getting stuck
	ResolveNPCPositions(healing_ward:GetAbsOrigin(), healing_ward:GetHullRadius() + healing_ward:GetCollisionPadding())
    healing_ward:AddNewModifier(caster, self, "modifier_juggernaut_extra_ward", { duration = duration })
    caster:FindAbilityByName("juggernaut_extra_recast"):SetHealingWardIndex(healing_ward:GetEntityIndex())
    caster:AddNewModifier(caster, self, "modifier_juggernaut_extra_recast", { duration = duration })

    EmitSoundOn('Hero_Juggernaut.HealingWard.Cast', caster)

    local efx = EFX('particles/econ/items/undying/fall20_undying_head/fall20_undying_soul_rip_heal.vpcf', PATTACH_CUSTOMORIGIN, healing_ward, {})
    ParticleManager:SetParticleControlEnt(efx, 0, healing_ward, PATTACH_POINT_FOLLOW, "attach_hitloc", healing_ward:GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(efx, 1, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true)
    ParticleManager:ReleaseParticleIndex(efx)

    
	if caster:HasModifier("modifier_upgrade_juggernaut_spinning_ward") then
        healing_ward:AddNewModifier(caster, self, "modifier_juggernaut_mobility", { duration = duration })
	end
end

function juggernaut_extra:OnUpgrade()
	CustomAbilitiesLegacy:LinkUpgrades(self, "juggernaut_extra_recast")
end

function juggernaut_extra_recast:OnSpellStart()
    local caster = self:GetCaster()
    local point = CustomAbilitiesLegacy:GetCursorPosition(self)
    
    local healing_ward = EntIndexToHScript(self.healing_ward_index) 

    healing_ward:MoveToPosition(point)

    self:PlayEffects(point)
end

function juggernaut_extra_recast:SetHealingWardIndex(healing_ward_index)
    self.healing_ward_index = healing_ward_index
end

function juggernaut_extra_recast:PlayEffects(point)
    local particle_cast = "particles/ui_mouseactions/clicked_basemove.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect_cast, 0, point)
    ParticleManager:SetParticleControl(effect_cast, 1, Vector(0,255,0))
end

function juggernaut_extra_recast:OnUpgrade()
	CustomAbilitiesLegacy:LinkUpgrades(self, "juggernaut_extra")
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(juggernaut_extra)