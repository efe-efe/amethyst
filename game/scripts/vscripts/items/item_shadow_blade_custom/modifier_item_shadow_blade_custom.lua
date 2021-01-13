modifier_item_shadow_blade_custom = class({})

function modifier_item_shadow_blade_custom:IsHidden() return false end
function modifier_item_shadow_blade_custom:IsDebuff() return false end
function modifier_item_shadow_blade_custom:IsPurgable() return true end

function modifier_item_shadow_blade_custom:OnCreated(kv)
    self.ms_pct = self:GetAbility():GetSpecialValueFor("ms_pct")
	
    if IsServer() then 
        self:GetParent().on_basic_attack_impact["modifier_item_shadow_blade_custom"] = {
            context = self,
            method = self.OnBasicAttackImpact
        }
	end
end

function modifier_item_shadow_blade_custom:OnBasicAttackImpact(hTarget)
    if IsServer() then
        local ability_damage = self:GetAbility():GetSpecialValueFor("ability_damage")
        local damage_table = {
            victim = hTarget,
            attacker = self:GetParent(),
            damage = ability_damage,
            damage_type = DAMAGE_TYPE_PHYSICAL,
        }
        ApplyDamage(damage_table)

        self:Destroy()
    end
end

function modifier_item_shadow_blade_custom:OnDestroy(kv)
	if IsServer() then 
        self:GetAbility():StartCooldown(self:GetAbility():GetCooldown(0))
        self:GetParent().on_basic_attack_impact["modifier_item_shadow_blade_custom"] = nil
	end
end

function modifier_item_shadow_blade_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_item_shadow_blade_custom:GetModifierInvisibilityLevel()
	return 2
end

function modifier_item_shadow_blade_custom:GetModifierMoveSpeedBonus_Percentage()
    return self.ms_pct
end

function modifier_item_shadow_blade_custom:CheckState()
	return {
		[MODIFIER_STATE_INVISIBLE] = true,
		[MODIFIER_STATE_TRUESIGHT_IMMUNE] = false,
	}
end

function modifier_item_shadow_blade_custom:GetStatusLabel() return "Invisibile" end
function modifier_item_shadow_blade_custom:GetStatusPriority() return 1 end
function modifier_item_shadow_blade_custom:GetStatusStyle() return "Invisible" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_item_shadow_blade_custom)