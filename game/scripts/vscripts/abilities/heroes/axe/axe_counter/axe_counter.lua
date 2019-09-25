axe_counter = class({})
LinkLuaModifier( "modifier_axe_counter_buff", "abilities/heroes/axe/axe_counter/modifier_axe_counter_buff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function axe_counter:OnSpellStart()
    local caster = self:GetCaster()
	local duration = self:GetDuration()

    caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
        "modifier_counter", 
		{ 
            can_walk = 0,
            duration = duration, 
            destroy_on_trigger = 1,
            mobility = 1,
            ultimate = 1,
            ex_two = 1,
        } -- kv
    )
    self:PlayEffects()
end

function axe_counter:OnTrigger( params ) 
    local caster = self:GetCaster()
    local buff_duration = self:GetSpecialValueFor("buff_duration")

    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_axe_counter_buff", -- modifier name
        { duration = buff_duration } -- kv
    )
end

function axe_counter:PlayEffects()
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
