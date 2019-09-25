wisp_extra = class({})
LinkLuaModifier( "modifier_wisp_extra", "abilities/heroes/wisp/wisp_extra/modifier_wisp_extra", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function wisp_extra:OnSpellStart()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
    local linked_unit = SafeGetModifierCaster( "modifier_wisp_basic_attack_link", caster )

    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_wisp_extra", -- modifier name
        { duration = duration }
    )

    if linked_unit ~= nil then
        linked_unit:AddNewModifier(
            caster,
            self,
            "modifier_wisp_extra",
            { duration = duration }
        )
    end

    self:PlayEffects()
end

function wisp_extra:PlayEffects()
    -- Get Resources
	local particle_cast = "particles/econ/items/wisp/wisp_relocate_marker_ti7_out_embers.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end
    