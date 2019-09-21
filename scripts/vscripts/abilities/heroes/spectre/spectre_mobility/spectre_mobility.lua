spectre_mobility = class({})
LinkLuaModifier( "modifier_spectre_mobility_thinker", "abilities/heroes/spectre/spectre_mobility/modifier_spectre_mobility_thinker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spectre_mobility", "abilities/heroes/spectre/spectre_mobility/modifier_spectre_mobility", LUA_MODIFIER_MOTION_NONE )

function spectre_mobility:GetAlternateVersion()
    return self:GetCaster():FindAbilityByName("spectre_ex_mobility")
end

--------------------------------------------------------------------------------
-- Ability Start
function spectre_mobility:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
	self.radius = self:GetSpecialValueFor("radius")

	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=0.3, activity=ACT_DOTA_ATTACK, rate=1.0})
	caster:AddNewModifier(caster, self , "modifier_cast_point", { 
		duration = cast_point, 
        radius = self.radius
	})
end

--------------------------------------------------------------------------------
function spectre_mobility:OnCastPointEnd( point )
    -- unit identifier
	local caster = self:GetCaster()
    local delay_time = self:GetSpecialValueFor( "delay_time" )

    -- Disappear spectre modifier
	caster:AddNewModifier(
		caster,
		self,
		"modifier_spectre_mobility",
		{ duration = delay_time }
	)

    CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_thinker_indicator", --modifierName
		{ 
			thinker = "modifier_spectre_mobility_thinker",
			radius = self.radius,
            delay_time = delay_time,
            show_all = 0
		}, --paramTable
		point, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
    )
    
    -- Put CD on the alternate version of the ability
    local ex_version = caster:FindAbilityByName("spectre_ex_mobility")
    ex_version:StartCooldown(self:GetCooldown(0))
end