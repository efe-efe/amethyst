modifier_wisp_special_attack_thinker_lua = class({})

--------------------------------------------------------------------------------

function modifier_wisp_special_attack_thinker_lua:IsHidden()
	return true
end

--------------------------------------------------------------------------------

function modifier_wisp_special_attack_thinker_lua:OnCreated( kv )
    if IsServer() then
        self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
        self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
        self.disable_duration = self:GetAbility():GetSpecialValueFor( "disable_duration" )
        self.delay_time = self:GetAbility():GetSpecialValueFor( "delay_time" )
        self.mana_gain = self:GetAbility():GetSpecialValueFor("mana_gain")
        
        -- Start Interval
        self:StartIntervalThink( self.delay_time )

        self:PlayEffects()
    end
end

--------------------------------------------------------------------------------

function modifier_wisp_special_attack_thinker_lua:OnIntervalThink()
    if IsServer() then
        -- find enemies
        local enemies = FindUnitsInRadius( 
            self:GetParent():GetTeamNumber(), -- int, your team number
            self:GetParent():GetOrigin(), -- point, center point
            nil, -- handle, cacheUnit. (not known)
            self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
            DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
            0, -- int, flag filter
            0, -- int, order filter
            false -- bool, can grow cache
        )

        local damageTable = {
		    -- victim = target,
            attacker = self:GetCaster(),
            --damage = self.damage,
            damage_type = DAMAGE_TYPE_PURE,
            ability = self:GetAbility(), --Optional.
            damage = self.damage
        }

        for _,enemy in pairs(enemies) do

            -- damage
            damageTable.victim = enemy
            ApplyDamage(damageTable)

            -- slow
            enemy:AddNewModifier( 
                self:GetCaster(), -- player source
                self:GetAbility(), -- ability source
                "modifier_generic_fading_slow_lua", -- modifier name
                { duration = self.disable_duration } -- kv
            )

        end
        
       	-- if at least 1 enemy
        if #enemies > 0 then
            -- Give Mana
            local mana_gain_final = self:GetCaster():GetMaxMana() * self.mana_gain
            self:GetCaster():GiveMana(mana_gain_final)    
        end
        
		self:PlayEffects2()

	    self:Destroy()
	end
end

--------------------------------------------------------------------------------

function modifier_wisp_special_attack_thinker_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/mod_units/heroes/hero_wisp/wisp_relocate_teleport.vpcf"
	local sound_cast = "Ability.PreLightStrikeArray"

    local effect_cast = ParticleManager:CreateParticle( 
        particle_cast, 
        PATTACH_WORLDORIGIN, 
        self:GetCaster()
    )

    ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 1, 1 ) )
    ParticleManager:ReleaseParticleIndex( effect_cast )

    EmitSoundOn( 
        sound_cast, 
        self:GetCaster() 
    )
end

function modifier_wisp_special_attack_thinker_lua:PlayEffects2()
    -- Get Resources
    local sound_cast = "Ability.LightStrikeArray"
	local particle_cast = "particles/units/heroes/hero_chen/chen_divine_favor.vpcf"
    
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
			
    local particle_cast2 = "particles/units/heroes/hero_lina/lina_spell_light_strike_array_impact_sparks.vpcf"
    
    local effect_cast2 = ParticleManager:CreateParticle( 
            particle_cast2, 
            PATTACH_WORLDORIGIN, 
            nil 
        )
    ParticleManager:SetParticleControl( effect_cast2, 0, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast2, 1, Vector( self.radius, 1, 1 ) )
    ParticleManager:ReleaseParticleIndex( effect_cast2 )


    EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), sound_cast, self:GetCaster() )
end
