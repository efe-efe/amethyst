modifier_axe_second_attack_debuff_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_axe_second_attack_debuff_lua:IsHidden()
	return false
end

function modifier_axe_second_attack_debuff_lua:IsDebuff()
	return true
end

function modifier_axe_second_attack_debuff_lua:IsStunDebuff()
	return false
end

function modifier_axe_second_attack_debuff_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_axe_second_attack_debuff_lua:OnCreated( kv )
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

function modifier_axe_second_attack_debuff_lua:OnRefresh( kv )
	-- update value
	local damage = self:GetAbility():GetSpecialValueFor( "damage_per_second" )
	
	if IsServer() then
		self.damageTable.damage = damage
	end
end

function modifier_axe_second_attack_debuff_lua:OnDestroy( kv )
	if IsServer() then
		-- decrement buff stack
		local modifier = self:GetCaster():FindModifierByName( "modifier_axe_second_attack_buff_lua" )
		if modifier then
			modifier:DecrementStackCount()
		end
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_axe_second_attack_debuff_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH,
	}

	return funcs
end

function modifier_axe_second_attack_debuff_lua:OnDeath( params )
	if IsServer() then
		if params.attacker~=self:GetParent() then return end
		self:Destroy()
	end
end


--------------------------------------------------------------------------------
-- Interval Effects
function modifier_axe_second_attack_debuff_lua:OnIntervalThink()
	-- apply damage
	ApplyDamage( self.damageTable )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_axe_second_attack_debuff_lua:GetEffectName()
	return "particles/units/heroes/hero_axe/axe_battle_hunger.vpcf"
end

function modifier_axe_second_attack_debuff_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
