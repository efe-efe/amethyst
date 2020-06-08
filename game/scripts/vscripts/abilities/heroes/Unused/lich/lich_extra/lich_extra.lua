lich_extra = class({})
LinkLuaModifier("modifier_lich_banish", "abilities/heroes/lich/lich_shared_modifiers/modifier_lich_banish", LUA_MODIFIER_MOTION_NONE)

function lich_extra:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
    local ability = caster:FindAbilityByName("lich_extra_mobility")
    
    caster:AddNewModifier(caster, self, "modifier_lich_banish", {})
    caster:CastAbilityImmediately(ability, caster:GetEntityIndex())
	self:PlayEffectsOnCast()
end
    
--------------------------------------------------------------------------------
-- Graphics & Sounds
function lich_extra:PlayEffectsOnCast()
    local caster = self:GetCaster()
    -- Create Sound
    EmitSoundOn("Hero_Lich.FrostBlast.Immortal" , caster)

    -- Create Particles
    local effect_cast = ParticleManager:CreateParticle("particles/econ/events/nexon_hero_compendium_2014/blink_dagger_start_nexon_hero_cp_2014.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect_cast, 0, caster:GetOrigin())
    ParticleManager:ReleaseParticleIndex(effect_cast)
end


if IsClient() then require("wrappers/abilities") end
Abilities.Initialize(
	lich_extra,
	{ activity = ACT_DOTA_ATTACK, rate = 1.8 },
	{ movement_speed = 30, fixed_range = 1 }
)