modifier_axe_second_attack_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_axe_second_attack_debuff:IsHidden()
	return false
end

function modifier_axe_second_attack_debuff:IsDebuff()
	return true
end

function modifier_axe_second_attack_debuff:IsStunDebuff()
	return false
end

function modifier_axe_second_attack_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_axe_second_attack_debuff:OnCreated( kv )
	-- references
	local damage = self:GetAbility():GetSpecialValueFor( "damage_per_second" )
	local interval = 1

	if IsServer() then
		-- precache damage
		self.damageTable = {
			victim = self:GetParent(),
			attacker = self:GetCaster(),
			damage = damage,
			damage_type = DAMAGE_TYPE_PURE,
			ability = self:GetAbility(), --Optional.
			damage_flags = DOTA_DAMAGE_FLAG_NONE, --Optional.
		}

		-- Start interval
		self:StartIntervalThink( interval )
		self:OnIntervalThink()
	end
end

function modifier_axe_second_attack_debuff:OnRefresh( kv )
	-- update value
	local damage = self:GetAbility():GetSpecialValueFor( "damage_per_second" )
	
	if IsServer() then
		self.damageTable.damage = damage
	end
end

function modifier_axe_second_attack_debuff:OnDestroy( kv )
	if IsServer() then
		-- decrement buff stack
		local modifier = self:GetCaster():FindModifierByName( "modifier_axe_second_attack_buff" )
		if modifier then
			modifier:DecrementStackCount()
		end
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_axe_second_attack_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH,
	}

	return funcs
end

function modifier_axe_second_attack_debuff:OnDeath( params )
	if IsServer() then
		if params.attacker~=self:GetParent() then return end
		self:Destroy()
	end
end


--------------------------------------------------------------------------------
-- Interval Effects
function modifier_axe_second_attack_debuff:OnIntervalThink()
	-- apply damage
	ApplyDamage( self.damageTable )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_axe_second_attack_debuff:GetEffectName()
	return "particles/units/heroes/hero_axe/axe_battle_hunger.vpcf"
end

function modifier_axe_second_attack_debuff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
