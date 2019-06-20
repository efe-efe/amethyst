wisp_ex_ultimate = class({})
LinkLuaModifier( "modifier_wisp_ex_ultimate", "abilities/heroes/wisp/wisp_ex_ultimate/modifier_wisp_ex_ultimate", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function wisp_ex_ultimate:OnSpellStart()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
    local linked_unit = SafeGetModifierCaster( "modifier_wisp_basic_attack_link_lua", caster )

    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_wisp_ex_ultimate", -- modifier name
        { duration = duration }
    )

    if linked_unit ~= nil then
        linked_unit:AddNewModifier(
            caster,
            self,
            "modifier_wisp_ex_ultimate",
            { duration = duration }
        )
    end

    self:PlayEffects()
end

function wisp_ex_ultimate:PlayEffects()
    -- Get Resources
	local particle_cast = "particles/econ/items/wisp/wisp_relocate_marker_ti7_out_embers.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end
    