spectre_counter = class({})
LinkLuaModifier( "modifier_spectre_counter_countering", "abilities/heroes/spectre/spectre_counter/modifier_spectre_counter_countering", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spectre_counter", "abilities/heroes/spectre/spectre_counter/modifier_spectre_counter", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spectre_counter_recast", "abilities/heroes/spectre/spectre_counter/modifier_spectre_counter_recast", LUA_MODIFIER_MOTION_NONE )

function spectre_counter:OnSpellStart()
    local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("counter_duration")

    caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
        "modifier_spectre_counter_countering", 
		{ duration = duration } -- kv
    )

    EmitSoundOn("Hero_Spectre.HauntCast", caster)

    local effect_cast = ParticleManager:CreateParticle("particles/econ/items/ogre_magi/ogre_ti8_immortal_weapon/ogre_ti8_immortal_bloodlust_buff_circle_outer_pulse.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

