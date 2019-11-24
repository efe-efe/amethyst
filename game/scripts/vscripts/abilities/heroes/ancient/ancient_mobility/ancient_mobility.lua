ancient_mobility = class({})
LinkLuaModifier( "modifier_ancient_mobility_thinker", "abilities/heroes/ancient/ancient_mobility/modifier_ancient_mobility_thinker", LUA_MODIFIER_MOTION_NONE )

function ancient_mobility:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = CalcRange(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)
	local delay_time = self:GetSpecialValueFor( "delay_time" )
	local radius = self:GetSpecialValueFor("radius")

	CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_thinker_indicator", --modifierName
		{ 
			thinker = "modifier_ancient_mobility_thinker",
			show_all = 1,
			radius = radius,
			delay_time = delay_time,
			draw_clock = 1
		}, --paramTable
		point, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)

	-- effects
	self:PlayEffects( )
end

--------------------------------------------------------------------------------
function ancient_mobility:PlayEffects( )
	local sound_cast = "Hero_Ancient_Apparition.IceVortexCast"
	EmitSoundOn( sound_cast, self:GetCaster() )
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	ancient_mobility,
	nil,
	{ movement_speed = 10 }
)