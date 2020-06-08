demon_special_attack = class({})
LinkLuaModifier("modifier_demon_special_attack_thinker", "abilities/heroes/terrorblade/terrorblade_special_attack/modifier_demon_special_attack_thinker", LUA_MODIFIER_MOTION_NONE)

function demon_special_attack:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = Clamp(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)
	local delay_time = self:GetSpecialValueFor("delay_time")
	local radius = self:GetSpecialValueFor("radius")

	CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_thinker_indicator", --modifierName
		{ 
			thinker = "modifier_demon_special_attack_thinker",
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
	self:PlayEffects()
end

--------------------------------------------------------------------------------
function demon_special_attack:PlayEffects()
	local sound_cast = "Hero_Terrorblade.Metamorphosis"
	EmitSoundOn(sound_cast, self:GetCaster())
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize(
	demon_special_attack,
	{ activity = ACT_DOTA_CAST_ABILITY_2, rate = 1.5 },
	{ movement_speed = 10 }
)