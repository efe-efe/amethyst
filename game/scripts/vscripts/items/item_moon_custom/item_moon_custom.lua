item_moon_custom = class({})
LinkLuaModifier( "modifier_item_moon_custom", "items/item_moon_custom/modifier_item_moon_custom", LUA_MODIFIER_MOTION_HORIZONTAL )

function item_moon_custom:OnCastPointEnd()
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()
    local duration = self:GetSpecialValueFor("duration")
    
    caster:AddNewModifier(caster, self, "modifier_item_moon_custom", {duration = duration})
    
    self:PlayEffects()
end

function item_moon_custom:PlayEffects()
    EmitSoundOn("Item.MoonShard.Consume", self:GetCaster())

	local particle_cast = "particles/econ/items/outworld_devourer/od_shards_exile/od_shards_exile_prison_start_mana_flash.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:SetParticleControl( effect_cast, 1, self:GetCaster():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )


    particle_cast = "particles/units/heroes/hero_spirit_breaker/spirit_breaker_haste_owner_runes.vpcf"
    effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
    item_moon_custom,
    nil,
	{ movement_speed = 100 }
)
