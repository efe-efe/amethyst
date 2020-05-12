modifier_vengeful_basic_attack_stack = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_vengeful_basic_attack_stack:IsHidden() return false
end

function modifier_vengeful_basic_attack_stack:IsDebuff() return false
end

function modifier_vengeful_basic_attack_stack:IsStunDebuff()
	return false
end

function modifier_vengeful_basic_attack_stack:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_vengeful_basic_attack_stack:OnCreated( kv )
	-- references
	if IsServer() then
		self.attack_speed_bonus = 0.2 + self:GetParent():GetAttackAnimationPoint()--self:GetAbility():GetSpecialValueFor("attack_speed_bonus")
		self.effects_cast_weapon = {}
		self:SetStackCount(1)
		self:GetParent():AddStacksVisual({ modifier = self })
	end
end

function modifier_vengeful_basic_attack_stack:OnRefresh( kv )
	-- references
	local max_stack = self:GetAbility():GetSpecialValueFor( "max_stacks" )

	if IsServer() then
		if self:GetStackCount() < max_stack then
			self:StopEffects()
			self.effects_cast_weapon = {}
			self:IncrementStackCount()

			

			if self:GetStackCount() == max_stack then
				self:PlayEffectsCharged()
				self:PlayEffects()
			end
		end
	end
end

function modifier_vengeful_basic_attack_stack:OnDestroy( kv )
	if IsServer() then
		self:StopEffects()
		
	end
end


--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_vengeful_basic_attack_stack:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACK_POINT_CONSTANT,
	}

	return funcs
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_vengeful_basic_attack_stack:GetModifierAttackPointConstant()
    if self:GetStackCount() ~= 3 then return 0 end
    if IsServer() then     
        return self.attack_speed_bonus
    end
end


--------------------------------------------------------------------------------
-- Graphics & Animations

function modifier_vengeful_basic_attack_stack:PlayEffectsCharged()
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

function modifier_vengeful_basic_attack_stack:PlayEffects()
	self:CreateGlow(0)
	self:CreateGlow(1)
	self:CreateGlow(2)
end

function modifier_vengeful_basic_attack_stack:CreateGlow(index)
	local particle_cast = "particles/econ/items/vengeful/vengeful_echoes_eyrie/vengeful_ambient_head_flames_motenai.vpcf"
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

function modifier_vengeful_basic_attack_stack:StopEffects()
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


