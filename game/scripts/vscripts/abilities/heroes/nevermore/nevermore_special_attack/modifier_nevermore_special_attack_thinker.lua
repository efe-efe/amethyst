modifier_nevermore_special_attack_thinker = class({})

function modifier_nevermore_special_attack_thinker:OnCreated()
    if IsServer() then
        self.origin = self:GetParent():GetOrigin()
        self.radius = self:GetAbility():GetSpecialValueFor("radius")
        self.delay_time = self:GetAbility():GetSpecialValueFor("delay_time")
        self:StartIntervalThink( self.delay_time )
		self:PlayEffects()
    end
end

function modifier_nevermore_special_attack_thinker:OnDestroy()
	if IsServer() then
		self:StopEffects()
		UTIL_Remove( self:GetParent() )
	end
end

function modifier_nevermore_special_attack_thinker:OnIntervalThink()
    local enemies = self:GetCaster():FindUnitsInRadius(
        self.origin, 
        self.radius, 
        DOTA_UNIT_TARGET_TEAM_ENEMY, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER
    )

    -- for each affected enemies
    for _,enemy in pairs(enemies) do
        -- Apply damage
        local damage_table = {
            victim = enemy,
            attacker = caster,
            damage = damage,
            damage_type = DAMAGE_TYPE_MAGICAL,
        }
        ApplyDamage( damage_table )

        enemy:AddNewModifier(
            self:GetCaster(), -- player source
            self:GetAbility(), -- ability source
            "modifier_generic_displacement", -- modifier name
            {
                x = 0,
                y = 0,
                r = 300,
                speed = 150,
                peak = 500,
                restricted = 1,
            } -- kv
        )
        self:GetAbility():PlayEffectsTornado( enemy )
        self:PlayEffectsOnDelayEnds( enemy:GetOrigin() )
    end
	self:Destroy()
end

function modifier_nevermore_special_attack_thinker:PlayEffectsOnDelayEnds( pos )
	EmitSoundOnLocationWithCaster( pos, "Hero_Nevermore.Shadowraze", self:GetCaster() )
end

function modifier_nevermore_special_attack_thinker:PlayEffects()
    local particle_cast = "particles/units/heroes/hero_shadow_demon/shadow_demon_soul_catcher_v2_ground01.vpcf"
    self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( self.effect_cast, 0, self.origin )
	ParticleManager:SetParticleControl( self.effect_cast, 1, self.origin )
    ParticleManager:SetParticleControl( self.effect_cast, 2, self.origin )
    ParticleManager:SetParticleControl( self.effect_cast, 3, Vector(self.radius, 0, 0) )
end

function modifier_nevermore_special_attack_thinker:StopEffects()
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )    
end