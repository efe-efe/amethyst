juggernaut_counter = class({})
LinkLuaModifier( "modifier_juggernaut_counter_recast", "abilities/heroes/juggernaut/juggernaut_counter/modifier_juggernaut_counter_recast", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function juggernaut_counter:OnCastPointEnd()
    --load data
    local caster = self:GetCaster()
    local duration = self:GetDuration()
    
    caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_counter", -- modifier name
		{ 
            movement_speed = 0,
            duration = duration, 
            destroy_on_trigger = 1,
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
        "modifier_juggernaut_counter_recast",
        { duration = 5.0 }
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
    EmitSoundOn( "juggernaut_jug_ability_bladefury_05" , self:GetCaster())

    -- Create Particles
    local particle_cast = "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_trigger_sphere.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
    juggernaut_counter,
    nil, 
	{ movement_speed = 0, hide_indicator = 1 }
)