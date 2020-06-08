modifier_nevermore_ex_special_attack = class({})
LinkLuaModifier("modifier_nevermore_ex_special_attack_debuff", "abilities/heroes/nevermore/nevermore_ex_special_attack/modifier_nevermore_ex_special_attack_debuff", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------
-- Classifications
function modifier_nevermore_ex_special_attack:IsHidden() return false
end

function modifier_nevermore_ex_special_attack:IsDebuff() return false
end

function modifier_nevermore_ex_special_attack:IsStunDebuff()
	return false
end

function modifier_nevermore_ex_special_attack:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_nevermore_ex_special_attack:OnCreated(kv)
    self.armor_duration = self:GetAbility():GetSpecialValueFor("armor_duration")
	-- references
    if IsServer() then
        local charges = self:GetAbility():GetSpecialValueFor("charges")

		self:SetStackCount(charges)
	end
end

function modifier_nevermore_ex_special_attack:OnRefresh(kv)
	-- references
	if IsServer() then
        local charges = self:GetAbility():GetSpecialValueFor("charges")
		self:SetStackCount(charges)
	end
end

function modifier_nevermore_ex_special_attack:OnDestroy(kv)
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_nevermore_ex_special_attack:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
        MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
	}

	return funcs
end

function modifier_nevermore_ex_special_attack:OnAbilityFullyCast(params)
    if params.ability==self:GetParent():FindAbilityByName("nevermore_basic_attack") then
        self:DecrementStackCount()

        if self:GetStackCount() <= 0 then
            self:Destroy()
        end
    end
end


function modifier_nevermore_ex_special_attack:GetModifierProcAttack_BonusDamage_Physical(params)
	if IsServer() then
        if self:GetParent():PassivesDisabled() then return end
            params.target:AddNewModifier(
                self:GetParent(),
                self:GetAbility(),
                "modifier_nevermore_ex_special_attack_debuff",
                { duration = self.armor_duration }
           ) 
        return 0
	end
end

-- Graphics & Animations
function modifier_nevermore_ex_special_attack:GetStatusEffectName()
	return "particles/status_fx/status_effect_avatar.vpcf"
end