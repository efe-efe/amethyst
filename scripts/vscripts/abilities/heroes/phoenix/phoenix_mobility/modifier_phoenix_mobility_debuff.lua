modifier_phoenix_mobility_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_phoenix_mobility_debuff:IsHidden()
	return false
end

function modifier_phoenix_mobility_debuff:IsDebuff()
	return true
end

function modifier_phoenix_mobility_debuff:IsStunDebuff()
	return false
end

function modifier_phoenix_mobility_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initialization
function modifier_phoenix_mobility_debuff:OnCreated()
    self.damage_per_second = self:GetAbility():GetSpecialValueFor( "damage_per_second" )

	if IsServer() then
		self:StartIntervalThink( 1.0 )
		self:OnIntervalThink()
		self:PlayEffects(self:GetParent())
	end
end


--------------------------------------------------------------------------------
-- Destroyer
function modifier_phoenix_mobility_debuff:OnDestroy()
	if IsServer() then
		self:StopEffects()
	end
end

-- On Think
--------------------------------------------------------------------------------
function modifier_phoenix_mobility_debuff:OnIntervalThink()
	if IsServer() then
		local damage = {
			victim = self:GetParent(),
			attacker = self:GetCaster(),
			damage = self.damage_per_second,
			damage_type = DAMAGE_TYPE_PURE,
		}

		ApplyDamage( damage )
	end
end

function modifier_phoenix_mobility_debuff:PlayEffects( hTarget )
	-- get resources
	local particle_cast = "particles/mod_units/heroes/hero_phoenix/phoenix_fire_spirit_burn.vpcf"

	-- create particle
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget )
	ParticleManager:SetParticleControl( self.effect_cast, 0, hTarget:GetOrigin() )
end


function modifier_phoenix_mobility_debuff:StopEffects( )
	if self.effect_cast ~= nil then
		ParticleManager:DestroyParticle( self.effect_cast, false )
		ParticleManager:ReleaseParticleIndex( self.effect_cast )
	end
end

