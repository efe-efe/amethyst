modifier_vengeful_extra_thinker = class({})

function modifier_vengeful_extra_thinker:OnCreated(kv)
    if IsServer() then
        self.origin = self:GetParent():GetAbsOrigin()
        self.ability = self:GetAbility()
        self.radius = self.ability:GetSpecialValueFor("radius")
        self.delay_time = self.ability:GetSpecialValueFor("delay_time")
        self.duration = self.ability:GetSpecialValueFor("duration")
        self.damage_block = self.ability:GetSpecialValueFor("damage_block")

        self:StartIntervalThink(self.delay_time)
        self:PlayEffectsOnCreated()
        CreateTimedRadiusMarker(self:GetCaster(), self.origin, self.radius, self.delay_time, 0.2, RADIUS_SCOPE_PUBLIC)
    end
end

function modifier_vengeful_extra_thinker:OnDestroy()
    if IsServer() then
        DEFX(self.efx, false)
        UTIL_Remove(self:GetParent())
    end
end

function modifier_vengeful_extra_thinker:OnIntervalThink()
    if IsServer() then
        local caster = self:GetCaster()

        local allies = CustomEntities:FindUnitsInRadius(
        caster,
            self.origin, 
            self.radius, 
            DOTA_UNIT_TARGET_TEAM_FRIENDLY, 
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
            DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_ANY_ORDER
        )

        for _,ally in pairs(allies) do
            ally:AddNewModifier(caster, self.ability, "modifier_vengeful_extra", { duration = self.duration, damage_block = self.damage_block })
            EmitSoundOn("Hero_Disruptor.KineticField", ally)
        end

        
		self:PlayEffectsOnImpact()
	    self:Destroy()
	end
end

function modifier_vengeful_extra_thinker:PlayEffectsOnCreated()
    EmitSoundOn("Hero_VengefulSpirit.Missile.Cast.TI8.Layer", thinker)
    
    self.efx = ParticleManager:CreateParticle("particles/addons_gameplay/morokai_orb_large.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(self.efx, 0, self.origin)
    ParticleManager:SetParticleControl(self.efx, 1, Vector(1, 0, 0))
    ParticleManager:SetParticleControl(self.efx, 10, Vector(2.5, 0, 0))
end

function modifier_vengeful_extra_thinker:PlayEffectsOnImpact()
    EmitSoundOn("Hero_VengefulSpirit.Missile.Target.TI8.Layer", self:GetParent())

    local efx = ParticleManager:CreateParticle("particles/units/heroes/hero_treant/treant_overgrowth_hero_glow.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(efx, 0, self.origin)
    ParticleManager:SetParticleControl(efx, 1, Vector(self.radius, 1, 1))
    ParticleManager:ReleaseParticleIndex(efx)

    efx = ParticleManager:CreateParticle("particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/maiden_crystal_nova_n_cowlofice.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(efx, 0, self.origin)
    ParticleManager:ReleaseParticleIndex(efx)
end

