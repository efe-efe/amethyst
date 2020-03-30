item_phase_custom = class({})
LinkLuaModifier( "modifier_item_phase_custom", "items/item_phase_custom/modifier_item_phase_custom", LUA_MODIFIER_MOTION_HORIZONTAL )

function item_phase_custom:OnCastPointEnd()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")

    caster:AddNewModifier(caster, self, "modifier_item_phase_custom", { duration = duration })

    self:PlayEffects()
end

function item_phase_custom:PlayEffects()
    local sound_cast = "DOTA_Item.PhaseBoots.Activate"
    EmitSoundOn(sound_cast, self:GetCaster())

	local particle_cast = "particles/econ/events/ti9/phase_boots_ti9.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
    item_phase_custom,
    nil,
	{ movement_speed = 100 }
)
