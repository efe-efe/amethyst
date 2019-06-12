-- Generated from template

require('util/util')
require('util/modifiers')
require('gamemode')

function Precache( context )
	-------------------------------
    -- Sounds
    -------------------------------
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_oracle.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_magnataur.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_silencer.vsndevts", context)

	
	-------------------------------
    -- Particles
	-------------------------------
	PrecacheResource( "particle", "particles/units/heroes/hero_chen/chen_hand_of_god.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_chen/chen_divine_favor_buff.vpcf", context )
	PrecacheResource( "particle", "particles/base_attacks/ranged_badguy_persistent_glow_green.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_wisp/wisp_overcharge_c.vpcf", context )
	PrecacheResource( "particle", "models/items/rubick/rubick_arcana/sfm/particles/rubick_arcana_temp_2_rocks_glow.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_omniknight/omniknight_purification_cast_b.vpcf", context )
	
	----Wisp Guardian Essence modifier
	PrecacheResource( "particle", "particles/econ/items/antimage/antimage_weapon_tustakuri/antimage_blade_tustakuri_generic_a.vpcf", context )

	-------------------------------
    -- Models
	-------------------------------
	PrecacheResource("model", "particles/heroes/viper/viper.vmdl", context)
end

-- Create the game mode when we activate
function Activate()
	GameRules.GameMode = GameMode()
	GameRules.GameMode:InitGameMode()
end