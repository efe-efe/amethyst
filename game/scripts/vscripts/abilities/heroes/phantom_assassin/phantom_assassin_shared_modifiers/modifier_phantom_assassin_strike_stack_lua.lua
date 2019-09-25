modifier_phantom_assassin_strike_stack_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_phantom_assassin_strike_stack_lua:IsHidden()
	return false
end

function modifier_phantom_assassin_strike_stack_lua:IsDebuff()
	return false
end

function modifier_phantom_assassin_strike_stack_lua:IsStunDebuff()
	return false
end

function modifier_phantom_assassin_strike_stack_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_phantom_assassin_strike_stack_lua:OnCreated( kv )
	-- references
	if IsServer() then
		self:SetStackCount(1)
		self:PlayEffects()
	end
end

function modifier_phantom_assassin_strike_stack_lua:OnRefresh( kv )
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

function modifier_phantom_assassin_strike_stack_lua:OnDestroy( kv )
	self:StopEffects()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_phantom_assassin_strike_stack_lua:DeclareFunctions()
	local funcs = {
	}

	return funcs
end

--------------------------------------------------------------------------------
--Graphics
function modifier_phantom_assassin_strike_stack_lua:GetTexture()
	return "phantom_basic_attack"
end

-- Graphics & Animations
function modifier_phantom_assassin_strike_stack_lua:PlayEffects( second )
    local particle_cast = "particles/units/heroes/hero_abaddon/abaddon_curse_counter_stack.vpcf"

	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
    ParticleManager:SetParticleControl( self.effect_cast, 1, Vector(0, self:GetStackCount(), 0) )
end

function modifier_phantom_assassin_strike_stack_lua:StopEffects()
	if self.effect_cast ~= nil then
		ParticleManager:DestroyParticle( self.effect_cast, false )
		ParticleManager:ReleaseParticleIndex( self.effect_cast )
	end
end


