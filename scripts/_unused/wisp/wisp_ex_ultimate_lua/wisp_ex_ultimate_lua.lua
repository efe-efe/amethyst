wisp_ex_ultimate_lua = class({})
LinkLuaModifier( "modifier_wisp_ex_ultimate_lua", "abilities/heroes/wisp/wisp_ex_ultimate_lua/modifier_wisp_ex_ultimate_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function wisp_ex_ultimate_lua:OnSpellStart()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")

    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_wisp_ex_ultimate_lua", -- modifier name
        { duration = duration }
    )

    self:PlayEffects()
end

function wisp_ex_ultimate_lua:PlayEffects()
    -- Get Resources
	local particle_cast = "particles/econ/items/wisp/wisp_relocate_marker_ti7_out_embers.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end
    