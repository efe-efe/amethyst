wisp_counter = class({})
LinkLuaModifier( "modifier_wisp_counter", "abilities/heroes/wisp/wisp_counter/modifier_wisp_counter", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function wisp_counter:OnSpellStart()
    
    --load data
    local caster = self:GetCaster()
	local duration = self:GetDuration()

    caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_wisp_counter", -- modifier name
		{ duration = duration } -- kv
    )

    self:PlayEffects()

end

function wisp_counter:PlayEffects()
	-- Get Resources
	local sound_cast = "Hero_Wisp.Relocate"
	local particle_cast = "particles/econ/items/wisp/wisp_relocate_teleport_ti7.vpcf"
    
	-- Create Sound
    EmitSoundOn( sound_cast, self:GetCaster()  )

    -- Create Particles
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:ReleaseParticleIndex( effect_cast )

end