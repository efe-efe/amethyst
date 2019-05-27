modifier_sniper_shrapnel_thinker_lua = class({})
LinkLuaModifier( "modifier_sniper_shrapnel_debuff", "abilities/heroes/sniper/sniper_shared_modifiers/modifier_sniper_shrapnel_debuff", LUA_MODIFIER_MOTION_NONE )

function modifier_sniper_shrapnel_thinker_lua:OnCreated()
    if IsServer() then
        local thinker = self:GetParent()
        local delay = self:GetAbility():GetSpecialValueFor("delay")
        self.thinker_origin = thinker:GetOrigin()
        self.think_interval = self:GetAbility():GetSpecialValueFor("think_interval")
        self.duration = self:GetAbility():GetSpecialValueFor("duration")

        self.knockback_radius = self:GetAbility():GetSpecialValueFor("radius")
        self.knockback_distance = self:GetAbility():GetSpecialValueFor("knockback_distance")
        self.damage = self:GetAbility():GetSpecialValueFor("damage")
        self.slow_linger = self:GetAbility():GetSpecialValueFor("slow_linger")
        

        -- Start Interval
        self:StartIntervalThink( delay )  
    end
end

function modifier_sniper_shrapnel_thinker_lua:OnDestroy()
    if IsServer() then
		ParticleManager:DestroyParticle( self.effect_cast, false )
        ParticleManager:ReleaseParticleIndex( self.effect_cast )    
		UTIL_Remove( self:GetParent() )
	end
end

--------------------------------------------------------------------------------
function modifier_sniper_shrapnel_thinker_lua:OnIntervalThink()
    if not self.start then
		self.start = true
		self:StartIntervalThink( self.think_interval )
		AddFOWViewer( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), self.knockback_radius, self.duration, false )
		-- effects
		self:PlayEffects()
	else
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
            
            enemy:AddNewModifier(
                caster,
                self:GetAbility(),
                "modifier_sniper_shrapnel_debuff",
                {duration = self.slow_linger}
            )
        end
    end
end

function modifier_sniper_shrapnel_thinker_lua:PlayEffects()
    local particle_cast = "particles/mod_units/heroes/hero_sniper/sniper_shrapnel.vpcf"
    
    self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    
    ParticleManager:SetParticleControl( self.effect_cast, 0, self.thinker_origin )
    ParticleManager:SetParticleControl( self.effect_cast, 1, Vector(self.knockback_radius,0,0))
    ParticleManager:SetParticleControl( self.effect_cast, 2, self.thinker_origin )
end
