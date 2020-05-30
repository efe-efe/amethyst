wisp_ultimate = class({})
LinkLuaModifier( "modifier_wisp_ultimate_thinker", "abilities/heroes/wisp/wisp_ultimate/modifier_wisp_ultimate_thinker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_wisp_ultimate", "abilities/heroes/wisp/wisp_ultimate/modifier_wisp_ultimate", LUA_MODIFIER_MOTION_NONE )

function wisp_ultimate:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end


--------------------------------------------------------------------------------
-- Ability Start
function wisp_ultimate:OnSpellStart()
	local caster = self:GetCaster()
    local cast_point = self:GetCastPoint()
    self.radius = self:GetSpecialValueFor("radius")

	-- Animation and pseudo cast point
	caster:AddNewModifier(
		caster,
		self,
		"modifier_cast_point_old",
		{ 
			duration = cast_point, 
            can_walk = 0,
            radius = self.radius,
		}
	)

	ProgressBars:AddProgressBar(caster, "modifier_cast_point_old", {
		style = "Ultimate",
		text = "ultimate",
		progressBarType = "duration",
		priority = 1,
		reversedProgress = true,
	})
end

--------------------------------------------------------------------------------
-- Ability Start
function wisp_ultimate:OnCastPointEnd( point )
    -- unit identifier
	local caster = self:GetCaster()
    local delay_time = self:GetSpecialValueFor( "delay_time" )
    local max_range = self:GetSpecialValueFor("range")
    local linked_unit = SafeGetModifierCaster( "modifier_wisp_basic_attack_link", caster )

    -- Dissapear wisp modifier
	caster:AddNewModifier(
		caster,
		self,
		"modifier_wisp_ultimate",
		{ duration = delay_time }
	)

    if linked_unit ~= nil then
        linked_unit:AddNewModifier(
            caster,
            self,
            "modifier_wisp_ultimate",
            { duration = delay_time }
        )
    end
    
    CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_thinker_indicator", --modifierName
		{ 
			thinker = "modifier_wisp_ultimate_thinker",
			show_all = 1,
			radius = self.radius,
			delay_time = delay_time,
		}, --paramTable
		point, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
    )

    self:PlayEffects()
end

function wisp_ultimate:PlayEffects()
    EmitGlobalSound("wisp_death")
end