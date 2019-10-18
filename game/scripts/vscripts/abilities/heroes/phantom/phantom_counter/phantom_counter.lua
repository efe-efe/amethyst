phantom_counter = class({})
LinkLuaModifier( "modifier_phantom_banish", "abilities/heroes/phantom/phantom_shared_modifiers/modifier_phantom_banish", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function phantom_counter:OnCastPointEnd()
    local caster = self:GetCaster()
	local duration = self:GetDuration()

    caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
        "modifier_counter", 
		{ 
            activity = ACT_DOTA_CAST_ABILITY_3,
            rate = 0.4,
            movement_speed = 0,
            duration = duration, 
            destroy_on_trigger = 1,
        }
    )
end

function phantom_counter:OnTrigger()
	local caster = self:GetCaster()
    local ability = caster:FindAbilityByName("phantom_counter_mobility")

    caster:AddNewModifier(caster, self, "modifier_phantom_banish", { duration = 5 })
    caster:CastAbilityImmediately(ability, caster:GetEntityIndex())
	
	caster:FindAbilityByName("phantom_special_attack"):EndCooldown()
	caster:FindAbilityByName("phantom_ex_special_attack"):EndCooldown()
	
    self:PlayEffectsOnTrigger()
end

function phantom_counter:PlayEffectsOnTrigger()
	-- Create Sound
    EmitSoundOn( "Hero_PhantomAssassin.Blur", self:GetCaster()  )

	-- Create Particles
	local particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_start.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 3, self:GetCaster():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

if IsClient() then require("abilities") end
Abilities.Initialize( 
    phantom_counter,
    nil, 
	{ movement_speed = 100 }
)