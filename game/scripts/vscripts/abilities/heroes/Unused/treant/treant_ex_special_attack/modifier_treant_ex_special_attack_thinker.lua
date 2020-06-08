modifier_treant_ex_special_attack_thinker = class({})

--------------------------------------------------------------------------------
-- Initializer
function modifier_treant_ex_special_attack_thinker:OnCreated(kv)
    if IsServer() then
        self.radius = self:GetAbility():GetSpecialValueFor("radius")
        self.delay_time = self:GetAbility():GetSpecialValueFor("delay_time")
        self.heal = self:GetAbility():GetSpecialValueFor("heal")

        -- Start Interval
        self:StartIntervalThink(self.delay_time)
        self:PlayEffectsOnCreated()
    end
end

--------------------------------------------------------------------------------
-- On think
function modifier_treant_ex_special_attack_thinker:OnIntervalThink()
    if IsServer() then
        local caster = self:GetCaster()
        local thinker = self:GetParent()

         -- Find allies
        local allies = FindUnitsInRadius(
            caster:GetTeamNumber(), -- int, your team number
            thinker:GetOrigin(), -- point, center point
            nil, -- handle, cacheUnit. (not known)
            self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
            DOTA_UNIT_TARGET_TEAM_FRIENDLY, -- int, team filter
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
            0, -- int, flag filter
            0, -- int, order filter
            false -- bool, can grow cache
       )

        for _,ally in pairs(allies) do
            ally:Heal(self.heal, self:GetCaster())
        end

        CreateRadiusMarker(caster, thinker:GetOrigin(), { 
            show_all = 1,
            radius = self.radius,
        })
        
		self:PlayEffectsOnImpact()
	    self:Destroy()
	end
end

--------------------------------------------------------------------------------

function modifier_treant_ex_special_attack_thinker:PlayEffectsOnCreated()
    local thinker = self:GetParent()
    -- Create sound
    EmitSoundOn("Hero_Treant.LeechSeed.Cast", thinker)
    
    -- Create particles
	local particle_cast = "particles/econ/items/natures_prophet/natures_prophet_weapon_sufferwood/furion_teleport_end_team_sufferwood.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, thinker)
    ParticleManager:SetParticleControl(effect_cast, 1, thinker:GetOrigin())
    ParticleManager:ReleaseParticleIndex(effect_cast)
end

function modifier_treant_ex_special_attack_thinker:PlayEffectsOnImpact()
    local thinker = self:GetParent()
    -- Create sound
    EmitSoundOn("Hero_Treant.LivingArmor.Target", thinker)

    -- Create particles
	local particle_cast = "particles/units/heroes/hero_treant/treant_overgrowth_hero_glow.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, thinker)
    ParticleManager:SetParticleControl(effect_cast, 1, Vector(self.radius, 1, 1))
    ParticleManager:ReleaseParticleIndex(effect_cast)

    local particle_cast_b = "particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/maiden_crystal_nova_n_cowlofice.vpcf"
    local effect_cast_b = ParticleManager:CreateParticle(particle_cast_b, PATTACH_ABSORIGIN_FOLLOW, thinker)
    ParticleManager:ReleaseParticleIndex(effect_cast_b)
end
