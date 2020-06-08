builder_mobility = class({})

function builder_mobility:OnSpellStart()
    local caster = self:GetCaster()
    local point = self:GetCursorPosition()

    FindClearSpaceForUnit(caster, point , true)

    self:PlayEffects()
end

function builder_mobility:PlayEffects()
	local particle_cast = "particles/econ/items/ogre_magi/ogre_ti8_immortal_weapon/ogre_ti8_immortal_bloodlust_buff_ground.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControl(effect_cast, 3, self:GetCaster():GetOrigin())
    ParticleManager:ReleaseParticleIndex(effect_cast)
end


if IsClient() then require("wrappers/abilities") end
Abilities.Initialize(
	builder_mobility,
    { activity = ACT_DOTA_ATTACK, rate = 1.3 },
	{ movement_speed = 10, hide_indicator = 1, fixed_range = 1 }
)