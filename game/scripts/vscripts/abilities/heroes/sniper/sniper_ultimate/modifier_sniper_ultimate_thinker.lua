modifier_sniper_ultimate_thinker = class({})
LinkLuaModifier( "modifier_sniper_ultimate_movement", "abilities/heroes/sniper/sniper_ultimate/modifier_sniper_ultimate_movement", LUA_MODIFIER_MOTION_HORIZONTAL )

function modifier_sniper_ultimate_thinker:OnCreated()
    if IsServer() then
        local thinker = self:GetParent()
        self.thinker_origin = thinker:GetOrigin()
        local ability = self:GetCaster():FindAbilityByName("sniper_ultimate")

        self.knockback_radius = self:GetAbility():GetSpecialValueFor("radius")
        self.knockback_distance = ability:GetSpecialValueFor("knockback_distance")
        self.damage = ability:GetSpecialValueFor("damage_aoe")

        -- Start Interval
        self:StartIntervalThink( 0.0 )  
    end
end

function modifier_sniper_ultimate_thinker:OnDestroy()
    if IsServer() then
		UTIL_Remove( self:GetParent() )
	end
end

--------------------------------------------------------------------------------
function modifier_sniper_ultimate_thinker:OnIntervalThink()
    local caster = self:GetCaster()

    -- Find enemies
    local enemies = FindUnitsInRadius( 
        caster:GetTeamNumber(), -- int, your team number
        self.thinker_origin, -- point, center point
        nil, -- handle, cacheUnit. (not known)
        self.knockback_radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
        DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
        0, -- int, flag filter
        0, -- int, order filter
        false -- bool, can grow cache
    )

    for _,enemy in pairs(enemies) do
        local damage = {
            victim = enemy,
            attacker = caster,
            damage = self.damage,
            damage_type = DAMAGE_TYPE_PURE,
        }

        ApplyDamage( damage )

        local x = enemy:GetOrigin().x - self.thinker_origin.x
        local y = enemy:GetOrigin().y - self.thinker_origin.y

        enemy:AddNewModifier(
            caster,
            self:GetAbility(),
            "modifier_sniper_ultimate_movement",
            {
                x = x,
                y = y,
                r = self.knockback_distance,
                speed = 2000,
            }
        )
    end
    self:PlayEffects()
    self:Destroy()
end

function modifier_sniper_ultimate_thinker:PlayEffects()
    local particle_cast = "particles/econ/items/techies/techies_arcana/techies_suicide_arcana.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    
    ParticleManager:SetParticleControl( effect_cast, 0, self.thinker_origin )
    ParticleManager:SetParticleControl( effect_cast, 3, self.thinker_origin )

    ParticleManager:ReleaseParticleIndex( effect_cast )    
end
