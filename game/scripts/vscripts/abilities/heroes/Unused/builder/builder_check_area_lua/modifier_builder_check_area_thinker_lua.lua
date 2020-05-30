modifier_builder_check_area_thinker_lua = class({})

--Clasifications
--------------------------------------------------------------------------------
function modifier_builder_check_area_thinker_lua:IsHidden()
	return true
end

-- Initializer
--------------------------------------------------------------------------------
function modifier_builder_check_area_thinker_lua:OnCreated( kv )
    if IsServer() then
        self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
        self.delay_time = self:GetAbility():GetSpecialValueFor( "delay_time" )
        
        local caster = self:GetCaster()

        -- Start Interval
        self:StartIntervalThink( self.delay_time )

        self:PlayEffects()
    end
end

-- On Think
--------------------------------------------------------------------------------
function modifier_builder_check_area_thinker_lua:OnIntervalThink()
    if IsServer() then
        -- find enemies
        local units = FindUnitsInRadius( 
            self:GetParent():GetTeamNumber(), -- int, your team number
            self:GetParent():GetOrigin(), -- point, center point
            nil, -- handle, cacheUnit. (not known)
            self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
            DOTA_UNIT_TARGET_TEAM_BOTH, -- int, team filter
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
            0, -- int, flag filter
            0, -- int, order filter
            false -- bool, can grow cache
        )

        -- Print units
        for _,unit in pairs(units) do
            print("Unit: " .. unit:GetName())
        end

		self:PlayEffects2()
	    self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Graphics & Sounds

-- On casted
function modifier_builder_check_area_thinker_lua:PlayEffects()
	-- Get Resources
	local particle_cast_a = "particles/econ/events/darkmoon_2017/darkmoon_calldown_marker_ring.vpcf"

    local effect_cast_a = ParticleManager:CreateParticle( 
        particle_cast_a, 
        PATTACH_WORLDORIGIN, 
        nil
    )

    ParticleManager:SetParticleControl( effect_cast_a, 0, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast_a, 1, Vector( self.radius, 1, 1 ) )
    ParticleManager:SetParticleControl( effect_cast_a, 2, Vector( 1, 1, 1 ) )
    ParticleManager:ReleaseParticleIndex( effect_cast_a )

	local particle_cast_b = "particles/econ/items/effigies/status_fx_effigies/base_statue_destruction_gold_lvl2_e.vpcf"

    local effect_cast_b = ParticleManager:CreateParticle( 
        particle_cast_b, 
        PATTACH_WORLDORIGIN, 
        self:GetCaster()
    )

    ParticleManager:SetParticleControl( effect_cast_b, 0, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast_b, 1, Vector( self.radius, 1, 1 ) )
    ParticleManager:ReleaseParticleIndex( effect_cast_b )
end

-- On arrival
function modifier_builder_check_area_thinker_lua:PlayEffects2()
	local particle_cast = "particles/mod_units/heroes/hero_skywrath_mage/skywrath_mage_mystic_flare_ambient_hit_empyrean.vpcf"
    
    -- particles 1
    local effect_cast = ParticleManager:CreateParticle( 
            particle_cast, 
            PATTACH_WORLDORIGIN, 
            nil 
        )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 1, 1 ) )
    ParticleManager:ReleaseParticleIndex( effect_cast )

    -- particles 2
			
    local particle_cast2 = "particles/units/heroes/hero_silencer/silencer_last_word_status_ring_end.vpcf"
    
    local effect_cast2 = ParticleManager:CreateParticle( 
            particle_cast2, 
            PATTACH_WORLDORIGIN, 
            nil 
        )
    ParticleManager:SetParticleControl( effect_cast2, 0, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast2, 1, Vector( self.radius, 1, 1 ) )
    ParticleManager:ReleaseParticleIndex( effect_cast2 )
end
