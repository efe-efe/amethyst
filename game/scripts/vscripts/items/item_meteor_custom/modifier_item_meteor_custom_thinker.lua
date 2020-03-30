modifier_item_meteor_custom_thinker = class({})

function modifier_item_meteor_custom_thinker:OnCreated()
    if IsServer() then
        self.origin = self:GetParent():GetOrigin()
        self.radius = self:GetAbility():GetSpecialValueFor("radius")
        self.delay_time = self:GetAbility():GetSpecialValueFor("delay_time")
        self.ability_damage = self:GetAbility():GetSpecialValueFor("ability_damage")
        self.duration = self:GetAbility():GetSpecialValueFor("duration")
        self.stun_duration = self:GetAbility():GetSpecialValueFor("stun_duration")

		self:StartIntervalThink( self.delay_time )
		self:PlayEffects()
    end
end

function modifier_item_meteor_custom_thinker:OnDestroy()
	if IsServer() then
		self:StopEffects()
		UTIL_Remove( self:GetParent() )
	end
end

function modifier_item_meteor_custom_thinker:OnIntervalThink()
    local enemies = self:GetCaster():FindUnitsInRadius(
		self.origin, 
		self.radius, 
		DOTA_UNIT_TARGET_TEAM_ENEMY, 
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		FIND_ANY_ORDER
	)
	
	for _,enemy in pairs(enemies) do
		local damage_table = {
			victim = enemy,
			attacker = self:GetCaster(),
			damage = self.ability_damage,
			damage_type = DAMAGE_TYPE_PURE,
		}
		ApplyDamage( damage_table )
		
		enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_item_meteor_custom", { duration = self.duration })
		enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_generic_stunned", duration = self.stun_duration)
	end


	EmitSoundOn( "DOTA_Item.MeteorHammer.Impact", self:GetCaster() )
	self:Destroy()
end

function modifier_item_meteor_custom_thinker:PlayEffects()
    local particle_cast = "particles/items4_fx/meteor_hammer_spell.vpcf"
    self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( self.effect_cast, 0, self.origin + Vector(500, 500, 1000))
    ParticleManager:SetParticleControl( self.effect_cast, 1, self.origin )
    ParticleManager:SetParticleControl( self.effect_cast, 2, Vector(0.5,0,0) )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )    
end

function modifier_item_meteor_custom_thinker:StopEffects()
	ParticleManager:DestroyParticle( self.effect_cast, false )
end