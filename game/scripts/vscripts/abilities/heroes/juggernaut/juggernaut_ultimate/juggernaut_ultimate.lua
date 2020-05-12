juggernaut_ultimate = class({})
LinkLuaModifier( "modifier_juggernaut_ultimate_displacement", "abilities/heroes/juggernaut/juggernaut_ultimate/modifier_juggernaut_ultimate_displacement", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_juggernaut_ultimate_slashing", "abilities/heroes/juggernaut/juggernaut_ultimate/modifier_juggernaut_ultimate_slashing", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_fading_slow", "abilities/generic/modifier_generic_fading_slow", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_juggernaut_spin_animation", "abilities/heroes/juggernaut/modifier_juggernaut_spin_animation", LUA_MODIFIER_MOTION_HORIZONTAL )

function juggernaut_ultimate:GetCastPoint()
	return self:GetSpecialValueFor("cast_point")
end

function juggernaut_ultimate:OnAbilityPhaseStart()
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_casting", { 
		duration = self:GetCastPoint(), 
		translate = "sharp_blade",
		movement_speed = 0,
	})
	self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_GENERIC_CHANNEL_1, 1.0)
    self:PlayEffectsOnPhase()
    return true
end

function juggernaut_ultimate:OnAbilityPhaseInterrupted()
	self:GetCaster():FadeGesture(ACT_DOTA_GENERIC_CHANNEL_1)
	self:GetCaster():RemoveModifierByName("modifier_casting")
	StopGlobalSound( "juggernaut_jug_ability_omnislash_01" )
end

function juggernaut_ultimate:OnSpellStart()
	self:GetCaster():FadeGesture(ACT_DOTA_GENERIC_CHANNEL_1)
    
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()
	local point = self:GetCursorPosition()
    local distance = self:GetCastRange(Vector(0,0,0), nil)
	local direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()

    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_juggernaut_ultimate_displacement", -- modifier name
        {
            x = direction.x,
            y = direction.y,
            r = distance,
            speed = (distance/0.5),
            peak = 50,
        } -- kv
    )
    self:PlayEffectsOnCast()
end

function juggernaut_ultimate:PlayEffectsOnPhase()
    local caster = self:GetCaster()
    EmitGlobalSound("juggernaut_jug_ability_omnislash_01")

    local particle_cast = "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_death_model.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )
    ParticleManager:ReleaseParticleIndex( effect_cast )

    particle_cast = "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_omni_end.vpcf"
	effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )
    ParticleManager:SetParticleControl( effect_cast, 2, caster:GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 3, caster:GetOrigin() )

    ParticleManager:ReleaseParticleIndex( effect_cast )
end

function juggernaut_ultimate:PlayEffectsOnCast()
    EmitSoundOn("Hero_PhantomAssassin.Strike.End", self:GetCaster())
end