spectre_counter = class({})
spectre_ex_counter = class({})

LinkLuaModifier("modifier_spectre_counter_countering", "abilities/heroes/spectre/spectre_counter/modifier_spectre_counter_countering", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spectre_counter", "abilities/heroes/spectre/spectre_counter/modifier_spectre_counter", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spectre_counter_recast", "abilities/heroes/spectre/spectre_counter/modifier_spectre_counter_recast", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spectre_ex_counter", "abilities/heroes/spectre/spectre_counter/modifier_spectre_ex_counter", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spectre_ex_counter_debuff", "abilities/heroes/spectre/spectre_counter/modifier_spectre_ex_counter_debuff", LUA_MODIFIER_MOTION_NONE)

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
    
    LinkAbilityCooldowns(caster, 'spectre_ex_counter')
end

function spectre_ex_counter:OnSpellStart()
    local caster = self:GetCaster()
    local delay_time = self:GetSpecialValueFor("delay_time")
    caster:AddNewModifier(caster, self, "modifier_spectre_ex_counter", { duration = delay_time })
    LinkAbilityCooldowns(caster, 'spectre_counter')
	EmitSoundOn("Hero_Spectre.HauntCast", caster)
end