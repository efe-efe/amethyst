modifier_sniper_mobility_thinker = class({})

function modifier_sniper_mobility_thinker:OnCreated( params )
    if IsServer() then
        local delay = self:GetAbility():GetSpecialValueFor( "delay" )
        self.knockback_radius = self:GetAbility():GetSpecialValueFor("radius")
        self.base_damage = self:GetAbility():GetAbilityDamage()
        self.slow_linger = self:GetAbility():GetSpecialValueFor("slow_linger")

        self.x = params.x
        self.y = params.y
        self.distance = params.distance
        
        -- Start Interval
        self:StartIntervalThink( delay ) 
    end
end

function modifier_sniper_mobility_thinker:OnDestroy()
    if IsServer() then
		UTIL_Remove( self:GetParent() )
	end
end

--------------------------------------------------------------------------------
function modifier_sniper_mobility_thinker:OnIntervalThink()
    local caster = self:GetCaster()

    --Find enemies to damage
    local enemies = FindUnitsInRadius( 
        caster:GetTeamNumber(), -- int, your team number
        self:GetParent():GetOrigin(), -- point, center point
        nil, -- handle, cacheUnit. (not known)
        self.knockback_radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
        DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
        0, -- int, flag filter
        0, -- int, order filter
        false -- bool, can grow cache
    )

    --Knockback
    caster:AddNewModifier(
        caster, -- player source
        self:GetAbility(), -- ability source
        "modifier_generic_displacement", -- modifier name
        {
            x = self.x,
            y = self.y,
            r = self.distance,
            speed = 2000,
            peak = 100,
            colliding = 1,
        } -- kv
    )
    --end

    for _,enemy in pairs(enemies) do
        local damage = {
            victim = enemy,
            attacker = caster,
            damage = self.base_damage,
            damage_type = DAMAGE_TYPE_PURE,
        }

        ApplyDamage( damage )

        -- Add modifier
        enemy:AddNewModifier(
            caster, -- player source
            self:GetAbility(), -- ability source
            "modifier_generic_knockback", -- modifier name
            { 
                duration = 0.5,
                distance = 150,
                z = 100,
                x = -self.x,
                y = -self.y,
                disable = 1,
                invulnerable = 1,
            } -- kv
        )
    end

    self:PlayEffects()
    self:Destroy()
end

function modifier_sniper_mobility_thinker:PlayEffects()

    -- Cast particle
    local particle_cast = "particles/econ/courier/courier_cluckles/courier_cluckles_ambient_rocket_explosion.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 3, self:GetParent():GetOrigin())
    
    ParticleManager:ReleaseParticleIndex( effect_cast )    
end