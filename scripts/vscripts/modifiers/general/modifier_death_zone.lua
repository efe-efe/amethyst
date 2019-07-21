modifier_death_zone = class({})

--Clasifications
--------------------------------------------------------------------------------
function modifier_death_zone:IsHidden()
	return true
end

--Initializer
--------------------------------------------------------------------------------
function modifier_death_zone:OnCreated( kv )
    self.radius = 5000--self:GetAbility():GetSpecialValueFor( "radius" )
    self.min_radius = 400

    if IsServer() then
        -- Start Interval
        GameRules:SendCustomMessage("The <b><font color='blue'>Death zone</font></b> has initiated, don't get close to the edges!", 0, 0)
        self:StartIntervalThink(1.0)      
    end
end

function modifier_death_zone:OnDestroy()
	if IsServer() then
		UTIL_Remove( self:GetParent() )
	end
end

--On think
--------------------------------------------------------------------------------
function modifier_death_zone:OnIntervalThink()
    self:PlayEffects()
    
    local all_units = FindUnitsInRadius(
        DOTA_TEAM_NOTEAM,	-- int, your team number
        self:GetParent():GetOrigin(),	-- point, center point
        nil,	-- handle, cacheUnit. (not known)
        FIND_UNITS_EVERYWHERE,	-- float, radius. or use FIND_UNITS_EVERYWHERE
        DOTA_UNIT_TARGET_TEAM_BOTH,	-- int, team filter
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
        DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED,	-- int, flag filter
        0,	-- int, order filter
        false	-- bool, can grow cache
    )

    local not_affected = FindUnitsInRadius(
        DOTA_TEAM_NOTEAM,	-- int, your team number
        self:GetParent():GetOrigin(),	-- point, center point
        nil,	-- handle, cacheUnit. (not known)
        self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
        DOTA_UNIT_TARGET_TEAM_BOTH,	-- int, team filter
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
        DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED,	-- int, flag filter
        0,	-- int, order filter
        false	-- bool, can grow cache
    )

    for _,unit in pairs(all_units) do
        local continue = true
        for _,exclude in pairs(not_affected) do
            if exclude == unit then
                continue = false
                break
            end
        end

        if continue then
            local damage_table = {
                damage = 15,
                damage_type = DAMAGE_TYPE_PURE,
                victim = unit,
                attacker = unit,
            }
            ApplyDamage( damage_table )
        end
    end

    local new_radius = self.radius - 150
    if new_radius > self.min_radius then
        self.radius = new_radius
    end
end

function modifier_death_zone:PlayEffects()
	local particle_cast = "particles/mod_units/heroes/hero_dark_willow/dw_ti8_immortal_cursed_crown_marker.vpcf"
    
    -- particles 1
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 2, Vector( self.radius, self.radius , self.radius ) )
    ParticleManager:SetParticleControl( effect_cast, 4, self:GetParent():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end