modifier_ancient_extra_thinker = class({})

function modifier_ancient_extra_thinker:OnCreated()
    if IsServer() then
        self.radius = self:GetAbility():GetSpecialValueFor("radius")
        self.delay_time = self:GetAbility():GetSpecialValueFor("delay_time")
        self.stun_radius = self:GetAbility():GetSpecialValueFor("stun_radius")
        self.slow_duration = self:GetAbility():GetSpecialValueFor("slow_duration")
        self.stun_duration = self:GetAbility():GetSpecialValueFor("stun_duration")
        self.stun_duration = self:GetAbility():GetSpecialValueFor("stun_duration")
        self.ability_damage = self:GetAbility():GetSpecialValueFor("ability_damage")
        self.extra_damage = self:GetAbility():GetSpecialValueFor("extra_damage")
        
        self:StartIntervalThink(self.delay_time)
        self:PlayEffects()
    end
end

function modifier_ancient_extra_thinker:OnDestroy()
    if IsServer() then
        self:StopEffects()
		UTIL_Remove(self:GetParent())
	end
end

--------------------------------------------------------------------------------
function modifier_ancient_extra_thinker:OnIntervalThink()
    local caster = self:GetCaster()

    local enemies_big_radius = caster:FindUnitsInRadius(
        self:GetParent():GetOrigin(), 
        self.radius, 
        DOTA_UNIT_TARGET_TEAM_ENEMY, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER
   )

    local enemies_small_radius = caster:FindUnitsInRadius(
        self:GetParent():GetOrigin(), 
        self.stun_radius, 
        DOTA_UNIT_TARGET_TEAM_ENEMY, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER
   )

    for _,enemy in pairs(enemies_big_radius) do
        local continue = true
        for _,exclude in pairs(enemies_small_radius) do
            if exclude == enemy then
                continue = false
                break
            end
        end

        if continue then
            enemy:AddNewModifier(caster, self:GetAbility() , "modifier_generic_fading_slow", { duration = self.slow_duration })
            local damage = {
				victim = enemy,
				attacker = self:GetCaster(),
				damage = self.ability_damage,
				damage_type = DAMAGE_TYPE_PURE,
			}
			ApplyDamage(damage)
        end
    end

    for _,enemy in pairs(enemies_small_radius) do
        enemy:AddNewModifier(caster, self:GetAbility() , "modifier_generic_stunned", { duration = self.stun_duration })
        local damage = {
            victim = enemy,
            attacker = self:GetCaster(),
            damage = self.ability_damage + self.extra_damage,
            damage_type = DAMAGE_TYPE_PURE,
        }
        ApplyDamage(damage)
    end

    self:PlayEffectsOnProc()
end

function modifier_ancient_extra_thinker:PlayEffects()
    EmitSoundOnLocationWithCaster(self:GetParent():GetOrigin(), "Hero_Ancient_Apparition.IceVortex.lp", self:GetCaster())
    local particle_cast = "particles/ancient_ice_vortex.vpcf"
    
    self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    
    ParticleManager:SetParticleControl(self.effect_cast, 0, self:GetParent():GetOrigin())
    ParticleManager:SetParticleControl(self.effect_cast, 5, Vector(self.radius,self.radius,self.radius))
end

function modifier_ancient_extra_thinker:PlayEffectsOnProc()
    local thinker = self:GetParent()
    -- Create particles
	local particle_cast = "particles/units/heroes/hero_treant/treant_overgrowth_hero_glow.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, thinker)
    ParticleManager:SetParticleControl(effect_cast, 1, Vector(self.radius, 1, 1))
    ParticleManager:ReleaseParticleIndex(effect_cast)

    local particle_cast_b = "particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/maiden_crystal_nova_n_cowlofice.vpcf"
    local effect_cast_b = ParticleManager:CreateParticle(particle_cast_b, PATTACH_ABSORIGIN_FOLLOW, thinker)
    ParticleManager:ReleaseParticleIndex(effect_cast_b)
end

function modifier_ancient_extra_thinker:StopEffects()
    StopSoundOn("Hero_Ancient_Apparition", nil)
    ParticleManager:DestroyParticle(self.effect_cast, false)
    ParticleManager:ReleaseParticleIndex(self.effect_cast)    
end

