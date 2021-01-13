modifier_item_meteor_custom_thinker = class({})

function modifier_item_meteor_custom_thinker:OnDelayEnds()
    if IsServer() then
        self.origin = self:GetParent():GetOrigin()
        self.radius = self:GetAbility():GetSpecialValueFor("radius")
        self.ability_damage = self:GetAbility():GetSpecialValueFor("ability_damage")
        self.duration = self:GetAbility():GetSpecialValueFor("duration")
        self.stun_duration = self:GetAbility():GetSpecialValueFor("stun_duration")

		local enemies = CustomEntities:FindUnitsInRadius(
			self:GetCaster(),
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
			ApplyDamage(damage_table)
			
			enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_item_meteor_custom", { duration = self.duration })
			enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_generic_stunned", { duration = self.stun_duration})
		end
    end
end

function modifier_item_meteor_custom_thinker:OnDestroy()
	if IsServer() then
		self:StopEffects()
		UTIL_Remove(self:GetParent())
	end
end

function modifier_item_meteor_custom_thinker:PlayEffects()
	EmitSoundOn("DOTA_Item.MeteorHammer.Impact", self:GetCaster())

    local particle_cast = "particles/items4_fx/meteor_hammer_spell.vpcf"
    self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(self.effect_cast, 0, self:GetParent():GetAbsOrigin() + Vector(500, 500, 1000))
    ParticleManager:SetParticleControl(self.effect_cast, 1, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(self.effect_cast, 2, Vector(0.5,0,0))
	ParticleManager:ReleaseParticleIndex(self.effect_cast)    
end

function modifier_item_meteor_custom_thinker:StopEffects()
	ParticleManager:DestroyParticle(self.effect_cast, false)
end

function modifier_item_meteor_custom_thinker:GetDelayTime()
    return self:GetAbility():GetSpecialValueFor("delay_time")
end

function modifier_item_meteor_custom_thinker:GetAOERadius()
    return self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_item_meteor_custom_thinker:GetTimedActions()
	local timed_actions = {}
	timed_actions[0.3] = self.PlayEffects

	return timed_actions
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Thinker(modifier_item_meteor_custom_thinker)