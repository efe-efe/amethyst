modifier_mars_ultimate_soldier = class({})

function modifier_mars_ultimate_soldier:IsHidden() return true end
function modifier_mars_ultimate_soldier:IsPurgable() return false end

function modifier_mars_ultimate_soldier:OnCreated(params)
	if IsServer() then
		self.radius = 200
		self.parent = self:GetParent()
		self.caster = self:GetCaster()
		self.origin = self.parent:GetOrigin()
		self.thinker_origin = Vector(params.x, params.y, self.origin.z)
		self.damage = 8
		self.knockback_distance = 250
		
		self.counter = 0
		self.rate = 1.0
		self.model = params.model

		self.parent:SetHullRadius(60)
		self:StartIntervalThink(0.03)

		if self.model == 1 then
			self.fade_min = 350.0
			self.fade_max = 450.0
			self.fade_range = self.fade_max - self.fade_min

			-- replace model for even soldiers
			self.parent:SetOriginalModel("models/heroes/mars/mars_soldier.vmdl")
			self.parent:SetRenderAlpha(0)
		end
	end
end

function modifier_mars_ultimate_soldier:OnDestroy()
	if IsServer() then
		self.parent:ForceKill(false)
		-- UTIL_Remove(self:GetParent())
	end
end

function modifier_mars_ultimate_soldier:OnIntervalThink()
	if self.model == 1 then
		local alpha = 0

		local enemies = self.parent:FindUnitsInRadius(
			self.origin, 
			self.fade_max, 
			DOTA_UNIT_TARGET_TEAM_ENEMY, 
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
			DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
			FIND_CLOSEST
		)

		-- find out distance between closest enemy
		if #enemies > 0 then
			local enemy = enemies[1]
			local range = math.max(self.parent:GetRangeToUnit(enemy), self.fade_min)
			range = math.min(range, self.fade_max)-self.fade_min
			alpha = Interpolate(range/self.fade_range, 255, 0)
		end

		self.parent:SetRenderAlpha(alpha)
	end

	local enemies = self.caster:FindUnitsInRadius(
		self.origin, 
		self.radius, 
		DOTA_UNIT_TARGET_TEAM_ENEMY, 
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER
	)

	for _,enemy in pairs(enemies) do
		if enemy:HasModifier("modifier_mars_ultimate_area_check") and not enemy:HasModifier("modifier_mars_ultimate_debuff") then
			local damage_table = {
				victim = enemy,
				attacker = self.caster,
				damage = self.damage,
				damage_type = DAMAGE_TYPE_PURE,
			}
			ApplyDamage(damage_table)
			local direction = (self.thinker_origin - enemy:GetAbsOrigin()):Normalized()
			
			if not enemy:HasModifier("modifier_generic_stunned") and not enemy:HasModifier("modifier_mars_special_attack_displacement") then
				enemy:AddNewModifier(
					self.caster, -- player source
					self:GetAbility(), -- ability source
					"modifier_mars_ultimate_displacement", -- modifier name
					{
						x = direction.x,
						y = direction.y,
						r = self.knockback_distance,
						speed = self.knockback_distance/0.3,
						peak = 50,
					} -- kv
				)
			end

			enemy:AddNewModifier(self.caster, self:GetAbility(), "modifier_mars_ultimate_debuff", { duration = self.rate })
			self:PlayEffects(direction, enemy)
		end
	end
end

function modifier_mars_ultimate_soldier:CheckState()
	return {
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_TEAM_MOVE_TO] = true,
		[MODIFIER_STATE_NO_TEAM_SELECT] = true,
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_UNTARGETABLE] = true,
	}
end

function modifier_mars_ultimate_soldier:PlayEffects(direction, hTarget)
	local particle_cast = "particles/units/heroes/hero_mars/mars_arena_of_blood_spear.vpcf"

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, hTarget)
	ParticleManager:SetParticleControl(effect_cast, 0, hTarget:GetOrigin())
	ParticleManager:SetParticleControlForward(effect_cast, 0, direction)
	ParticleManager:ReleaseParticleIndex(effect_cast)

	EmitSoundOnLocationWithCaster(hTarget:GetOrigin(), "Hero_Mars.Phalanx.Attack", self:GetCaster())
	EmitSoundOn("Hero_Mars.Phalanx.Target", hTarget)
end

function modifier_mars_ultimate_soldier:OnProjectileHitCustom(params)
	if IsServer() then
		params.projectile:Destroy(false)
	end
end

Modifiers.OnProjectileHit(modifier_mars_ultimate_soldier)