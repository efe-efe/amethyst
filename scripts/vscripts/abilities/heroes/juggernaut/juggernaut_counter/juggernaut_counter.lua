juggernaut_counter = class({})
LinkLuaModifier( "modifier_juggernaut_counter_buff", "abilities/heroes/juggernaut/juggernaut_counter/modifier_juggernaut_counter_buff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function juggernaut_counter:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()

	-- Animation and pseudo cast point
	caster:AddNewModifier(
        caster, 
        self,
        "modifier_generic_pseudo_cast_point", 
        {
            duration = cast_point,
        }
    )
end

--------------------------------------------------------------------------------
-- Ability Start
function juggernaut_counter:OnEndPseudoCastPoint( point )
    --load data
    local caster = self:GetCaster()
    local duration = self:GetDuration()
    
    caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_counter", -- modifier name
		{ 
            can_walk = 0,
            duration = duration, 
            destroy_on_trigger = 1,
            mobility = 1,
            ultimate = 1,
            activity = ACT_DOTA_SPAWN,
            rate = 0.1
        } -- kv
    )

    self.reflector = caster:AddNewModifier(
        caster,
        self,
        "modifier_generic_projectile_reflector_lua",
        { duration = duration }
    )
end

--------------------------------------------------------------------------------
-- On Trigger
function juggernaut_counter:OnTrigger( params )
    local caster = self:GetCaster()
    
    self:PlayEffectsOnTrigger()

    caster:AddNewModifier(
        caster,
        self,
        "modifier_juggernaut_counter_buff",
        { duration = 3.0 }
    )
end

--------------------------------------------------------------------------------
-- Graphics & Sounds
function juggernaut_counter:OnEndCounter()
    self.reflector:Destroy()

    -- Create Sound
    EmitSoundOn("Hero_Juggernaut.Attack", self:GetCaster())

    -- Create Particles
	local particle_cast = "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_omni_slash_tgt_bonus.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

function juggernaut_counter:PlayEffectsOnTrigger()
    -- Create Sound
    EmitSoundOn( "Hero_Juggernaut.BladeDance" , self:GetCaster())

    -- Create Particles
    local particle_cast = "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_trigger_sphere.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end