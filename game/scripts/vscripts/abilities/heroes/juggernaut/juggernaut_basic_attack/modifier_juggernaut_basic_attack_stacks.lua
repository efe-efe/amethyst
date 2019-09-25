modifier_juggernaut_basic_attack_stacks = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_juggernaut_basic_attack_stacks:IsHidden()
	return false
end

function modifier_juggernaut_basic_attack_stacks:IsDebuff()
	return false
end

function modifier_juggernaut_basic_attack_stacks:IsStunDebuff()
	return false
end

function modifier_juggernaut_basic_attack_stacks:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_juggernaut_basic_attack_stacks:OnCreated( kv )
	-- references
	if IsServer() then
		self:SetStackCount(1)
		self:PlayEffects()
	end
end

function modifier_juggernaut_basic_attack_stacks:OnRefresh( kv )
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

function modifier_juggernaut_basic_attack_stacks:OnDestroy( kv )
	self:StopEffects()
end

--------------------------------------------------------------------------------
--Graphics
function modifier_juggernaut_basic_attack_stacks:GetTexture()
	return "juggernaut_blade_dance"
end

-- Graphics & Animations
function modifier_juggernaut_basic_attack_stacks:PlayEffects( second )
    local particle_cast = "particles/units/heroes/hero_abaddon/abaddon_curse_counter_stack.vpcf"

	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
    ParticleManager:SetParticleControl( self.effect_cast, 1, Vector(0, self:GetStackCount(), 0) )
end

function modifier_juggernaut_basic_attack_stacks:StopEffects()
	if self.effect_cast ~= nil then
		ParticleManager:DestroyParticle( self.effect_cast, false )
		ParticleManager:ReleaseParticleIndex( self.effect_cast )
	end
end


