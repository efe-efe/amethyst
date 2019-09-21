juggernaut_extra = class({})
LinkLuaModifier(
    "juggernaut_extra_ward",
    "abilities/heroes/juggernaut/juggernaut_extra/juggernaut_extra_ward", LUA_MODIFIER_MOTION_NONE
)

--------------------------------------------------------------------------------
-- Ability Start
function juggernaut_extra:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = caster:GetAttackAnimationPoint()
	StartAnimation(caster, {
        duration = cast_point + 0.1, 
        activity=ACT_DOTA_CAST_ABILITY_2, 
        rate=1.0
    })
	
	caster:AddNewModifier( caster, self, "modifier_cast_point", { 
		duration = cast_point, 
        movement_speed = 10,
        fixed_range = 1,
	})
end

function juggernaut_extra:OnCastPointEnd( point )
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
    
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

	-- Apply the Healing Ward duration modifier
	healing_ward:AddNewModifier(caster, self, "juggernaut_extra_ward", {duration = duration})
end
