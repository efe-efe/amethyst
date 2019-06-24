
modifier_phoenix_special_attack_thinker = class({})

--------------------------------------------------------------------------------
--Clasifications
function modifier_phoenix_special_attack_thinker:IsHidden()
	return true
end

--------------------------------------------------------------------------------
--Initializer
function modifier_phoenix_special_attack_thinker:OnCreated( kv )
    self.radius = kv.radius--self:GetAbility():GetSpecialValueFor( "radius" )
    self.damage_per_second = 3
    self.heal_per_second = 3

    if IsServer() then
        -- Start Interval
        self:StartIntervalThink( 0.3 )
        self:PlayEffects()
    end
end

function modifier_phoenix_special_attack_thinker:OnDestroy()
    if IsServer() then
        self:StopEffects()
		UTIL_Remove( self:GetParent() )
	end
end

--------------------------------------------------------------------------------
--On think
function modifier_phoenix_special_attack_thinker:OnIntervalThink()
    --self:PlayEffects()
    local thinker = self:GetParent()
    local thinker_origin = thinker:GetOrigin()
    
    local ent = Entities:FindAllInSphere(thinker_origin, self.radius)

    local units = FindUnitsInRadius( 
        thinker:GetTeamNumber(), -- int, your team number
        thinker_origin, -- point, center point
        nil, -- handle, cacheUnit. (not known)
        self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
        DOTA_UNIT_TARGET_TEAM_BOTH, -- int, team filter
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
        0, -- int, flag filter
        0, -- int, order filter
        false -- bool, can grow cache
    )

    for _,unit in pairs(units) do
        if unit:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
            unit:Heal(self.heal_per_second, unit)
        else
            local damage = {
                victim = unit,
                attacker = self:GetCaster(),
                damage = self.damage_per_second,
                damage_type = DAMAGE_TYPE_PURE,
            }
    
            ApplyDamage( damage )
        end
    end
end

function modifier_phoenix_special_attack_thinker:PlayEffects()

    -- Create particles
    local particle_cast_a = "particles/mod_units/heroes/hero_phoenix/monkey_king_furarmy_ring.vpcf"
	local particle_cast_b = "particles/econ/items/dazzle/dazzle_dark_light_weapon/dazzle_dark_shallow_grave_ground.vpcf"
    
    self.effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_WORLDORIGIN, nil )
    self.effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_WORLDORIGIN, nil )
    self.effect_cast_c = ParticleManager:CreateParticle( particle_cast_c, PATTACH_WORLDORIGIN, nil )
    
    
    ParticleManager:SetParticleControl( self.effect_cast_a, 0, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( self.effect_cast_a, 1, Vector( self.radius, 1, 1 ) )
    ParticleManager:SetParticleControl( self.effect_cast_a, 2, Vector( 1, 1, 1 ) )
    
    ParticleManager:SetParticleControl( self.effect_cast_b, 0, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( self.effect_cast_b, 1, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( self.effect_cast_b, 3, self:GetParent():GetOrigin() )
end

function modifier_phoenix_special_attack_thinker:StopEffects()
    
    ParticleManager:DestroyParticle(self.effect_cast_a, false)
    ParticleManager:DestroyParticle(self.effect_cast_b, false)
    ParticleManager:ReleaseParticleIndex( self.effect_cast_a )
    ParticleManager:ReleaseParticleIndex( self.effect_cast_b )
end

--particles/units/heroes/hero_mars/mars_arena_of_blood_heal.vpcf