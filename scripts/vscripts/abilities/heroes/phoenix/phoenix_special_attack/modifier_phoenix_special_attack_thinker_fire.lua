
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
    -- Create particles
    local particle_cast_a = "particles/econ/items/dazzle/dazzle_dark_light_weapon/dazzle_dark_shallow_grave_ground_fire.vpcf"
    self.effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( self.effect_cast_a, 0, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( self.effect_cast_a, 1, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( self.effect_cast_a, 3, self:GetParent():GetOrigin() )

end

function modifier_phoenix_special_attack_thinker_fire:StopEffects()
    ParticleManager:DestroyParticle(self.effect_cast_a, false)
    ParticleManager:ReleaseParticleIndex( self.effect_cast_a )
end

--particles/units/heroes/hero_mars/mars_arena_of_blood_heal.vpcf

