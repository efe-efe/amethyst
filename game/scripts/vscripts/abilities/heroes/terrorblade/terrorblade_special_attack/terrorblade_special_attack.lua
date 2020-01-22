terrorblade_special_attack = class({})
LinkLuaModifier( "terrorblade_special_attack_blade", "abilities/heroes/terrorblade/terrorblade_special_attack/terrorblade_special_attack_blade", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_terrorblade_special_attack_recast", "abilities/heroes/terrorblade/terrorblade_special_attack/modifier_terrorblade_special_attack_recast", LUA_MODIFIER_MOTION_NONE )

function terrorblade_special_attack:OnCastPointEnd()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
	local point = CalcPoint(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)
    local ability = caster:FindAbilityByName("terrorblade_special_attack_recast")

    -- Spawn the Healing Ward
    local blade = CreateUnitByName(
        "npc_dota_creature_terrorblade_blade", 
        point, 
        true, 
        caster, 
        caster, 
        caster:GetTeam()
    )

	blade:SetControllableByPlayer(caster:GetPlayerID(), true)
	-- Prevent nearby units from getting stuck
	ResolveNPCPositions(blade:GetAbsOrigin(), blade:GetHullRadius() + blade:GetCollisionPadding())
    blade:AddNewModifier(caster, self, "terrorblade_special_attack_blade", { duration = duration })
    caster:AddNewModifier(caster, self, "modifier_terrorblade_special_attack_recast", { duration = duration })

    ability:SetBladeIndex(blade:GetEntityIndex())

    EmitSoundOn("Hero_Terrorblade.Sunder.Target", blade)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
    terrorblade_special_attack,
	{ activity = ACT_DOTA_CAST_ABILITY_4, rate = 1.2 },
	{ movement_speed = 10 }
)
