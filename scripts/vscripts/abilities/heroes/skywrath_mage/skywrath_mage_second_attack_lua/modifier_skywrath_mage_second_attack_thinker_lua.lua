modifier_skywrath_mage_second_attack_thinker_lua = class({})
LinkLuaModifier( "modifier_skywrath_mage_second_attack_reducer_lua", "abilities/heroes/skywrath_mage/skywrath_mage_second_attack_lua/modifier_skywrath_mage_second_attack_reducer_lua", LUA_MODIFIER_MOTION_NONE )


--------------------------------------------------------------------------------

function modifier_skywrath_mage_second_attack_thinker_lua:IsHidden()
	return true
end

--------------------------------------------------------------------------------

function modifier_skywrath_mage_second_attack_thinker_lua:OnCreated( kv )
    if IsServer() then
        self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
        self.heal = self:GetAbility():GetSpecialValueFor( "heal" )
        self.delay_time = self:GetAbility():GetSpecialValueFor( "delay_time" )
        self.mana_gain = self:GetAbility():GetSpecialValueFor("mana_gain")
        self.cooldown_reduction = self:GetAbility():GetSpecialValueFor("cooldown_reduction")
        
        local caster = self:GetCaster()

        -- Start Interval
        self:StartIntervalThink( self.delay_time )

        self:PlayEffects()
    end
end

--------------------------------------------------------------------------------

function modifier_skywrath_mage_second_attack_thinker_lua:OnIntervalThink()
    if IsServer() then
        -- find enemies
        local alies = FindUnitsInRadius( 
            self:GetParent():GetTeamNumber(), -- int, your team number
            self:GetParent():GetOrigin(), -- point, center point
            nil, -- handle, cacheUnit. (not known)
            self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
            DOTA_UNIT_TARGET_TEAM_FRIENDLY, -- int, team filter
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
            0, -- int, flag filter
            0, -- int, order filter
            false -- bool, can grow cache
        )

        -- Heal allys
        for _,ally in pairs(alies) do
            ally:Heal(self.heal, self:GetCaster())
            self:GetCaster():AddNewModifier(
                self:GetCaster(),
                self:GetAbility(),
                "modifier_skywrath_mage_second_attack_reducer_lua",
                {}
            )
        end

        -- if at least 1 ally
            if #alies > 0 then
            -- Give Mana
            local mana_gain_final = self:GetCaster():GetMaxMana() * self.mana_gain
            self:GetCaster():GiveMana(mana_gain_final)    
        end
        

		self:PlayEffects2()
	    self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Graphics & Sounds

-- On casted
function modifier_skywrath_mage_second_attack_thinker_lua:PlayEffects()
	-- Get Resources
	local particle_cast_a = "particles/econ/events/darkmoon_2017/darkmoon_calldown_marker_ring.vpcf"
	local sound_cast = "Hero_Omniknight.Purification.Wingfall.Layer"

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

    EmitSoundOn( 
        sound_cast, 
        self:GetCaster() 
    )
end

-- On arrival
function modifier_skywrath_mage_second_attack_thinker_lua:PlayEffects2()
    -- Get Resources
    local sound_cast = "Hero_Omniknight.GuardianAngel"
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


    EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), sound_cast, self:GetCaster() )
end
