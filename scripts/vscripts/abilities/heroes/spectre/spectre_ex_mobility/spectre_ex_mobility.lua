spectre_ex_mobility = class({})
LinkLuaModifier( "modifier_spectre_ex_mobility", "abilities/heroes/spectre/spectre_ex_mobility/modifier_spectre_ex_mobility", LUA_MODIFIER_MOTION_NONE )

function spectre_ex_mobility:GetAlternateVersion()
    return self:GetCaster():FindAbilityByName("spectre_mobility")
end

--------------------------------------------------------------------------------
-- Ability Start
function spectre_ex_mobility:OnSpellStart()
	-- Initialize bariables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()

	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=0.3, activity=ACT_DOTA_ATTACK, rate=1.0})
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point", { 
		duration = cast_point, 
		can_walk = 0,
		no_target = 1,
	})
end

--------------------------------------------------------------------------------
function spectre_ex_mobility:OnEndPseudoCastPoint()

    local caster = self:GetCaster()
    local duration = self:GetDuration()

    caster:AddNewModifier(caster, self, "modifier_spectre_ex_mobility", { duration = duration })

    -- Put CD on the alternate version of the ability
    local alternate_version = caster:FindAbilityByName("spectre_mobility")
    alternate_version:StartCooldown(self:GetCooldown(0))
end

