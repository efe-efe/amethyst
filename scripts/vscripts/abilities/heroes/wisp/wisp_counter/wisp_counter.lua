wisp_counter = class({})
LinkLuaModifier( "modifier_wisp_counter_buffs", "abilities/heroes/wisp/wisp_counter/modifier_wisp_counter_buffs", LUA_MODIFIER_MOTION_NONE )

function wisp_counter:GetAlternateVersion()
    return self:GetCaster():FindAbilityByName("wisp_ex_counter")
end

--------------------------------------------------------------------------------
-- Ability Start
function wisp_counter:OnSpellStart()
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
function wisp_counter:OnEndPseudoCastPoint( point )
    local caster = self:GetCaster()
	local duration = self:GetDuration()
    
    self:PlayEffectsOnCast()

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
            rate = 1.0
        } -- kv
    )
    
    -- Put CD on the alternate version of the ability
    local alternate_version = caster:FindAbilityByName("wisp_ex_counter")
	alternate_version:StartCooldown(self:GetCooldown(0))
end

function wisp_counter:OnTrigger( params )
    local buff_duration = self:GetSpecialValueFor("buff_duration")

    local caster = self:GetCaster()
    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_wisp_counter_buffs", -- modifier name
        { duration = buff_duration } -- kv
    )
end

--------------------------------------------------------------------------------
-- Graphics & Sounds
function wisp_counter:OnEndCounter()
    ParticleManager:DestroyParticle(self.effect_cast, false)
    ParticleManager:ReleaseParticleIndex( self.effect_cast )
end

function wisp_counter:PlayEffectsOnCast()
	-- Create Sound
    EmitSoundOn( "Hero_Wisp.Relocate", self:GetCaster()  )
    
    -- Create Particles
	local particle_cast = "particles/econ/items/wisp/wisp_relocate_teleport_ti7.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:ReleaseParticleIndex( effect_cast )


    -- Create Particles
	local particle_cast = "particles/mod_units/heroes/hero_wisp/wisp_relocate_channel.vpcf"
    self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
end