modifier_spectre_ultimate = class({})
LinkLuaModifier( "modifier_spectre_special_attack_debuff", "abilities/heroes/spectre/spectre_special_attack/modifier_spectre_special_attack_debuff", LUA_MODIFIER_MOTION_NONE )

function modifier_spectre_ultimate:IsHidden() return false end
function modifier_spectre_ultimate:IsDebuff() return true end
function modifier_spectre_ultimate:IsPurgable() return true end

function modifier_spectre_ultimate:OnCreated( params )
	if IsServer() then
		self.damage = self:GetAbility():GetSpecialValueFor("ability_damage")
		self.aoe_origin = Vector(params.x, params.y, 0)
		self.radius = params.radius
		self.ability = self:GetCaster():FindAbilityByName("spectre_special_attack")
		self.debuff_duration = 5.0

		self.hit = false
		self:StartIntervalThink(0.1)
	end
end

function modifier_spectre_ultimate:OnIntervalThink()
	if (self.aoe_origin - self:GetParent():GetOrigin()):Length2D() > self.radius then
		if self.hit == false then
			self.hit = true
			
			EmitSoundOn( "Hero_Spectre.DaggerImpact", self:GetParent() )
			local damage = {
				victim = self:GetParent(),
				attacker = self:GetCaster(),
				damage = self.damage,
				damage_type = DAMAGE_TYPE_PURE,
			}
			ApplyDamage( damage )

			self:GetParent():AddNewModifier(self:GetCaster(), self.ability, "modifier_spectre_special_attack_debuff", { 
				duration = self.debuff_duration
			})
			self:GetParent():AddNewModifier(self:GetCaster(), self.ability, "modifier_generic_fading_slow_new", { 
				duration = self.debuff_duration,
				max_slow_pct = 50
			})
		end
	else
		self.hit = false
	end
end

function modifier_spectre_ultimate:GetEffectName()
	return "particles/econ/items/bloodseeker/bloodseeker_ti7/bloodseeker_ti7_overhead_vision_model.vpcf"
end

function modifier_spectre_ultimate:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end




