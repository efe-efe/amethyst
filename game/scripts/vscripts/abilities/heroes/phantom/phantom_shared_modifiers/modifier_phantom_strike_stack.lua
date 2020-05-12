modifier_phantom_strike_stack = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_phantom_strike_stack:IsHidden() return false
end

function modifier_phantom_strike_stack:IsDebuff() return false
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
		self:GetParent():AddStacksVisual({ modifier = self })
	end
end

function modifier_phantom_strike_stack:OnRefresh( kv )
	-- references
	local max_stack = 3--self:GetAbility():GetSpecialValueFor( "stack_limit" )

	if IsServer() then
		if self:GetStackCount() < max_stack then
			self:StopEffects()
			self.effects_cast_weapon = {}
			self:IncrementStackCount()
			self:PlayEffects()

			

			if self:GetStackCount() == max_stack then
				self:PlayEffectsCharged()
			end
		end
	end
end

function modifier_phantom_strike_stack:OnDestroy( kv )
	if IsServer() then
		self:StopEffects()
		
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_phantom_strike_stack:GetTexture()
	return "phantom_basic_attack"
end

function modifier_phantom_strike_stack:PlayEffectsCharged()
	local particle_cast = "particles/mod_units/heroes/hero_wisp/wisp_death.vpcf"
	local caster = self:GetParent()
    local origin = caster:GetOrigin()

	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_CUSTOMORIGIN, caster )
	ParticleManager:SetParticleControlEnt( 
		effect_cast, 
		0, 
		caster, 
		PATTACH_POINT_FOLLOW, 
		"attach_attack1", 
		origin, 
		true 
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_phantom_strike_stack:PlayEffects()
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
	for _,efx in pairs(self.effects_cast_weapon) do
		if efx ~= nil then
			ParticleManager:DestroyParticle( efx, false )
			ParticleManager:ReleaseParticleIndex( efx )
		end
	end
end


