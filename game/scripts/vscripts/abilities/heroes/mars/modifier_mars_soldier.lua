modifier_mars_soldier = class({})

function modifier_mars_soldier:IsHidden() return true end
function modifier_mars_soldier:IsPurgable() return false end

function modifier_mars_soldier:OnCreated(params)
	if IsServer() then
		self.radius = params.radius
		self.parent = self:GetParent()
		self.caster = self:GetCaster()
		self.origin = self.parent:GetOrigin()

		self.searchOrigin = self.origin + Vector(params.x, params.y, 0) * self.radius
		self.damage = self:GetAbility():GetSpecialValueFor("ability_damage")
		self.knockback_distance = self:GetAbility():GetSpecialValueFor("knockback_distance")
		
		self.counter = 0
		self.rate = 1.0
		self.model = params.model
		self.fade = params.fade
		self.marker = params.marker

		self.parent:SetHullRadius(60)
        self:StartIntervalThink(0.03)
		
		if self.marker == 1 then
			CreateRadiusMarker(self.caster, self.searchOrigin, self.radius, RADIUS_SCOPE_PUBLIC, 0.1)
			CreateTimedRadiusMarker(self.caster, self.searchOrigin, self.radius, self:GetDuration(), 0.2, RADIUS_SCOPE_PUBLIC)
		end

		if self.model == 1 then
            self.parent:SetOriginalModel("models/heroes/mars/mars_soldier.vmdl")
            
            if self.fade == 1 then
                self.fade_min = 350.0
                self.fade_max = 450.0
                self.fade_range = self.fade_max - self.fade_min
                self.parent:SetRenderAlpha(0)
            end
		end
	end
end

function modifier_mars_soldier:OnDestroy()
	if IsServer() then
		self.parent:ForceKill(false)
		-- UTIL_Remove(self:GetParent())
	end
end

function modifier_mars_soldier:OnIntervalThink()
    if self.model == 1 then
        if self.fade == 1 then
            self.parent:SetRenderAlpha(self:GetAlphaValue())
        end
	end

	local enemies = CustomEntities:FindUnitsInRadius(
		self.caster,
		self.searchOrigin, 
		self.radius, 
		DOTA_UNIT_TARGET_TEAM_ENEMY, 
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER
	)
	
	local shouldAnimate = false

	for _,enemy in pairs(enemies) do
		if not enemy:HasModifier("modifier_mars_soldier_debuff") then
			local damage_table = {
				victim = enemy,
				attacker = self.caster,
				damage = self.damage,
				damage_type = DAMAGE_TYPE_PURE,
			}
			ApplyDamage(damage_table)
			local direction = (enemy:GetAbsOrigin() - self.origin):Normalized()
			
			if not enemy:HasModifier("modifier_generic_stunned") and not enemy:HasModifier("modifier_generic_root") and not enemy:HasModifier("modifier_mars_special_attack_displacement") then
				enemy:AddNewModifier(
					self.caster, -- player source
					self:GetAbility(), -- ability source
					"modifier_mars_soldier_displacement", -- modifier name
					{
						x = direction.x,
						y = direction.y,
						r = self.knockback_distance,
						speed = self.knockback_distance/0.3,
						peak = 50,
					} -- kv
				)
			end

			enemy:AddNewModifier(self.caster, self:GetAbility(), "modifier_mars_soldier_debuff", { duration = self.rate })
			self:PlayEffects(direction, enemy)

			shouldAnimate = true
		end
	end

	if shouldAnimate then
		self.parent:FadeGesture(ACT_DOTA_ATTACK)
		self.parent:StartGesture(ACT_DOTA_ATTACK)
	end
end

function modifier_mars_soldier:GetAlphaValue()
    local alpha = 0
    local enemies = CustomEntities:FindUnitsInRadius(
        self.parent,
        self.origin, 
        self.fade_max, 
        DOTA_UNIT_TARGET_TEAM_ENEMY, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
        FIND_CLOSEST
	)

    -- Find out distance between closest enemy
    if #enemies > 0 then
        local enemy = enemies[1]
        local range = math.max(self.parent:GetRangeToUnit(enemy), self.fade_min)
        range = math.min(range, self.fade_max)-self.fade_min
        alpha = Interpolate(range/self.fade_range, 255, 0)
    end
    return alpha
end

function modifier_mars_soldier:CheckState()
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

function modifier_mars_soldier:PlayEffects(direction, hTarget)
	local particle_cast = "particles/units/heroes/hero_mars/mars_arena_of_blood_spear.vpcf"

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, hTarget)
	ParticleManager:SetParticleControl(effect_cast, 0, hTarget:GetOrigin())
	ParticleManager:SetParticleControlForward(effect_cast, 0, direction)
	ParticleManager:ReleaseParticleIndex(effect_cast)

	EmitSoundOnLocationWithCaster(hTarget:GetOrigin(), "Hero_Mars.Phalanx.Attack", self:GetCaster())
	EmitSoundOn("Hero_Mars.Phalanx.Target", hTarget)
end

function modifier_mars_soldier:OnProjectileHitCustom(params)
	if IsServer() then
		params.hProjectile:Destroy(false)
	end
end

Modifiers.OnProjectileHit(modifier_mars_soldier)