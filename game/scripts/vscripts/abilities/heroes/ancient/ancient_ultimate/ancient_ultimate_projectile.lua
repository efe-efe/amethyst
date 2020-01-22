ancient_ultimate_projectile = class({})
LinkLuaModifier( "modifier_ancient_ultimate_thinker", "abilities/heroes/ancient/ancient_ultimate/modifier_ancient_ultimate_thinker", LUA_MODIFIER_MOTION_NONE )

function ancient_ultimate_projectile:OnCastPointEnd( )
	-- Initialize variables
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()
    local point = CalcPoint(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)
	local radius = self:GetSpecialValueFor("radius")
	local delay_time = self:GetCooldown(0)
	
	CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_thinker_indicator", --modifierName
		{ 
			thinker = "modifier_ancient_ultimate_thinker",
			show_all = 1,
			radius = radius,
			delay_time = delay_time,
		}, --paramTable
		point, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)

	self:PlayEffectsOnCast()
end

function ancient_ultimate_projectile:PlayEffectsOnCast()
	EmitSoundOn( "Hero_Ancient_Apparition.IceBlastRelease.Cast", self:GetCaster() )
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	ancient_ultimate_projectile,
	{ activity = ACT_DOTA_GENERIC_CHANNEL_1, rate = 1.0 },
	{ movement_speed = 0, disable_all = false },
	{ modifier_name = "modifier_ancient_ultimate_recast" }
)
