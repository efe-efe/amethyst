lich_counter = class({})
LinkLuaModifier( "modifier_lich_banish", "abilities/heroes/lich/lich_shared_modifiers/modifier_lich_banish", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function lich_counter:OnCastPointEnd()
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
            mobility = 1,
            ultimate = 1,
            activity = ACT_DOTA_CAST_ABILITY_4,
            rate = 0.4
        } -- kv
    )
end

--------------------------------------------------------------------------------
-- On Trigger
function lich_counter:OnTrigger( params )
    local caster = self:GetCaster()
    local ability = caster:FindAbilityByName("lich_counter_mobility")
    
    caster:AddNewModifier(caster, self, "modifier_lich_banish", {})
    caster:CastAbilityImmediately(ability, caster:GetEntityIndex())
    self:PlayEffectsOnTrigger()
end

--------------------------------------------------------------------------------
-- Graphics & Sounds
function lich_counter:PlayEffectsOnTrigger()
    local caster = self:GetCaster()
    -- Create Sound
    EmitSoundOn( "Hero_Treant.LeechSeed.Target" , caster)

    -- Create Particles
    local effect_cast = ParticleManager:CreateParticle("particles/econ/events/nexon_hero_compendium_2014/blink_dagger_start_nexon_hero_cp_2014.vpcf", PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, caster:GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

if IsClient() then require("abilities") end
Abilities.Initialize( 
    lich_counter,
    nil, 
	{ movement_speed = 0, hide_indicator = 1 }
)