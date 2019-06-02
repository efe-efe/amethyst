axe_counter_lua = class({})
LinkLuaModifier( "modifier_axe_counter_lua", "abilities/heroes/axe/axe_counter_lua/modifier_axe_counter_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function axe_counter_lua:OnSpellStart()
    --load data
    local caster = self:GetCaster()
	local duration = self:GetDuration()

    caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_axe_counter_lua", -- modifier name
		{ duration = duration } -- kv
    )

    self:PlayEffects()

end

function axe_counter_lua:PlayEffects()
	-- Get Resources
    local sound_cast = "Hero_Clinkz.WindWalk"
	local particle_cast = "particles/econ/items/axe/ti9_jungle_axe/ti9_jungle_axe_attack_blur_counterhelix.vpcf"
    
	-- Create Sound
    EmitSoundOn( sound_cast, self:GetCaster()  )

    -- Create Particles
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:SetParticleControl( effect_cast, 1, self:GetCaster() :GetOrigin() )

    ParticleManager:ReleaseParticleIndex( effect_cast )
end
