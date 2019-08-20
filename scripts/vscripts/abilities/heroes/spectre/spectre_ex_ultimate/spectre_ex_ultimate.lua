spectre_ex_ultimate = class({})
LinkLuaModifier( "modifier_spectre_ex_ultimate_thinker", "abilities/heroes/spectre/spectre_ex_ultimate/modifier_spectre_ex_ultimate_thinker", LUA_MODIFIER_MOTION_NONE )

function spectre_ex_ultimate:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end
--------------------------------------------------------------------------------
-- Ability Start
function spectre_ex_ultimate:OnSpellStart()
	-- Initialize bariables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
	local radius = self:GetSpecialValueFor("radius")

	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=0.3, activity=ACT_DOTA_ATTACK, rate=1.0})
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point", { 
		duration = cast_point, 
        movement_speed = 10,
        radius = radius
	})
end

--------------------------------------------------------------------------------
function spectre_ex_ultimate:OnEndPseudoCastPoint( point )
    -- unit identifier
	local caster = self:GetCaster()
    local old_origin = caster:GetOrigin()
    local max_range = self:GetSpecialValueFor("range")

    local direction = ( point - old_origin)
    if direction:Length2D() > max_range then
        direction = direction:Normalized() * max_range
    end

    self:PlayEffects()

    -- Effect thinker
    CreateModifierThinker(
        caster, --hCaster
        self, --hAbility
        "modifier_spectre_ex_ultimate_thinker", --modifierName
        {}, --paramTable
        old_origin + direction, --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        false --bPhantomBlocker
    )

end

--------------------------------------------------------------------------------
--Effects

--Jump
function spectre_ex_ultimate:PlayEffects()
    -- Get Resources
    local sound_cast = "Hero_Spectre.Haunt"
    
    -- particles 1
    local particle_cast = "particles/units/heroes/hero_spectre/spectre_death.vpcf"
    local effect_cast = ParticleManager:CreateParticle( 
            particle_cast, 
            PATTACH_WORLDORIGIN, 
            nil 
        )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 3, self:GetCaster():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end