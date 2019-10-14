modifier_phantom_strike_stack = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_phantom_strike_stack:IsHidden()
	return false
end

function modifier_phantom_strike_stack:IsDebuff()
	return false
end

function modifier_phantom_strike_stack:IsStunDebuff()
	return false
end

function modifier_phantom_strike_stack:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_phantom_strike_stack:OnCreated( kv )
	-- references
	if IsServer() then
		self:SetStackCount(1)
		self:PlayEffects()
	end
end

function modifier_phantom_strike_stack:OnRefresh( kv )
	-- references
	local max_stack = 3--self:GetAbility():GetSpecialValueFor( "stack_limit" )

	if IsServer() then
		if self:GetStackCount()<max_stack then
			self:StopEffects()
			self:IncrementStackCount()
			self:PlayEffects()
		end
	end
end

function modifier_phantom_strike_stack:OnDestroy( kv )
	self:StopEffects()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_phantom_strike_stack:DeclareFunctions()
	local funcs = {
	}

	return funcs
end

--------------------------------------------------------------------------------
--Graphics
function modifier_phantom_strike_stack:GetTexture()
	return "phantom_basic_attack"
end

-- Graphics & Animations
function modifier_phantom_strike_stack:PlayEffects( second )
    local particle_cast = "particles/units/heroes/hero_abaddon/abaddon_curse_counter_stack.vpcf"

	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
    ParticleManager:SetParticleControl( self.effect_cast, 1, Vector(0, self:GetStackCount(), 0) )
end

function modifier_phantom_strike_stack:StopEffects()
	if self.effect_cast ~= nil then
		ParticleManager:DestroyParticle( self.effect_cast, false )
		ParticleManager:ReleaseParticleIndex( self.effect_cast )
	end
end


