modifier_terrorblade_extra = class({})

function modifier_terrorblade_extra:OnCreated( params )
	if IsServer() then
		self:GetParent():AddNoDraw()

		EmitSoundOn("Hero_Terrorblade.Sunder.Cast", self:GetParent())
		local particle_cast = "particles/econ/events/nexon_hero_compendium_2014/blink_dagger_start_nexon_hero_cp_2014.vpcf"
		local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
		ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
		ParticleManager:ReleaseParticleIndex( effect_cast )

		self.stun_duration = params.stun_duration
		self.radius = params.radius
	end
end

function modifier_terrorblade_extra:OnDestroy()
	if IsServer() then
		EmitSoundOn("Hero_Terrorblade.Sunder.Target", self:GetParent())
		local particle_cast = "particles/units/heroes/hero_void_spirit/void_spirit_prison_end.vpcf"
		local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
		ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
		ParticleManager:ReleaseParticleIndex( effect_cast )

		
		self:GetParent():RemoveNoDraw()
		local enemies = self:GetParent():FindUnitsInRadius(
			self:GetParent():GetOrigin(), 
			self.radius, 
			DOTA_UNIT_TARGET_TEAM_ENEMY, 
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER
		)
		
		for _,enemy in pairs(enemies) do
			enemy:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_generic_stunned", { duration = self.stun_duration })
			local damage = {
				victim = enemy,
				attacker = self:GetParent(),
				damage = self.damage,
				damage_type = DAMAGE_TYPE_PURE,
			}
			ApplyDamage( damage )
		end

		CreateRadiusMarker(self:GetParent(), self:GetParent():GetOrigin(), {
			show_all = 1,
			radius = self.radius
		})

		ScreenShake(self:GetParent():GetOrigin(), 1000, 1000, 0.9, 1000, 0, true)
	end
end


--------------------------------------------------------------------------------
-- Status Effects
function modifier_terrorblade_extra:CheckState()
	local state = {
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}

	return state
end