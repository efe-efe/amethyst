wisp_ex_special_attack = class({})
LinkLuaModifier( "modifier_wisp_ex_special_attack_thinker", "abilities/heroes/wisp/wisp_ex_special_attack/modifier_wisp_ex_special_attack_thinker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_wisp_ex_special_attack_movement", "abilities/heroes/wisp/wisp_ex_special_attack/modifier_wisp_ex_special_attack_movement", LUA_MODIFIER_MOTION_HORIZONTAL )

------------------------------------------------------------------------------
function wisp_ex_special_attack:GetAlternateVersion()
    return self:GetCaster():FindAbilityByName("wisp_special_attack")
end

--------------------------------------------------------------------------------
-- Ability Start
function wisp_ex_special_attack:OnSpellStart()
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()

	-- Animation and pseudo cast point
	caster:AddNewModifier(
		caster,
		self,
		"modifier_cast_point",
		{ 
			duration = cast_point, 
            can_walk = 0,
            no_target = 1,
		}
	)
end

--------------------------------------------------------------------------------
-- Ability Start
function wisp_ex_special_attack:OnCastPointEnd()
	-- unit identifier
	local caster = self:GetCaster()
    local linked_unit = SafeGetModifierCaster( "modifier_wisp_basic_attack_link_negative", caster )
    local delay_time = self:GetSpecialValueFor("delay_time")
    local radius = self:GetSpecialValueFor("radius")

    if linked_unit ~= nil then
        --- Movement
        local difference = linked_unit:GetOrigin() - caster:GetOrigin()
        local distance = difference:Length2D()
        local x = linked_unit:GetOrigin().x - caster:GetOrigin().x
        local y = linked_unit:GetOrigin().y - caster:GetOrigin().y

        caster:AddNewModifier(
            caster,
            self,
            "modifier_wisp_ex_special_attack_movement",
            {
                r = distance,
                x = x,
                y = y
            }
        )
    else
        CreateModifierThinker(
            caster, --hCaster
            self, --hAbility
            "modifier_thinker_indicator", --modifierName
            { 
                thinker = "modifier_wisp_ex_special_attack_thinker",
                show_all = 1,
                radius = radius,
                delay_time = delay_time,
            }, --paramTable
            caster:GetOrigin(), --vOrigin
            caster:GetTeamNumber(), --nTeamNumber
            false --bPhantomBlocker
        )
    end

    -- Put CD on the alternate version of the ability
    local alternate_version = caster:FindAbilityByName("wisp_special_attack")
	alternate_version:StartCooldown(self:GetCooldown(0))
    self:PlayEffects()
end

--------------------------------------------------------------------------------

function wisp_ex_special_attack:PlayEffects()
    -- Get Resources
    local particle_cast = "particles/mod_units/heroes/hero_wisp/wisp_relocate_marker_ti7_endpoint_core_flare.vpcf"

    local effect_cast = ParticleManager:CreateParticle( 
        particle_cast, 
        PATTACH_ABSORIGIN_FOLLOW, 
        self:GetCaster()
    )
    ParticleManager:ReleaseParticleIndex( effect_cast )

    -- Get Resources
    local particle_cast2 = "particles/mod_units/heroes/hero_wisp/wisp_tether_hit.vpcf"

    local effect_cast2 = ParticleManager:CreateParticle( 
        particle_cast2, 
        PATTACH_ABSORIGIN_FOLLOW,
        self:GetCaster()
    )
    ParticleManager:ReleaseParticleIndex( effect_cast2 )
end