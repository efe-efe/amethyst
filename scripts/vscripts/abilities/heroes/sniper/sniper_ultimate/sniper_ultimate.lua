sniper_ultimate = class({})
LinkLuaModifier( "modifier_sniper_ultimate_timer", "abilities/heroes/sniper/sniper_ultimate/modifier_sniper_ultimate_timer", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function sniper_ultimate:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
	local radius = self:GetSpecialValueFor("hitbox")
    
    -- play effects
	self:PlayEffects_a()
	
	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=0.6, activity=ACT_DOTA_CAST_ABILITY_1, rate=1.5})
	caster:AddNewModifier(
		caster, 
		self, 
		"modifier_cast_point", 
		{ 
			duration = cast_point,
			can_walk = 0,
			no_target = 1
		}
	)
end

function sniper_ultimate:OnCastPointEnd()
    local caster = self:GetCaster()
    local attack_time = self:GetSpecialValueFor("duration")
    
    caster:AddNewModifier(
        caster, -- player source
		self, -- ability source
		"modifier_sniper_ultimate_timer", -- modifier name
		{ duration = attack_time } -- kv
    )

    self:PlayEffects_b()
end

function sniper_ultimate:OnStopPseudoCastPoint()
	self:StopEffects_a()
end

function sniper_ultimate:PlayEffects_a()
    EmitGlobalSound( "sniper_snip_ability_assass_02")
end

function sniper_ultimate:StopEffects_a()
    StopGlobalSound( "sniper_snip_ability_assass_02" )
end

function sniper_ultimate:PlayEffects_b()
    local sound_cast = "sniper_snip_laugh_08"
    EmitGlobalSound( sound_cast)
end

