modifier_nevermore_special_attack_thinker = class({})

function modifier_nevermore_special_attack_thinker:OnCreated( params )
    if IsServer() then
        self.duration = self:GetAbility():GetSpecialValueFor("duration")
        self.mana_gain_pct = self:GetAbility():GetSpecialValueFor("mana_gain_pct")
        self.origin = self:GetParent():GetOrigin()

        self.radius = params.radius
        self.damage = params.damage
        local delay_time = params.delay_time
        self:StartIntervalThink( delay_time )
    end
end

function modifier_nevermore_special_attack_thinker:OnDestroy()
	if IsServer() then
		UTIL_Remove( self:GetParent() )
	end
end

function modifier_nevermore_special_attack_thinker:OnIntervalThink()
	local give_mana = false

    local enemies = self:GetCaster():FindUnitsInRadius(
        self.origin, 
        self.radius, 
        DOTA_UNIT_TARGET_TEAM_ENEMY, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER
    )
    
    local damage_table = {
        attacker = self:GetCaster(),
        damage = self.damage,
        damage_type = DAMAGE_TYPE_PURE,
    }
    
    for _,enemy in pairs(enemies) do
        damage_table.victim = enemy
        ApplyDamage( damage_table )

        enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_generic_stunned", { duration = self.duration })
        
        if not enemy:IsObstacle() then
            give_mana = true
        end
    end

    if give_mana then
        self:GetCaster():GiveManaPercent(self.mana_gain_pct)    
    end

    self:PlayEffects( self.origin, self.radius)
	self:Destroy()
end

function modifier_nevermore_special_attack_thinker:PlayEffects( point, radius )
    EmitSoundOn( "Hero_Nevermore.Shadowraze.Arcana", self:GetCaster() )

	local particle_cast = "particles/nevermore_e.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, point )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	local particle_cast_b = "particles/econ/items/axe/axe_ti9_immortal/axe_ti9_call.vpcf"
	local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_WORLDORIGIN, nil )
	
	ParticleManager:SetParticleControl( effect_cast_b, 0, point )
	ParticleManager:SetParticleControl( effect_cast_b, 2, Vector(radius, radius, radius))
    ParticleManager:ReleaseParticleIndex( effect_cast_b )

    CreateRadiusMarker(self:GetCaster(), point, {
        show_all = 1,
        radius = radius
    })
end
