ancient_ultimate = class({})


function ancient_ultimate:OnCastPointEnd()
    local caster = self:GetCaster()
    local duration = 3.0

    caster:AddNewModifier(
        caster, -- player source
		self, -- ability source
		"modifier_channeling", -- modifier name
		{ 
            duration = duration,
            style = "Ultimate",
            title = "ultimate",
            movement_speed = 0,
            channeling_tick = 1.0,
            immediate = 1,
        } -- kv
    )
end

function ancient_ultimate:OnChannelingStart()
    CustomGameEventManager:Send_ServerToAllClients( "change_distance_offset", { offset = 600.0, lerp = 50 })
end

function ancient_ultimate:OnChannelingEnd()
    CustomGameEventManager:Send_ServerToAllClients( "change_distance_offset", { offset = 0.0, lerp = 50 })
end

function ancient_ultimate:OnChannelingTick()
    local caster = self:GetCaster()
    local ability = caster:FindAbilityByName("ancient_ultimate_projectile")
    caster:CastAbilityImmediately(ability, caster:GetEntityIndex())
end

if IsClient() then require("abilities") end
Abilities.Initialize( 
	ancient_ultimate,
	{ activity = ACT_DOTA_CAST_ABILITY_1, rate = 1.3 },
	{ movement_speed = 0 }
)
