modifier_sniper_mobility_thinker_lua = class({})
LinkLuaModifier( "modifier_sniper_mobility_lua", "abilities/heroes/sniper/sniper_mobility_lua/modifier_sniper_mobility_lua", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_sniper_shrapnel_debuff", "abilities/heroes/sniper/sniper_shared_modifiers/modifier_sniper_shrapnel_debuff", LUA_MODIFIER_MOTION_NONE )

function modifier_sniper_mobility_thinker_lua:OnCreated()
    if IsServer() then
        local delay = self:GetAbility():GetSpecialValueFor( "delay" )
        self.knockback_radius = self:GetAbility():GetSpecialValueFor("radius")
        self.knockback_distance = self:GetAbility():GetSpecialValueFor("knockback_distance")
        self.base_damage = self:GetAbility():GetSpecialValueFor("base_damage")
        self.slow_linger = self:GetAbility():GetSpecialValueFor("slow_linger")
        
        -- Start Interval
        self:StartIntervalThink( delay ) 
    end
end

function modifier_sniper_mobility_thinker_lua:OnDestroy()
    if IsServer() then
		UTIL_Remove( self:GetParent() )
	end
end

--------------------------------------------------------------------------------
function modifier_sniper_mobility_thinker_lua:OnIntervalThink()
    if IsServer() then
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

        --Find allies to heal
        local units = FindUnitsInRadius( 
            caster:GetTeamNumber(), -- int, your team number
            self:GetParent():GetOrigin(), -- point, center point
            nil, -- handle, cacheUnit. (not known)
            self.knockback_radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
            DOTA_UNIT_TARGET_TEAM_BOTH, -- int, team filter
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
            0, -- int, flag filter
            0, -- int, order filter
            false -- bool, can grow cache
        )

        for _,unit in pairs(units) do
            --Knockback
            local x = unit:GetOrigin().x - self:GetParent():GetOrigin().x
            local y = unit:GetOrigin().y - self:GetParent():GetOrigin().y
            local difference = unit:GetOrigin() - self:GetParent():GetOrigin()
            local movement_modifier = unit:AddNewModifier(
                caster, -- player source
                self:GetAbility(), -- ability source
                "modifier_sniper_mobility_lua", -- modifier name
                {
                    x = x,
                    y = y,
                    r = self.knockback_distance,
                    speed = 2000,
                } -- kv
            )
        end

        for _,enemy in pairs(enemies) do
            
            --Damage
            local damage = {
                victim = enemy,
                attacker = caster,
                damage = self.base_damage,
                damage_type = DAMAGE_TYPE_PURE,
            }

            ApplyDamage( damage )

            enemy:AddNewModifier(
                caster,
                self:GetAbility(),
                "modifier_sniper_shrapnel_debuff",
                {duration = self.slow_linger}
            )
        end

        self:PlayEffects()
        self:Destroy()
    end
end

function modifier_sniper_mobility_thinker_lua:PlayEffects()

    -- Cast particle
    local particle_cast = "particles/econ/courier/courier_cluckles/courier_cluckles_ambient_rocket_explosion.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 3, self:GetParent():GetOrigin())
    
    ParticleManager:ReleaseParticleIndex( effect_cast )    
end