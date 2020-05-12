item_butterfly_custom = class({})
LinkLuaModifier( "modifier_item_butterfly_custom", "items/item_butterfly_custom/modifier_item_butterfly_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_butterfly_custom_banish", "items/item_butterfly_custom/modifier_item_butterfly_custom_banish", LUA_MODIFIER_MOTION_NONE )

function item_butterfly_custom:OnSpellStart()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
    caster:AddNewModifier(caster, self, "modifier_item_butterfly_custom", { duration = duration })

    self:PlayEffectsOnCast()
end

function item_butterfly_custom:PlayEffectsOnCast()
	local particle_cast = "particles/econ/events/ti8/phase_boots_ti8.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end