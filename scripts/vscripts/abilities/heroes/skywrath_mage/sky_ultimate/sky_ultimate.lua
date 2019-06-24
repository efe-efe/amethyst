sky_ultimate = class({})
LinkLuaModifier( "modifier_sky_ultimate_thinker", "abilities/heroes/skywrath_mage/sky_ultimate/modifier_sky_ultimate_thinker", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Set the aoe indicator
function sky_ultimate:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Start
function sky_ultimate:OnSpellStart()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
    local point = self:GetCursorPosition()

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