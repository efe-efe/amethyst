modifier_spectre_ultimate = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_spectre_ultimate:IsHidden()
	return false
end

function modifier_spectre_ultimate:IsDebuff()
	return true
end

function modifier_spectre_ultimate:IsPurgable()
	return true
end

function modifier_spectre_ultimate:OnCreated( params )
	if IsServer() then
		self.damage = self:GetAbility():GetSpecialValueFor("ability_damage")
		self.aoe_origin = Vector(params.x, params.y, 0)
		self.radius = params.radius
		
		self.hit = false
		self:StartIntervalThink(0.1)
	end
end

function modifier_spectre_ultimate:OnIntervalThink()
	if (self.aoe_origin - self:GetParent():GetOrigin()):Length2D() > self.radius then
		if self.hit == false then
			self.hit = true
			
			local damage = {
				victim = self:GetParent(),
				attacker = self:GetCaster(),
				damage = self.damage,
				damage_type = DAMAGE_TYPE_PURE,
			}
			ApplyDamage( damage )
			
		end
	else
		self.hit = false
	end
end

--------------------------------------------------------------------------------
-- Graphics and animations
function modifier_spectre_ultimate:GetEffectName()
	return "particles/econ/items/bloodseeker/bloodseeker_ti7/bloodseeker_ti7_overhead_vision_model.vpcf"
end

function modifier_spectre_ultimate:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end




