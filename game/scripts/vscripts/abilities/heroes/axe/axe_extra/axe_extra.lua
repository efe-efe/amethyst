axe_extra = class({})
LinkLuaModifier( "modifier_axe_extra", "abilities/heroes/axe/axe_extra/modifier_axe_extra", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function axe_extra:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()

	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=0.4, activity=ACT_DOTA_OVERRIDE_ABILITY_2, rate=1.5})
	caster:AddNewModifier(caster, self , "modifier_cast_point_old", { 
		duration = cast_point, 
		can_walk = 0,
		no_target = 1,
	})
end

--------------------------------------------------------------------------------
function axe_extra:OnCastPointEnd()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")

    caster:AddNewModifier(
        caster,
        self,
        "modifier_axe_extra",
        { duration = duration }
    )

    self:PlayEffects()
end

function axe_extra:PlayEffects()
    local caster = self:GetCaster()

    -- Create Sound
    local sound_cast = "Hero_Sven.GreatCleave.ti7"
    EmitSoundOn(sound_cast, caster)
    
end