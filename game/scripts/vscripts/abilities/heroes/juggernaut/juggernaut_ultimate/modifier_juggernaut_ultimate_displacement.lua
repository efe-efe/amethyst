modifier_juggernaut_ultimate_displacement = class({})

function modifier_juggernaut_ultimate_displacement:OnCreated(params)
	self.slashing_duration = self:GetAbility():GetSpecialValueFor("duration")
	self.aspd_per_stack =  self:GetAbility():GetSpecialValueFor("aspd_per_stack")
	if IsServer() then
		self.stacks = 0
		if self:GetParent():HasModifier("modifier_juggernaut_basic_attack_stacks") then
			self.stacks = self:GetParent():FindModifierByName("modifier_juggernaut_basic_attack_stacks"):GetStackCount()
			self:GetParent():FindModifierByName("modifier_juggernaut_basic_attack_stacks"):Destroy()
		end
	end
end

function modifier_juggernaut_ultimate_displacement:OnCollide(params)
	if IsServer() then
		if params.type == UNIT_COLLISION then
			local target = nil

			for _,unit in pairs(params.units) do
				if not self:GetParent():IsAlly(unit) and not unit:IsObstacle() then
					target = unit
					break
				end
			end

			if target then
				self:PlayEffectsOnImpact(target)

				self:GetParent():AddNewModifier(
					self:GetParent(), -- player source
					self:GetAbility(), -- ability source
					"modifier_juggernaut_ultimate_slashing", -- modifier name
					{
						duration = self.slashing_duration,
						aspd_buff =  self.aspd_per_stack * self.stacks
					}
				)
				self:Destroy()
			end
		end
	end
end

function modifier_juggernaut_ultimate_displacement:PlayEffectsOnImpact(hTarget)
    EmitSoundOn("Hero_PhantomAssassin.Attack", hTarget)
end

function modifier_juggernaut_ultimate_displacement:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end

function modifier_juggernaut_ultimate_displacement:GetOverrideAnimation() 		return ACT_DOTA_ATTACK_EVENT end
function modifier_juggernaut_ultimate_displacement:GetOverrideAnimationRate() 	return 1.0 end

function modifier_juggernaut_ultimate_displacement:CheckState()
	return {
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_juggernaut_ultimate_displacement:GetEffectName() 
	return "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_trigger.vpcf"
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Displacement(modifier_juggernaut_ultimate_displacement)
Modifiers.Animation(modifier_juggernaut_ultimate_displacement)