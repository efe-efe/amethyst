
modifier_phoenix_special_attack_thinker = class({})

--------------------------------------------------------------------------------
--Clasifications
function modifier_phoenix_special_attack_thinker:IsHidden()
	return true
end

--------------------------------------------------------------------------------
--Initializer
function modifier_phoenix_special_attack_thinker:OnCreated( kv )
    self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
    self.damage_per_think = self:GetAbility():GetSpecialValueFor( "damage_per_think" )
    self.heal_per_think = self:GetAbility():GetSpecialValueFor( "heal_per_think" )
    local think_interval = self:GetAbility():GetSpecialValueFor( "think_interval" )

    if IsServer() then
        -- Start Interval
        self:StartIntervalThink( think_interval )
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
            unit:Heal(self.heal_per_think, unit)
        else
            local damage = {
                victim = unit,
                attacker = self:GetCaster(),
                damage = self.damage_per_think,
                damage_type = DAMAGE_TYPE_PURE,
            }
    
            ApplyDamage( damage )
        end
    end
end

function modifier_phoenix_special_attack_thinker:PlayEffects()

    -- Create particles
    local particle_cast_a = "particles/mod_units/heroes/hero_phoenix/monkey_king_furarmy_ring.vpcf"
    
    self.effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_WORLDORIGIN, nil )
    
    ParticleManager:SetParticleControl( self.effect_cast_a, 0, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( self.effect_cast_a, 1, Vector( self.radius, 1, 1 ) )
    ParticleManager:SetParticleControl( self.effect_cast_a, 2, Vector( 1, 1, 1 ) )
    
end

function modifier_phoenix_special_attack_thinker:StopEffects()
    
    ParticleManager:DestroyParticle(self.effect_cast_a, false)
    ParticleManager:ReleaseParticleIndex( self.effect_cast_a )
end

--particles/units/heroes/hero_mars/mars_arena_of_blood_heal.vpcf