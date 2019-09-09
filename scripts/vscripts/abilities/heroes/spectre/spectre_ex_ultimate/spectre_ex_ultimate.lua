spectre_ex_ultimate = class({})
LinkLuaModifier( "modifier_spectre_ex_ultimate_thinker", "abilities/heroes/spectre/spectre_ex_ultimate/modifier_spectre_ex_ultimate_thinker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spectre_ex_ultimate", "abilities/heroes/spectre/spectre_ex_ultimate/modifier_spectre_ex_ultimate", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function spectre_ex_ultimate:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
	self.radius = self:GetSpecialValueFor("radius")

	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=0.3, activity=ACT_DOTA_ATTACK, rate=1.0})
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point", { 
		duration = cast_point, 
        movement_speed = 10,
        radius = self.radius
	})
end

--------------------------------------------------------------------------------
function spectre_ex_ultimate:OnEndPseudoCastPoint( point )
    -- unit identifier
	local caster = self:GetCaster()
	local delay_time = self:GetSpecialValueFor( "delay_time" )

    self:PlayEffects()

    caster:AddNewModifier(
        caster,
        self,
        "modifier_spectre_ex_ultimate",
        { duration = delay_time }
    )

	CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_thinker_indicator", --modifierName
		{ 
			thinker = "modifier_spectre_ex_ultimate_thinker",
			show_all = 1,
			radius = self.radius,
			delay_time = delay_time,
		}, --paramTable
		point, --vOrigin
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