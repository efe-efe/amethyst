modifier_death_zone = class({})

--Initializer
--------------------------------------------------------------------------------
function modifier_death_zone:OnCreated( kv )
    self.max_radius = 5000
    self.radius = 5000--self:GetAbility():GetSpecialValueFor( "radius" )
    self.min_radius = 600
    self.initialized = false

    self.effects = {}

    self.counter = 0
    self.counter_b = 0

    if IsServer() then
        -- Start Interval
        GameRules:SendCustomMessage("The <b><font color='blue'>Death zone</font></b> has initiated, don't get close to the edges!", 0, 0)
        self:StartIntervalThink(0.1)      

        --self:PlayEffectsOnCreated(0, self.radius, 0)
    end
end

function modifier_death_zone:OnRemoved()
    if IsServer() then
        self:StopEffects()
		UTIL_Remove( self:GetParent() )
	end
end

--On think
--------------------------------------------------------------------------------
function modifier_death_zone:OnIntervalThink()

    if self.counter == 10 then 
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
                self:PlayEffectsOnTarget(unit)
            end
        end
        self.counter = 0
    end

    
    if self.counter_b == 10 then
        for i = self.radius, self.max_radius, 200 do
            self:PlayEffectsAoe(i, 0)
        end
        self.counter_b = 0
    end

    local new_radius = self.radius - 5
    if new_radius > self.min_radius then
        self.radius = new_radius
    end

    self.counter = self.counter + 1
    self.counter_b = self.counter_b + 1

    
    --[[
    self:PlayEffectsAoe(self.radius, 512)
    self:PlayEffectsAoe(self.radius, 384)
    self:PlayEffectsAoe(self.radius, 256)
    self:PlayEffectsAoe(self.radius, 128)
    ]]

    self:PlayEffectsAoe(self.radius, 512)
    --self:StopEffects()
    --self:PlayEffectsOnCreated(0, self.radius, 0)
    --self:UpdateParticles()
end

function modifier_death_zone:PlayEffectsAoe(radius, z_offset)
    local particle_cast = "particles/mod_units/instant_aoe_marker.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin()  + Vector(0, 0, z_offset) )
    ParticleManager:SetParticleControl( effect_cast, 2, Vector( radius, radius, radius ) )
    ParticleManager:SetParticleControl( effect_cast, 4, self:GetParent():GetOrigin()  + Vector(0, 0, z_offset) )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_death_zone:PlayEffectsAoeAlternate(radius, z_offset)
    local particle_cast = "particles/aoe_marker.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin()  + Vector(0, 0, z_offset) )
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, 1, 1 ) )
    ParticleManager:SetParticleControl( effect_cast, 2, Vector( 255, 1, 1 ) )
    ParticleManager:SetParticleControl( effect_cast, 3, Vector(0.1, 0, 0) )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_death_zone:UpdateParticles()
    for _,efx in pairs(self.effects) do    
        ParticleManager:SetParticleControl( efx, 1, Vector( self.radius, self.radius, self.radius ) )
    end
end

function modifier_death_zone:PlayEffectsOnCreated(i, radius, z_offset)
    local particle_cast = "particles/units/heroes/hero_zeus/zeus_cloud.vpcf"
    self.effects[i] = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( self.effects[i], 0, self:GetParent():GetOrigin() + Vector(0, 0, z_offset))
    ParticleManager:SetParticleControl( self.effects[i], 1, Vector( radius, 1, 1 ) )
end

function modifier_death_zone:StopEffects()
    for _,efx in pairs(self.effects) do
        ParticleManager:DestroyParticle( efx, false )
        ParticleManager:ReleaseParticleIndex( efx )
    end
end

function modifier_death_zone:PlayEffectsOnTarget( hTarget )
    local particle_cast = "particles/econ/items/lion/fish_stick_retro/fish_stick_spell_fish_retro_b.vpcf"

    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget )
    ParticleManager:ReleaseParticleIndex( effect_cast )

--TODO
    local particle_cast_b = "particles/econ/items/zeus/arcana_chariot/zeus_tgw_screen_damage.vpcf"
    local effect_cast_b = ParticleManager:CreateParticleForPlayer(particle_cast_b, PATTACH_EYES_FOLLOW, hTarget, hTarget:GetPlayerOwner())
    ParticleManager:ReleaseParticleIndex( effect_cast_b )
end