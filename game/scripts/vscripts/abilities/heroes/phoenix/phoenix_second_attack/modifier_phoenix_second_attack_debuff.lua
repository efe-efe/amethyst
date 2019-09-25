modifier_phoenix_second_attack_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_phoenix_second_attack_debuff:IsHidden()
	return false
end

function modifier_phoenix_second_attack_debuff:IsDebuff()
	return true
end

function modifier_phoenix_second_attack_debuff:IsStunDebuff()
	return false
end

function modifier_phoenix_second_attack_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initialization
function modifier_phoenix_second_attack_debuff:OnCreated()
    self.stack_bonus = self:GetAbility():GetSpecialValueFor( "stack_bonus" )
	self.attack_speed_per_stack = -self:GetAbility():GetSpecialValueFor("attack_speed_per_stack")
	self.hp_per_second = self:GetAbility():GetSpecialValueFor( "hp_per_second" )
	
	if IsServer() then
		self:SetStackCount(1)
		self:StartIntervalThink( 1.0 )
		self:OnIntervalThink()
		self:PlayEffects(self:GetParent())
	end
end

--------------------------------------------------------------------------------
-- Initialization
function modifier_phoenix_second_attack_debuff:OnRefresh()

    self.hp_per_second = self:GetAbility():GetSpecialValueFor( "hp_per_second" )
    self.stack_bonus = self:GetAbility():GetSpecialValueFor( "stack_bonus" )
	self.attack_speed_per_stack = -self:GetAbility():GetSpecialValueFor("attack_speed_per_stack")
	
	if IsServer() then
		self:IncrementStackCount()
		self:StartIntervalThink( 1.0 )
		self:OnIntervalThink()
	end
end

--------------------------------------------------------------------------------
-- Destroyer
function modifier_phoenix_second_attack_debuff:OnDestroy()
	if IsServer() then
		self:StopEffects()
	end
end

function modifier_phoenix_second_attack_debuff:OnStackCountChanged( old )
	if IsServer() then
		if self:GetStackCount()<1 then
			self:Destroy()
		end
	end
end

-- On Think
--------------------------------------------------------------------------------
function modifier_phoenix_second_attack_debuff:OnIntervalThink()
	if IsServer() then
		local damage = {
			victim = self:GetParent(),
			attacker = self:GetCaster(),
			damage = self.hp_per_second + self.stack_bonus * self:GetStackCount() - 1,
			damage_type = DAMAGE_TYPE_PURE,
		}

		ApplyDamage( damage )
	end
end

function modifier_phoenix_second_attack_debuff:PlayEffects( hTarget )
	-- get resources
	local particle_cast = "particles/units/heroes/hero_warlock/warlock_shadow_word_debuff.vpcf"

	-- create particle
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget )
	ParticleManager:SetParticleControl( self.effect_cast, 0, hTarget:GetOrigin() )
end


function modifier_phoenix_second_attack_debuff:StopEffects( )
	if self.effect_cast ~= nil then
		ParticleManager:DestroyParticle( self.effect_cast, false )
		ParticleManager:ReleaseParticleIndex( self.effect_cast )
	end
end

--------------------------------------------------------------------------------
function modifier_phoenix_second_attack_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
	return funcs
end

-- Modifier Effects
function modifier_phoenix_second_attack_debuff:GetModifierAttackSpeedBonus_Constant()
	return self.attack_speed_per_stack * self:GetStackCount()
end

--------------------------------------------------------------------------------
--Graphics
function modifier_phoenix_second_attack_debuff:GetTexture()
	return "modifier_phoenix_second_attack"
end

