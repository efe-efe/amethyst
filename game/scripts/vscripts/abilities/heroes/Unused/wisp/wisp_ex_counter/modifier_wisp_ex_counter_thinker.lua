modifier_wisp_ex_counter_thinker = class({})

--------------------------------------------------------------------------------

function modifier_wisp_ex_counter_thinker:IsHidden()
	return true
end

--------------------------------------------------------------------------------

function modifier_wisp_ex_counter_thinker:OnCreated(kv)
    if IsServer() then
        self.radius = self:GetAbility():GetSpecialValueFor("radius")
        self.damage = self:GetAbility():GetSpecialValueFor("damage")
        self.disable_duration = self:GetAbility():GetSpecialValueFor("disable_duration")
        self.delay_time = self:GetAbility():GetSpecialValueFor("delay_time")
        self.heal = self:GetAbility():GetSpecialValueFor("heal")
        
        -- Start Interval
        self:StartIntervalThink(self.delay_time)

        self:PlayEffects()
    end
end

--------------------------------------------------------------------------------

function modifier_wisp_ex_counter_thinker:OnIntervalThink()
    if IsServer() then
        -- find enemies
        local allies = FindUnitsInRadius(
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

		for _,ally in pairs(allies) do
            ally:Heal(self.heal , self:GetParent())
		end

        -- effects
		self:PlayEffects2()

	    self:Destroy()
	end
end

--------------------------------------------------------------------------------

function modifier_wisp_ex_counter_thinker:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/mod_units/heroes/hero_wisp/wisp_relocate_teleport.vpcf"
	local sound_cast = "Hero_Omniknight.Purification"

    local effect_cast = ParticleManager:CreateParticle(
        particle_cast, 
        PATTACH_WORLDORIGIN, 
        self:GetCaster()
   )

    ParticleManager:SetParticleControl(effect_cast, 0, self:GetParent():GetOrigin())
    ParticleManager:SetParticleControl(effect_cast, 1, Vector(self.radius, 1, 1))
    ParticleManager:ReleaseParticleIndex(effect_cast)

    EmitSoundOn(
        sound_cast, 
        self:GetCaster() 
   )
end

function modifier_wisp_ex_counter_thinker:PlayEffects2()
    -- Create Sound
    --local sound_cast = "Ability.LightStrikeArray"
    --EmitSoundOnLocationWithCaster(self:GetParent():GetOrigin(), sound_cast, self:GetCaster())

    -- particles 2
    local particle_cast = "particles/units/heroes/hero_omniknight/omniknight_purification.vpcf"
    
    local effect_cast = ParticleManager:CreateParticle(
            particle_cast, 
            PATTACH_WORLDORIGIN, 
            nil 
       )
    ParticleManager:SetParticleControl(effect_cast, 0, self:GetParent():GetOrigin())
    ParticleManager:ReleaseParticleIndex(effect_cast)
end
