juggernaut_extra = class({})
LinkLuaModifier( "modifier_juggernaut_extra_ward", "abilities/heroes/juggernaut/juggernaut_extra/modifier_juggernaut_extra_ward", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_juggernaut_extra_recast", "abilities/heroes/juggernaut/juggernaut_extra/modifier_juggernaut_extra_recast", LUA_MODIFIER_MOTION_NONE )

function juggernaut_extra:OnCastPointEnd()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
	local point = CalcRange(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)

    -- Spawn the Healing Ward
    local healing_ward = CreateUnitByName(
        "npc_dota_creature_juggernaut_healing_totem", 
        point, 
        true, 
        caster, 
        caster, 
        caster:GetTeam()
    )

	healing_ward:SetControllableByPlayer(caster:GetPlayerID(), true)
    Timers:CreateTimer(0.1, function()
		healing_ward:MoveToNPC(caster)
    end)
    
	-- Prevent nearby units from getting stuck
	ResolveNPCPositions(healing_ward:GetAbsOrigin(), healing_ward:GetHullRadius() + healing_ward:GetCollisionPadding())
    healing_ward:AddNewModifier(caster, self, "modifier_juggernaut_extra_ward", { duration = duration })
    
    caster:FindAbilityByName("juggernaut_extra_recast"):SetHealingWardIndex(healing_ward:GetEntityIndex())

    caster:AddNewModifier(caster, self, "modifier_juggernaut_extra_recast", { duration = duration })
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
    juggernaut_extra,
	{ activity = ACT_DOTA_CAST_ABILITY_2, rate = 1.0 },
	{ movement_speed = 10, fixed_range = 1 }
)