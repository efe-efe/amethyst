sky_ultimate = class({})
LinkLuaModifier( "modifier_sky_ultimate_thinker", "abilities/heroes/skywrath_mage/sky_ultimate/modifier_sky_ultimate_thinker", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function sky_ultimate:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()

    -- Animation and pseudo cast point
	StartAnimation(caster, {
		duration = cast_point + 0.1, 
		activity = ACT_DOTA_CAST_ABILITY_4, 
		rate = 1.0
	})
	caster:AddNewModifier(
		caster, 
		self, 
		"modifier_generic_pseudo_cast_point", 
		{ 
			duration = cast_point,
            radius = self:GetSpecialValueFor( "radius" ),
            movement_speed = 10,
		}
	)
end

--------------------------------------------------------------------------------
-- Ability Start
function sky_ultimate:OnEndPseudoCastPoint( point )
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")

    CreateModifierThinker(
        caster, --hCaster
        self, --hAbility
        "modifier_sky_ultimate_thinker", --modifierName
        {duration = duration}, --paramTable
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