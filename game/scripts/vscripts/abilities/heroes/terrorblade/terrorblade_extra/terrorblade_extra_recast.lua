terrorblade_extra_recast = class({})

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
    terrorblade_extra_recast,
	{ activity = ACT_DOTA_CAST_ABILITY_3, rate = 0.5 },
	{ movement_speed = 10 },
	{ modifier_name = "modifier_terrorblade_extra_recast" }
)