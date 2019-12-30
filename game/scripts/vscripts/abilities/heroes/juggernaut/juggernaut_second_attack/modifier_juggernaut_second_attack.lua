modifier_juggernaut_second_attack = class({})

--- Misc 
function modifier_juggernaut_second_attack:IsHidden()
    return true
end

function modifier_juggernaut_second_attack:IsDebuff()
	return false
end

function modifier_juggernaut_second_attack:IsPurgable()
    return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_juggernaut_second_attack:OnCreated( params )
    --Initializers
    if IsServer() then
        -- Animation and pseudo cast point
        StartAnimation(self:GetParent(), { 
            duration = params.duration, 
            activity = ACT_DOTA_OVERRIDE_ABILITY_1, 
            rate = 1.3
        })

        self:PlayEffects()
    end
end

--------------------------------------------------------------------------------
-- Destroyer
function modifier_juggernaut_second_attack:OnDestroy( kv )
    if IsServer() then
        self:StopEffects()
        EmitSoundOn("Hero_Juggernaut.BladeFuryStop", self:GetParent())
    end
end

--------------------------------------------------------------------------------
--Graphics & Animations
function modifier_juggernaut_second_attack:PlayEffects( )
	EmitSoundOn("Hero_Juggernaut.BladeFuryStart", self:GetParent())

	local particle_cast = "particles/units/heroes/hero_juggernaut/juggernaut_blade_fury.vpcf"

	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    ParticleManager:SetParticleControl( self.effect_cast, 5, Vector( 200, 1, 1 ) )
    ParticleManager:SetParticleControl( self.effect_cast, 2, self:GetParent():GetOrigin() )
    
end

function modifier_juggernaut_second_attack:StopEffects()
    StopSoundOn("Hero_Juggernaut.BladeFuryStart", self:GetParent())

    ParticleManager:DestroyParticle( self.effect_cast, false )
    ParticleManager:ReleaseParticleIndex( self.effect_cast )
end
