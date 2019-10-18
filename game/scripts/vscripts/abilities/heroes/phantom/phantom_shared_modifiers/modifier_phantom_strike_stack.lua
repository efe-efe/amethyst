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
		self.effects_cast_weapon = {}
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
			self.effects_cast_weapon = {}
			self:IncrementStackCount()
			self:PlayEffects()
		end
	end
end

function modifier_phantom_strike_stack:OnDestroy( kv )
	if IsServer() then
		self:StopEffects()
	end
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
function modifier_phantom_strike_stack:PlayEffects()
	local caster = self:GetParent()

    local particle_cast = "particles/units/heroes/hero_abaddon/abaddon_curse_counter_stack.vpcf"
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_OVERHEAD_FOLLOW, caster )
	ParticleManager:SetParticleControl( self.effect_cast, 1, Vector(0, self:GetStackCount(), 0) )
	
	if self:GetStackCount() == 3 then
		self:CreateGlow(0)
		self:CreateGlow(1)
		self:CreateGlow(2)
		self:CreateGlow(3)
		self:CreateGlow(4)
	end
end

function modifier_phantom_strike_stack:CreateGlow(index)
	local particle_cast = "particles/econ/items/antimage/antimage_weapon_godeater/antimage_godeater_bracer_ambient.vpcf"
	local caster = self:GetParent()
	local origin = caster:GetOrigin()
	self.effects_cast_weapon[index] = ParticleManager:CreateParticle( 
		particle_cast, 
		PATTACH_CUSTOMORIGIN, 
		caster
	)

	ParticleManager:SetParticleControlEnt( 
		self.effects_cast_weapon[index], 
		0, 
		caster, 
		PATTACH_POINT_FOLLOW, 
		"attach_attack1", 
		origin, 
		true 
	)
	ParticleManager:SetParticleControlEnt( 
		self.effects_cast_weapon[index], 
		1, 
		caster, 
		PATTACH_POINT_FOLLOW, 
		"attach_attack1", 
		origin, 
		true 
	)
end

function modifier_phantom_strike_stack:StopEffects()
	if self.effect_cast ~= nil then
		ParticleManager:DestroyParticle( self.effect_cast, false )
		ParticleManager:ReleaseParticleIndex( self.effect_cast )
	end

	for _,efx in pairs(self.effects_cast_weapon) do
		if efx ~= nil then
			ParticleManager:DestroyParticle( efx, false )
			ParticleManager:ReleaseParticleIndex( efx )
		end
	end

end

