axe_ex_ultimate = class({})
LinkLuaModifier( "modifier_axe_ex_ultimate", "abilities/heroes/axe/axe_ex_ultimate/modifier_axe_ex_ultimate", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function axe_ex_ultimate:OnSpellStart()
	-- Initialize bariables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()

	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=0.4, activity=ACT_DOTA_OVERRIDE_ABILITY_2, rate=1.5})
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point", { 
		duration = cast_point, 
		can_walk = 0,
		no_target = 1,
	})
end

--------------------------------------------------------------------------------
function axe_ex_ultimate:OnEndPseudoCastPoint()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")

    caster:AddNewModifier(
        caster,
        self,
        "modifier_axe_ex_ultimate",
        { duration = duration }
    )

    self:PlayEffects()
end

function axe_ex_ultimate:PlayEffects()
    local caster = self:GetCaster()

    -- Create Sound
    local sound_cast = "Hero_Sven.GreatCleave.ti7"
    EmitSoundOn(sound_cast, caster)
    
end