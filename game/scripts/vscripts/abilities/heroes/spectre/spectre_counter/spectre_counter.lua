spectre_counter = class({})
LinkLuaModifier( "modifier_spectre_counter", "abilities/heroes/spectre/spectre_counter/modifier_spectre_counter", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function spectre_counter:OnCastPointEnd()
    local caster = self:GetCaster()
	local duration = self:GetDuration()

    caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
        "modifier_counter", 
		{ 
            movement_speed = 0,
            duration = duration, 
            destroy_on_trigger = 1,
            sound = "Hero_Spectre.HauntCast"
        } -- kv
    )
end

function spectre_counter:OnTrigger()
    local caster = self:GetCaster()
    local duration_invis = self:GetSpecialValueFor("duration_invis")
    local duration_invulnerable = self:GetSpecialValueFor("duration_invulnerable")
    
    caster:AddNewModifier(caster, self, "modifier_spectre_counter", { duration = duration_invis })
    caster:AddNewModifier(caster, self, "modifier_generic_fading_haste", { duration = duration_invis })
    caster:AddNewModifier(caster, self, "modifier_generic_invencible", { duration = duration_invulnerable })
    
    local modifier = caster:FindModifierByName("modifier_spectre_basic_attack")
    modifier:IncrementStackCount()
    modifier:StartIntervalThink(-1)
    modifier:CalculateCharge()

    self:PlayEffectsOnTrigger()
end

function spectre_counter:PlayEffectsOnTrigger()
    EmitSoundOn( "Hero_Spectre.Reality", self:GetCaster() )
    local particle_cast = "particles/units/heroes/hero_spectre/spectre_death.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 3, self:GetCaster():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

if IsClient() then require("abilities") end
Abilities.Initialize( 
    spectre_counter,
    nil, 
	{ movement_speed = 100 }
)