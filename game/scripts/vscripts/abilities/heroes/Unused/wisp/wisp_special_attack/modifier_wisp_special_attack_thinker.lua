modifier_wisp_special_attack_thinker = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_wisp_special_attack_thinker:IsHidden()
	return true
end

--------------------------------------------------------------------------------
-- Initializer
function modifier_wisp_special_attack_thinker:OnCreated( kv )
    if IsServer() then
        self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
        self.damage = self:GetAbility():GetAbilityDamage()
        self.disable_duration = self:GetAbility():GetSpecialValueFor( "disable_duration" )
        self.delay_time = self:GetAbility():GetSpecialValueFor( "delay_time" )
        self.mana_gain = self:GetAbility():GetSpecialValueFor("mana_gain")/100
        
        -- Start Interval
        self:StartIntervalThink( self.delay_time )

        self:PlayEffectsOnCreated()
    end
end

--------------------------------------------------------------------------------
-- On Think
function modifier_wisp_special_attack_thinker:OnIntervalThink()
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
                "modifier_generic_fading_slow", -- modifier name
                { duration = self.disable_duration } -- kv
            )

        end
        
       	-- if at least 1 enemy
        if #enemies > 0 then
            -- Give Mana
            local mana_gain_final = self:GetCaster():GetMaxMana() * self.mana_gain
            self:GetCaster():GiveMana(mana_gain_final)    
        end
        
		self:PlayEffectsOnImpact()

	    self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Graphics & Sounds
function modifier_wisp_special_attack_thinker:PlayEffectsOnCreated()
    local thinker = self:GetParent()

    -- Create Sounds
    EmitSoundOn( "Ability.PreLightStrikeArray", self:GetCaster() )

    -- Create Particles
	local particle_cast = "particles/mod_units/heroes/hero_wisp/wisp_relocate_teleport.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, thinker )
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 1, 1 ) )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_wisp_special_attack_thinker:PlayEffectsOnImpact()
    local thinker = self:GetParent()

    -- Create Sounds
    EmitSoundOnLocationWithCaster( thinker:GetOrigin(), "Ability.LightStrikeArray", thinker )

    -- Create Particles
	local particle_cast = "particles/units/heroes/hero_chen/chen_divine_favor.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, thinker )
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 1, 1 ) )
    ParticleManager:ReleaseParticleIndex( effect_cast )

    local particle_cast_b = "particles/units/heroes/hero_lina/lina_spell_light_strike_array_impact_sparks.vpcf"
    local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_ABSORIGIN_FOLLOW, thinker )
    ParticleManager:SetParticleControl( effect_cast_b, 1, Vector( self.radius, 1, 1 ) )
    ParticleManager:ReleaseParticleIndex( effect_cast_b )
end