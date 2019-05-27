wisp_counter_lua = class({})
LinkLuaModifier( "modifier_wisp_counter_lua", "abilities/heroes/wisp/wisp_counter_lua/modifier_wisp_counter_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function wisp_counter_lua:OnSpellStart()
    
    --load data
    local caster = self:GetCaster()
	local duration = self:GetDuration()

    caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_wisp_counter_lua", -- modifier name
		{ duration = duration } -- kv
    )

    self:PlayEffects()

end

function wisp_counter_lua:PlayEffects()
	-- Get Resources
	local sound_cast = "Hero_Wisp.Relocate"
	local particle_cast = "particles/econ/items/wisp/wisp_relocate_teleport_ti7.vpcf"
    
	-- Create Sound
    EmitSoundOn( sound_cast, self:GetCaster()  )

    -- Create Particles
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:ReleaseParticleIndex( effect_cast )

end