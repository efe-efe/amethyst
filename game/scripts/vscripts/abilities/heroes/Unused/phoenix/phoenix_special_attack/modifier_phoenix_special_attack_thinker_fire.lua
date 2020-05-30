
modifier_phoenix_special_attack_thinker_fire = class({})

--------------------------------------------------------------------------------
--Clasifications
function modifier_phoenix_special_attack_thinker_fire:IsHidden()
	return true
end

--------------------------------------------------------------------------------
--Initializer
function modifier_phoenix_special_attack_thinker_fire:OnCreated( kv )
    if IsServer() then
        self:PlayEffects()
    end
end

function modifier_phoenix_special_attack_thinker_fire:OnDestroy()
    if IsServer() then
        self:StopEffects()
		UTIL_Remove( self:GetParent() )
	end
end

function modifier_phoenix_special_attack_thinker_fire:PlayEffects()
    local particle_cast = "particles/mod_units/heroes/hero_phoenix/phoenix_sunray.vpcf"
    local target = self:GetParent():GetAbsOrigin() +  Vector(0,0,1) * 300 

    self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( self.effect_cast, 0,  target)
    ParticleManager:SetParticleControl( self.effect_cast, 1, self:GetParent():GetOrigin() )
end

function modifier_phoenix_special_attack_thinker_fire:StopEffects()
    ParticleManager:DestroyParticle(self.effect_cast, false)
    ParticleManager:ReleaseParticleIndex( self.effect_cast )
end

--particles/units/heroes/hero_mars/mars_arena_of_blood_heal.vpcf

