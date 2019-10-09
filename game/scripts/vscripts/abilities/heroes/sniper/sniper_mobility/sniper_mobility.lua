sniper_mobility = class({})
LinkLuaModifier( "modifier_sniper_mobility_thinker", "abilities/heroes/sniper/sniper_mobility/modifier_sniper_mobility_thinker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_shrapnel_thinker_lua", "abilities/heroes/sniper/sniper_shared_modifiers/modifier_sniper_shrapnel_thinker_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function sniper_mobility:OnCastPointEnd()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = CalcRange(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)
    local shrapnel = caster:FindAbilityByName("sniper_special_attack")

	local direction = (point - origin):Normalized()
	local distance = (point - origin):Length2D()

    -- Effect thinker
    CreateModifierThinker(
        caster, --hCaster
        self, --hAbility
        "modifier_sniper_mobility_thinker", --modifierName
        {
			x = direction.x,
			y = direction.y,
			distance = distance
		}, --paramTable
        caster:GetOrigin(), --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        false --bPhantomBlocker
    )

	CreateModifierThinker(
		caster, --hCaster
		shrapnel, --hAbility
		"modifier_thinker_indicator", --modifierName
		{ 
			thinker = "modifier_sniper_shrapnel_thinker_lua",
			show_all = 1,
			radius = self.radius,
			delay_time = shrapnel:GetSpecialValueFor( "delay_time" ),
			thinker_duration = shrapnel:GetSpecialValueFor( "duration" ),
		}, --paramTable
		caster:GetOrigin(), --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)

    self:PlayEffects()
end

function sniper_mobility:PlayEffects()
    local sound_cast = "Hero_Techies.LandMine.Detonate"
    EmitSoundOn( sound_cast, self:GetCaster() )	
end

if IsClient() then require("abilities") end
Abilities.Initialize( 
	sniper_mobility,
	{ activity = ACT_DOTA_CAST_ABILITY_1, rate = 2.0 },
	{ movement_speed = 10 }
)