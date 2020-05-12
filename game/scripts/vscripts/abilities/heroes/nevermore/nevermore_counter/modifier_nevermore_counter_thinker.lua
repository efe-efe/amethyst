modifier_nevermore_counter_thinker = class({})

function modifier_nevermore_counter_thinker:OnCreated(params)
    if IsServer() then
        self.origin = self:GetParent():GetOrigin()
        self.radius = self:GetAbility():GetSpecialValueFor("radius")
        self.delay_time = self:GetAbility():GetSpecialValueFor("delay_time")

        self.damage = params.damage
        self.lift_duration = params.lift_duration

        self:StartIntervalThink( self.delay_time )
    end
end

function modifier_nevermore_counter_thinker:OnDestroy()
	if IsServer() then
		UTIL_Remove( self:GetParent() )
	end
end

function modifier_nevermore_counter_thinker:OnIntervalThink()
	FindClearSpaceForUnit( self:GetCaster(), self.origin , true )
	self:GetCaster():RemoveModifierByName("modifier_banish")
	
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
	
	local distance = 300
	
	for _,enemy in pairs(enemies) do
		damage_table.victim = enemy
		ApplyDamage( damage_table )

		enemy:RemoveModifierByName("modifier_generic_displacement")
		enemy:AddNewModifier(
			self:GetCaster(), -- player source
			self:GetAbility(), -- ability source
			"modifier_generic_displacement", -- modifier name
			{
				x = 0,
				y = 0,
				r = distance,
				speed = (distance/self.lift_duration),
				peak = 500,
				restricted = 1,
				effect = 1,
				i_frame = 1,
			} -- kv
		)
	end
	CreateRadiusMarker(self:GetCaster(), self.origin, {
		show_all = 1,
		radius = self.radius
	})
	StartAnimation(self:GetCaster(), { 
		duration = 0.5, 
		activity = ACT_DOTA_RAZE_2, 
		rate = 1.2
	})

    self:PlayEffects()

	self:Destroy()
end

function modifier_nevermore_counter_thinker:PlayEffects()
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
