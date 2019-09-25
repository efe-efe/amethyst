lich_ultimate = class({})
LinkLuaModifier( "modifier_lich_banish", "abilities/heroes/lich/lich_shared_modifiers/modifier_lich_banish", LUA_MODIFIER_MOTION_NONE )

function lich_ultimate:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
    local ability = caster:FindAbilityByName("lich_ultimate_mobility")
    
    caster:AddNewModifier(caster, self, "modifier_lich_banish", {})
	self:PlayEffectsOnCast()
    caster:CastAbilityImmediately(ability, caster:GetEntityIndex())
end
    
--------------------------------------------------------------------------------
-- Graphics & Sounds
function lich_ultimate:PlayEffectsOnCast()
    local caster = self:GetCaster()
    -- Create Sound
    EmitSoundOn( "Hero_Lich.ChainFrost.TI8" , caster)
    EmitSoundOn( "Hero_Lich.ChainFrostLoop.TI8" , caster)
    -- Create Particles
    local effect_cast = ParticleManager:CreateParticle("particles/econ/events/nexon_hero_compendium_2014/blink_dagger_start_nexon_hero_cp_2014.vpcf", PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, caster:GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end


if IsClient() then require("abilities") end
Abilities.Initialize( 
	lich_ultimate,
	{ activity = ACT_DOTA_ATTACK, rate = 1.8 },
    { movement_speed = 30, fixed_range = 1 }
)