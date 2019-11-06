spectre_ultimate = class({})
LinkLuaModifier( "modifier_spectre_ultimate_thinker", "abilities/heroes/spectre/spectre_ultimate/modifier_spectre_ultimate_thinker", LUA_MODIFIER_MOTION_NONE )

function spectre_ultimate:OnSpellStart()
	EmitGlobalSound("Hero_Spectre.Haunt")
end

--------------------------------------------------------------------------------
-- Ability Start
function spectre_ultimate:OnCastPointEnd( )
	-- unit identifier
	local caster = self:GetCaster()
	local delay_time = self:GetSpecialValueFor( "delay_time" )
	local duration = self:GetSpecialValueFor( "duration" )
	local radius = self:GetSpecialValueFor( "radius" )
	local point = CalcRange(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)

	CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_thinker_indicator", --modifierName
		{ 
			thinker = "modifier_spectre_ultimate_thinker",
			show_all = 1,
			radius = radius,
			delay_time = delay_time,
		}, --paramTable
		point, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)
end

--------------------------------------------------------------------------------
-- Graphics & sounds
function spectre_ultimate:PlayEffectsOnCast(pos)
	local caster = self:GetCaster()

end

if IsClient() then require("abilities") end
Abilities.Initialize( 
	spectre_ultimate,
	{ activity = ACT_DOTA_CAST_ABILITY_1, rate = 0.6 },
	{ movement_speed = 0 }
)