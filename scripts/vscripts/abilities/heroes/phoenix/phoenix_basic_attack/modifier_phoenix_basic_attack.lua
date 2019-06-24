modifier_phoenix_basic_attack = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_phoenix_basic_attack:IsHidden()
	return false
end

function modifier_phoenix_basic_attack:IsDebuff()
	return true
end

function modifier_phoenix_basic_attack:IsStunDebuff()
	return false
end

function modifier_phoenix_basic_attack:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initialization
function modifier_phoenix_basic_attack:OnCreated()
    self.damage_per_second = 1--self:GetAbility():GetSpecialValueFor( "damage_per_second" )
    self.max_stacks = 3 --self:GetAbility():GetSpecialValueFor( "max_stacks" )

	if IsServer() then
		self:SetStackCount(1)
		self:StartIntervalThink( 1.0 )
		self:PlayEffects(self:GetParent())
	end
end

--------------------------------------------------------------------------------
-- Initialization
function modifier_phoenix_basic_attack:OnRefresh()
    self.damage_per_second = 1--self:GetAbility():GetSpecialValueFor( "damage_per_second" )
    self.max_stacks = 3 --self:GetAbility():GetSpecialValueFor( "max_stacks" )

	if IsServer() then
		self:IncrementStackCount()
		self:StartIntervalThink( 1.0 )
		self:OnIntervalThink()
	end
end

--------------------------------------------------------------------------------
-- Destroyer
function modifier_phoenix_basic_attack:OnDestroy()
	if IsServer() then
		self:StopEffects()
	end
end

function modifier_phoenix_basic_attack:OnStackCountChanged( old )
	if IsServer() then
		if self:GetStackCount()<1 then
			self:Destroy()
        end
		if self:GetStackCount()>self.max_stacks then
			self:SetStackCount(self.max_stacks)
		end
	end
end

-- On Think
--------------------------------------------------------------------------------
function modifier_phoenix_basic_attack:OnIntervalThink()
	if IsServer() then
		local damage = {
			victim = self:GetParent(),
			attacker = self:GetCaster(),
			damage = self.damage_per_second * self:GetStackCount(),
			damage_type = DAMAGE_TYPE_PURE,
		}

		ApplyDamage( damage )
	end
end

function modifier_phoenix_basic_attack:PlayEffects( hTarget )
	-- get resources
	local particle_cast = "particles/mod_units/heroes/hero_phoenix/phoenix_fire_spirit_burn.vpcf"

	-- create particle
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget )
	ParticleManager:SetParticleControl( self.effect_cast, 0, hTarget:GetOrigin() )
end


function modifier_phoenix_basic_attack:StopEffects( )
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )
end

