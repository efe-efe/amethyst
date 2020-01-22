ancient_extra = class({})
LinkLuaModifier( "modifier_ancient_extra_thinker", "abilities/heroes/ancient/ancient_extra/modifier_ancient_extra_thinker", LUA_MODIFIER_MOTION_NONE )

function ancient_extra:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = CalcPoint(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)
	local duration = self:GetSpecialValueFor( "duration" )
	local delay_time = self:GetSpecialValueFor( "delay_time" )
	local radius = self:GetSpecialValueFor("radius")
	local stun_radius = self:GetSpecialValueFor("stun_radius")
	
	CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_thinker_indicator", --modifierName
		{ 
			thinker = "modifier_ancient_extra_thinker",
			show_all = 1,
			radius = radius,
			delay_time = delay_time,
			thinker_duration = duration + delay_time,
			draw_clock = 1,
		}, --paramTable
		point, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)

	CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_thinker_indicator", --modifierName
		{ 
			show_all = 1,
			radius = stun_radius,
			delay_time = delay_time,
		}, --paramTable
		point, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)

	-- effects
	self:PlayEffects( )
end

--------------------------------------------------------------------------------
function ancient_extra:PlayEffects( )
	local sound_cast = "Hero_Ancient_Apparition.IceVortexCast"
	EmitSoundOn( sound_cast, self:GetCaster() )
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	ancient_extra,
	{ activity = ACT_DOTA_ICE_VORTEX, rate = 1.0 },
	{ movement_speed = 10 }
)