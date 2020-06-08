modifier_spectre_counter_thinker_lua = class({})

--------------------------------------------------------------------------------
function modifier_spectre_counter_thinker_lua:IsHidden()
	return true
end

--------------------------------------------------------------------------------
-- Initializer
function modifier_spectre_counter_thinker_lua:OnCreated(kv)
    if IsServer() then
        self.radius = self:GetAbility():GetSpecialValueFor("radius")
        self.damage = self:GetAbility():GetSpecialValueFor("damage")
        self.delay_time = self:GetAbility():GetSpecialValueFor("delay_time")
        
        -- Start Interval
        self:StartIntervalThink(self.delay_time)
        self:PlayEffects()
    end
end

--------------------------------------------------------------------------------

function modifier_spectre_counter_thinker_lua:OnIntervalThink()
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
            damage = self.damage,
            damage_type = DAMAGE_TYPE_MAGICAL,
            ability = self:GetAbility() --Optional.
        }

        for _,enemy in pairs(enemies) do
            -- damage
            damageTable.victim = enemy
            ApplyDamage(damageTable)
            self:PlayEffects3(enemy)
        end
        
		self:PlayEffects2()

	    self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Effects
function modifier_spectre_counter_thinker_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_phoenix/phoenix_fire_spirit_ground.vpcf"
	local sound_cast = "Hero_ShadowDemon.Soul_Catcher"
    local effect_cast = ParticleManager:CreateParticle(
        particle_cast, 
        PATTACH_WORLDORIGIN, 
        self:GetCaster()
   )

    local origin = Vector(
        self:GetParent():GetOrigin().x,
        self:GetParent():GetOrigin().y,
        self:GetParent():GetOrigin().z + 64
   )

    ParticleManager:SetParticleControl(effect_cast, 0, origin)
    ParticleManager:SetParticleControl(effect_cast, 2, origin)
    ParticleManager:ReleaseParticleIndex(effect_cast)

    EmitSoundOn(sound_cast,  self:GetCaster())
end

function modifier_spectre_counter_thinker_lua:PlayEffects2()
    -- Get Resources
	local particle_cast = "particles/units/heroes/hero_spectre/spectre_death_mist.vpcf"
    
    local origin = Vector(
        self:GetParent():GetOrigin().x,
        self:GetParent():GetOrigin().y,
        self:GetParent():GetOrigin().z + 100
   )

    -- particles 1
    local effect_cast = ParticleManager:CreateParticle(
            particle_cast, 
            PATTACH_WORLDORIGIN, 
            nil 
       )
    ParticleManager:SetParticleControl(effect_cast, 0, origin)
    ParticleManager:ReleaseParticleIndex(effect_cast)

    -- particles 2
			
    local particle_cast2 = "particles/units/heroes/hero_spectre/spectre_ambient_endcap.vpcf"
    
    local effect_cast2 = ParticleManager:CreateParticle(
            particle_cast2, 
            PATTACH_WORLDORIGIN, 
            nil 
       )
    ParticleManager:SetParticleControl(effect_cast2, 0, origin)
    ParticleManager:ReleaseParticleIndex(effect_cast2)
end

--disperssion enemy
function modifier_spectre_counter_thinker_lua:PlayEffects3(enemy)
	local particle_cast = "particles/econ/items/spectre/spectre_weapon_diffusal/spectre_desolate_diffusal.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, enemy)

    ParticleManager:ReleaseParticleIndex(effect_cast)

end

