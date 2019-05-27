modifier_sniper_ex_mobility_thinker_lua = class({})
LinkLuaModifier( "modifier_sniper_ex_mobility_lua", "abilities/heroes/sniper/sniper_ex_mobility_lua/modifier_sniper_ex_mobility_lua", LUA_MODIFIER_MOTION_NONE )

function modifier_sniper_ex_mobility_thinker_lua:OnCreated()
    if IsServer() then
        local thinker = self:GetParent()
        local delay = 0.1
        self.thinker_origin = thinker:GetOrigin()
        self.think_interval = self:GetAbility():GetSpecialValueFor("think_interval")
        self.duration = self:GetAbility():GetSpecialValueFor("duration")

        self.knockback_radius = self:GetAbility():GetSpecialValueFor("radius")
        self.damage = self:GetAbility():GetSpecialValueFor("damage")
        self.slow_linger = self:GetAbility():GetSpecialValueFor("slow_linger")
        self.initial_damage = self:GetAbility():GetSpecialValueFor("initial_damage")
        -- Start Interval
        self:StartIntervalThink( delay )  
    end
end

function modifier_sniper_ex_mobility_thinker_lua:OnDestroy()
    if IsServer() then
		ParticleManager:DestroyParticle( self.effect_cast_a, false )
        ParticleManager:ReleaseParticleIndex( self.effect_cast_a )    
		UTIL_Remove( self:GetParent() )
	end
end

--------------------------------------------------------------------------------
function modifier_sniper_ex_mobility_thinker_lua:OnIntervalThink()
    local caster = self:GetCaster()
    if not self.start then
		self.start = true
		self:StartIntervalThink( self.think_interval )
        
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
            enemy:AddNewModifier(
                caster, -- player source
                self, -- ability source
                "modifier_sniper_ex_mobility_lua", -- modifier name
                { duration = self.slow_linger } -- kv
            )
            
            local damage = {
                victim = enemy,
                attacker = caster,
                damage = self.initial_damage,
                damage_type = DAMAGE_TYPE_PURE,
            }
    
            ApplyDamage( damage )
        end
        
        self:PlayEffects()
        -- Cast Sound
        local sound_cast = "Hero_Disruptor.ThunderStrike.Thunderator"
        EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), sound_cast, self:GetCaster() )

	else
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
            enemy:AddNewModifier(
                caster, -- player source
                self, -- ability source
                "modifier_sniper_ex_mobility_lua", -- modifier name
                { duration = self.slow_linger } -- kv
            )

            local damage = {
                victim = enemy,
                attacker = caster,
                damage = self.damage,
                damage_type = DAMAGE_TYPE_PURE,
            }
    
            ApplyDamage( damage )
        end
        self:PlayEffects()

    end
end

-- TODO: Mejorar esto
function modifier_sniper_ex_mobility_thinker_lua:PlayEffects()

  
    -- Cast Particles

    local particle_cast_a = "particles/econ/items/disruptor/disruptor_ti8_immortal_weapon/disruptor_ti8_immortal_thunder_strike_bolt_rope.vpcf"
    local particle_cast_b = "particles/econ/items/disruptor/disruptor_ti8_immortal_weapon/disruptor_ti8_immortal_thunder_strike_bolt.vpcf"
    
    self.effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_WORLDORIGIN, nil )
    local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_WORLDORIGIN, nil )

    ParticleManager:SetParticleControl( self.effect_cast_a, 0, self.thinker_origin )
    ParticleManager:SetParticleControl( self.effect_cast_a, 1, Vector(self.knockback_radius,0,0))
    ParticleManager:SetParticleControl( self.effect_cast_a, 2, self.thinker_origin )

    ParticleManager:SetParticleControl( effect_cast_b, 0, self.thinker_origin )
    ParticleManager:ReleaseParticleIndex( effect_cast_b )    

end



