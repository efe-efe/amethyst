modifier_nevermore_counter_thinker = class({})

function modifier_nevermore_counter_thinker:OnCreated()
    if IsServer() then
        self.origin = self:GetParent():GetOrigin()
        self.radius = self:GetAbility():GetSpecialValueFor("radius")
        self.delay_time = self:GetAbility():GetSpecialValueFor("delay_time")
        self:StartIntervalThink( self.delay_time )
        self:PlayEffects()
    end
end

function modifier_nevermore_counter_thinker:OnDestroy()
    if IsServer() then
        self:StopEffects()
		UTIL_Remove( self:GetParent() )
	end
end

function modifier_nevermore_counter_thinker:OnIntervalThink()
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

        enemy:RemoveModifierByName("modifier_generic_displacement")
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
                effect = 1
            } -- kv
        )
    end

    FindClearSpaceForUnit( self:GetCaster(), self:GetParent():GetOrigin() , true )

    self:GetCaster():RemoveNoDraw()
    self:GetCaster():RemoveModifierByName("modifier_banish")

    StartAnimation(self:GetCaster(), { 
        duration = 0.5, 
        activity = ACT_DOTA_RAZE_2, 
        rate = 1.2
    })

    self:PlayEffectsOnDelayEnds()
    self:Destroy()
end

function modifier_nevermore_counter_thinker:PlayEffects()
    local particle_cast = "particles/units/heroes/hero_shadow_demon/shadow_demon_soul_catcher_v2_ground01.vpcf"
    self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( self.effect_cast, 0, self.origin )
	ParticleManager:SetParticleControl( self.effect_cast, 1, self.origin )
    ParticleManager:SetParticleControl( self.effect_cast, 2, self.origin )
    ParticleManager:SetParticleControl( self.effect_cast, 3, Vector(self.radius, 0, 0) )
end

function modifier_nevermore_counter_thinker:StopEffects()
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )    
end

function modifier_nevermore_counter_thinker:PlayEffectsOnDelayEnds()
    local caster = self:GetCaster()
	EmitSoundOn( "Hero_Nevermore.Shadowraze", caster )

	local particle_cast = "particles/econ/events/ti9/blink_dagger_ti9_end.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, caster:GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
    
    -- create particle
	local particle_cast_b = "particles/econ/events/ti9/phase_boots_ti9_body_magic.vpcf"
	local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast_b, 0, caster:GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast_b )

	particle_cast_b = "particles/earthshaker_arcana_aftershock.vpcf"
	effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast_b, 0, caster:GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast_b )
end