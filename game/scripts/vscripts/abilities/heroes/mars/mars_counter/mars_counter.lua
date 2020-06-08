mars_counter = class({})
LinkLuaModifier("modifier_mars_counter_countering", "abilities/heroes/mars/mars_counter/modifier_mars_counter_countering", LUA_MODIFIER_MOTION_NONE)

function mars_counter:OnSpellStart()
    local caster = self:GetCaster()
    local duration = 5.0--self:GetSpecialValueFor("counter_duration")

    caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
        "modifier_mars_counter_countering", 
		{ duration = duration } -- kv
   )

    local effect_cast = ParticleManager:CreateParticle("particles/econ/items/ogre_magi/ogre_ti8_immortal_weapon/ogre_ti8_immortal_bloodlust_buff_circle_outer_pulse.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

