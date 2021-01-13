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
		DEFX(self.effect_cast, false)
		UTIL_Remove(self:GetParent())
	end
end

function modifier_nevermore_counter_thinker:OnDelayEnds()
	if IsServer() then
		FindClearSpaceForUnit(self:GetCaster(), self:GetParent():GetAbsOrigin() , true)

		local enemies = CustomEntities:FindUnitsInRadius(
			self:GetCaster(),
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

		self:GetAbility():PlayEffectsFear()
		self:GetCaster():StartGesture(ACT_DOTA_RAZE_2)
	end
end

function modifier_nevermore_counter_thinker:PlayEffects()
	local origin = self:GetParent():GetAbsOrigin()
	self.effect_cast = EFX('particles/units/heroes/hero_shadow_demon/shadow_demon_soul_catcher_v2_ground01.vpcf', PATTACH_WORLDORIGIN, nil, {
		cp0 = origin,
		cp1 = origin,
		cp2 = origin,
		cp3 = Vector(self.radius, 0, 0),
	})
end

function modifier_nevermore_counter_thinker:GetDelayTime()
    return self:GetAbility():GetSpecialValueFor("delay_time")
end

function modifier_nevermore_counter_thinker:GetAOERadius()
    return self:GetAbility():GetSpecialValueFor("radius")
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Thinker(modifier_nevermore_counter_thinker)