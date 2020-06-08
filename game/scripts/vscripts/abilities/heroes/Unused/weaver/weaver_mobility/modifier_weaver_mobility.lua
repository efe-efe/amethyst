modifier_weaver_mobility = class({})
LinkLuaModifier("modifier_weaver_mobility_mark", "abilities/heroes/weaver/weaver_mobility/modifier_weaver_mobility_mark", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------
-- Classifications
function modifier_weaver_mobility:IsHidden() return false
end

function modifier_weaver_mobility:IsDebuff() return false
end

function modifier_weaver_mobility:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_weaver_mobility:OnCreated(kv)
	self.speed_buff_pct = self:GetAbility():GetSpecialValueFor("speed_buff_pct")
	self.damage = self:GetAbility():GetSpecialValueFor("ability_damage")
	self.radius = 150

	if IsServer() then 
		self.ability = self:GetParent():FindAbilityByName("weaver_basic_attack")

		self:StartIntervalThink(0.1)
		self:GetParent():AddStatusBar({
			label = "Invisible", modifier = self, priority = 3, 
		})
	end
end

function modifier_weaver_mobility:OnDestroy(kv)
	if IsServer() then 
		self:GetAbility():StartCooldown(self:GetAbility():GetCooldown(0))
	end
end

function modifier_weaver_mobility:OnIntervalThink()
    local enemies = self:GetParent():FindUnitsInRadius(
        self:GetParent():GetOrigin(), 
        self.radius, 
        DOTA_UNIT_TARGET_TEAM_ENEMY, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER
   )
    
	for _,enemy in pairs(enemies) do
		if not enemy:HasModifier("modifier_weaver_mobility_mark") then
			local damage = {
				victim = enemy,
				attacker = self:GetParent(),
				damage = self.damage,
				damage_type = DAMAGE_TYPE_PURE,
			}
			ApplyDamage(damage)
			enemy:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_weaver_mobility_mark", { duration =  self:GetDuration() })
			self:PlayEffectsDamage(enemy)

			self.ability:AddCharges(2)
		end
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_weaver_mobility:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_weaver_mobility:GetModifierInvisibilityLevel()
	return 2
end

function modifier_weaver_mobility:GetModifierMoveSpeedBonus_Percentage()
    return self.speed_buff_pct
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_weaver_mobility:CheckState()
	local state = {
		[MODIFIER_STATE_INVISIBLE] = true,
		[MODIFIER_STATE_TRUESIGHT_IMMUNE] = false,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}

	return state
end

--------------------------------------------------------------------------------
--Graphics
function modifier_weaver_mobility:GetEffectName()
	return "particles/mod_units/heroes/hero_weaver/weaver_shukuchi.vpcf"
end

function modifier_weaver_mobility:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end


function modifier_weaver_mobility:PlayEffectsDamage(hTarget)
	local particle_cast = "particles/mod_units/heroes/hero_weaver/weaver_shukuchi_damage.vpcf"

    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget)
    --ParticleManager:SetParticleControl(effect_cast, 0, self:GetCaster():GetOrigin())
    ParticleManager:ReleaseParticleIndex(effect_cast)  
end