nevermore_counter = class({})
LinkLuaModifier( "modifier_nevermore_counter", "abilities/heroes/nevermore/nevermore_counter/modifier_nevermore_counter", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
function nevermore_counter:OnCastPointEnd( point )
    --load data
    local caster = self:GetCaster()
    local duration = self:GetDuration()

    caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_counter", -- modifier name
		{ 
            movement_speed = 0,
            sound = "Hero_Nevermore.RequiemOfSoulsCast",
            duration = duration, 
            destroy_on_trigger = 1,
            activity = ACT_DOTA_TELEPORT,
            rate = 1.0
        } -- kv
    )
end

function nevermore_counter:OnTrigger( params )
    local caster = self:GetCaster()
    
    local ability = caster:FindAbilityByName("nevermore_counter_mobility")
    caster:CastAbilityOnPosition(Vector(0,0,0), ability, caster:GetPlayerID())

    self:PlayEffectsOnTrigger()
end

function nevermore_counter:PlayEffectsOnCast()
    EmitSoundOn("Hero_Nevermore.PreAttack", self:GetCaster())
end

function nevermore_counter:PlayEffectsOnTrigger()
    local caster = self:GetCaster()
    EmitSoundOn("Hero_Nevermore.RequiemOfSouls", caster)

	-- create particle
	local particle_cast = "particles/econ/events/ti9/blink_dagger_ti9_start_lvl2.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, caster:GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
    
    -- create particle
	local particle_cast_b = "particles/econ/events/ti9/phase_boots_ti9_body_magic.vpcf"
	local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast_b, 0, caster:GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast_b )
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	nevermore_counter,
	nil,
	{ movement_speed = 0 }
)