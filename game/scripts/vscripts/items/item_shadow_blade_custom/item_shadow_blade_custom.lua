item_shadow_blade_custom = class({})
LinkLuaModifier( "modifier_item_shadow_blade_custom", "items/item_shadow_blade_custom/modifier_item_shadow_blade_custom", LUA_MODIFIER_MOTION_HORIZONTAL )

function item_shadow_blade_custom:OnSpellStart()
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()
    local duration = self:GetSpecialValueFor("duration")
    
    caster:AddNewModifier(caster, self, "modifier_item_shadow_blade_custom", {duration = duration})
    
    self:PlayEffects()
end

function item_shadow_blade_custom:PlayEffects()
    EmitSoundOn("DOTA_Item.InvisibilitySword.Activate", self:GetCaster())

	local particle_cast = "particles/econ/items/riki/riki_immortal_ti6/riki_immortal_ti6_blinkstrike.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 1, self:GetCaster():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 3, self:GetCaster():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )


    particle_cast = "particles/units/heroes/hero_spirit_breaker/spirit_breaker_haste_owner_runes.vpcf"
    effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end