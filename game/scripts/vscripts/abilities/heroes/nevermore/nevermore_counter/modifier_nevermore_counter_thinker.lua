modifier_nevermore_counter_thinker = class({})

function modifier_nevermore_counter_thinker:OnCreated(params)
	if IsServer() then
		self.radius = self:GetAbility():GetSpecialValueFor("radius")
		self.fear_duration = self:GetAbility():GetSpecialValueFor("fear_duration")
		self.damage_table = {
			attacker = self:GetCaster(),
			damage = self:GetAbility():GetSpecialValueFor("ability_damage"),
			damage_type = DAMAGE_TYPE_PURE,
		}
		self:PlayEffects()
    end
end

function modifier_nevermore_counter_thinker:OnDestroy()
	if IsServer() then
		self:StopEffects()
		UTIL_Remove(self:GetParent())
	end
end

function modifier_nevermore_counter_thinker:OnDelayEnds()
	if IsServer() then
		FindClearSpaceForUnit(self:GetCaster(), self:GetParent():GetAbsOrigin() , true )

		local enemies = self:GetCaster():FindUnitsInRadius(
			self:GetParent():GetOrigin(), 
			self.radius, 
			DOTA_UNIT_TARGET_TEAM_ENEMY, 
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER
		)

		for _,enemy in pairs(enemies) do
			self.damage_table.victim = enemy
			ApplyDamage(self.damage_table)

			enemy:AddNewModifier(
				self:GetCaster(), -- player source
				self:GetAbility(), -- ability source
				"modifier_nevermore_counter_fear", -- modifier name
				{ duration = self.fear_duration } -- kv
			)
		end

		self:PlayEffectsOnDraw()
		self:GetCaster():StartGesture(ACT_DOTA_RAZE_2)
	end
end

function modifier_nevermore_counter_thinker:PlayEffectsOnDraw()
	EmitSoundOn("Hero_Nevermore.ROS_Flames", self:GetCaster() )

	local particle_cast = "particles/econ/events/ti4/blink_dagger_end_ti4.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetAbsOrigin() )
	
	particle_cast = "particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf"
	effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )	
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetAbsOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 60, Vector(157, 0, 243) )
	ParticleManager:SetParticleControl( effect_cast, 61, Vector(1, 0, 0) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	particle_cast = "particles/econ/items/outworld_devourer/od_ti8/od_ti8_santies_eclipse_area_shockwave.vpcf"
	effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )	
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetAbsOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	
	ScreenShake(self:GetCaster():GetAbsOrigin(), 100, 300, 0.45, 1000, 0, true)
end

function modifier_nevermore_counter_thinker:PlayEffects()
    local particle_cast = "particles/units/heroes/hero_shadow_demon/shadow_demon_soul_catcher_v2_ground01.vpcf"
    self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( self.effect_cast, 0, self:GetParent():GetAbsOrigin() )
    ParticleManager:SetParticleControl( self.effect_cast, 1, self:GetParent():GetAbsOrigin() )
    ParticleManager:SetParticleControl( self.effect_cast, 2, self:GetParent():GetAbsOrigin() )
    ParticleManager:SetParticleControl( self.effect_cast, 3, Vector(self.radius, 0, 0) )
end

function modifier_nevermore_counter_thinker:StopEffects()
	ParticleManager:DestroyParticle(self.effect_cast, false)
	ParticleManager:ReleaseParticleIndex(self.effect_cast)    
end

function modifier_nevermore_counter_thinker:GetDelayTime()
    return self:GetAbility():GetSpecialValueFor("delay_time")
end

function modifier_nevermore_counter_thinker:GetAOERadius()
    return self:GetAbility():GetSpecialValueFor("radius")
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Thinker(modifier_nevermore_counter_thinker)