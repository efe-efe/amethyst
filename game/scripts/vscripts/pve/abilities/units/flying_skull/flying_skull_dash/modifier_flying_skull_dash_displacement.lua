modifier_flying_skull_dash_displacement = class({})

function modifier_flying_skull_dash_displacement:OnCreated(params)
	if IsServer() then
		self.damage_table = {
			attacker = self:GetParent(),
			damage = 4,
			damage_type = DAMAGE_TYPE_PURE,
		}
		self.original_scale = self:GetParent():GetModelScale()
		self:GetParent():SetModelScale(self.original_scale/2)
	end
end

function modifier_flying_skull_dash_displacement:OnDestroy()
	if IsServer() then
		self:GetParent():SetModelScale(self.original_scale)
	end
end

function modifier_flying_skull_dash_displacement:OnCollide(params)
	if IsServer() then
		if params.type == UNIT_COLLISION then
			for _,unit in pairs(params.units) do
				if not unit:HasModifier("modifier_flying_skull_dash") then
					unit:AddNewModifier(self:GetCaster(), self:GetAbility(), 'modifier_flying_skull_dash', { duration = 1.0 })
					self.damage_table.victim = unit
					ApplyDamage(self.damage_table)
				end
			end
		end
	end
end

function modifier_flying_skull_dash_displacement:GetCollisionTeamFilter()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_flying_skull_dash_displacement:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end

function modifier_flying_skull_dash_displacement:GetOverrideAnimation() 		return ACT_DOTA_RUN end
function modifier_flying_skull_dash_displacement:GetOverrideAnimationRate() 	return 1.5 end
function modifier_flying_skull_dash_displacement:GetCollisionRadius() 			return 100 end


if IsClient() then require("wrappers/modifiers") end
Modifiers.Displacement(modifier_flying_skull_dash_displacement)
Modifiers.Animation(modifier_flying_skull_dash_displacement)