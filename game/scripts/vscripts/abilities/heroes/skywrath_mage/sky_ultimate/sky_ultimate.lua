sky_ultimate = class({})
LinkLuaModifier( "modifier_sky_ultimate_thinker", "abilities/heroes/skywrath_mage/sky_ultimate/modifier_sky_ultimate_thinker", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function sky_ultimate:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
	self.radius = self:GetSpecialValueFor( "radius" )

    -- Animation and pseudo cast point
	StartAnimation(caster, {
		duration = cast_point + 0.1, 
		activity = ACT_DOTA_CAST_ABILITY_4, 
		rate = 1.0
	})
	caster:AddNewModifier(
		caster, 
		self, 
		"modifier_cast_point", 
		{ 
			duration = cast_point,
            radius = self.radius,
			movement_speed = 10,
			show_all = 1,
		}
	)
    ProgressBars:AddProgressBar(caster, "modifier_cast_point", {
		style = "Ultimate",
		text = "ultimate",
		progressBarType = "duration",
		priority = 1,
		reversedProgress = true,
	})
end

--------------------------------------------------------------------------------
-- Ability Start
function sky_ultimate:OnCastPointEnd( point )
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")

	CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_thinker_indicator", --modifierName
		{ 
			thinker = "modifier_sky_ultimate_thinker",
			show_all = 1,
			radius = self.radius,
			delay_time = duration,
			thinker_duration = duration,
		}, --paramTable
		point, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)

    self:PlayEffects()
end


function sky_ultimate:OnAbilityPhaseInterrupted()	
    -- stop effects 
	local sound_cast = "skywrath_mage_drag_mystic_flare_01"
	StopGlobalSound( sound_cast )
	return true -- if success
end

function sky_ultimate:PlayEffects()
    local sound_cast = "Hero_SkywrathMage.MysticFlare.Cast"

    EmitSoundOn(sound_cast, self:GetCaster())
    
	EmitGlobalSound("skywrath_mage_drag_mystic_flare_01")
end