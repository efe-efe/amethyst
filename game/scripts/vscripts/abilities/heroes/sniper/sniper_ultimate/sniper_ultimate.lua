sniper_ultimate = class({})
LinkLuaModifier( "modifier_sniper_ultimate_timer", "abilities/heroes/sniper/sniper_ultimate/modifier_sniper_ultimate_timer", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function sniper_ultimate:OnSpellStart()
	self:PlayEffectsOnPhase()
end

function sniper_ultimate:OnCastPointEnd()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
	local projectile = caster:FindAbilityByName("sniper_ultimate_projectile")
	
    caster:AddNewModifier(
        caster, -- player source
		self, -- ability source
		"modifier_sniper_ultimate_timer", -- modifier name
		{ duration = duration + projectile:GetCastPoint() - 0.1 } -- kv
    )
    self:PlayEffectsOnCast()
end

function sniper_ultimate:OnStopPseudoCastPoint()
	self:StopEffectsOnPhase()
end

function sniper_ultimate:PlayEffectsOnPhase()
    EmitGlobalSound( "sniper_snip_ability_assass_02")
end

function sniper_ultimate:StopEffectsOnPhase()
    StopGlobalSound( "sniper_snip_ability_assass_02" )
end

function sniper_ultimate:PlayEffectsOnCast()
    local sound_cast = "sniper_snip_laugh_08"
    EmitGlobalSound( sound_cast)
end

if IsClient() then require("abilities") end
Abilities.Initialize( 
	sniper_ultimate,
	{ activity = ACT_DOTA_CAST_ABILITY_1, rate = 1.5 },
	{ movement_speed = 0}
)