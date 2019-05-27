modifier_wisp_mobility_lua = class({})


--------------------------------------------------------------------------------
-- Classifications
function modifier_wisp_mobility_lua:IsHidden()
	return false
end

function modifier_wisp_mobility_lua:IsDebuff()
	return false
end

function modifier_wisp_mobility_lua:IsPurgable()
	return false
end

function modifier_wisp_mobility_lua:OnCreated( kv )
	if IsServer() then
		self:StartIntervalThink(1.0)
		self:PlayEffects(self:GetRemainingTime())
	end
end

function modifier_wisp_mobility_lua:OnDestroy( )
	if IsServer() then
		-- Swap abilities back to normality
		self:GetCaster():SwapAbilities( 
			self:GetAbility():GetAbilityName(),
			"wisp_mobility_back_lua",
			true,
			false
		)
		self:StopEffects()
	end
end


--------------------------------------------------------------------------------
-- Interval Effects
function modifier_wisp_mobility_lua:OnIntervalThink()
	self:StopEffects()
	self:PlayEffects(self:GetRemainingTime())
end


-- Graphics & Animations
function modifier_wisp_mobility_lua:PlayEffects( second )
    local particle_cast = "particles/units/heroes/hero_wisp/wisp_relocate_timer.vpcf"

	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
    ParticleManager:SetParticleControl( self.effect_cast, 1, Vector(0, second , 0) )
end

function modifier_wisp_mobility_lua:StopEffects()
    ParticleManager:DestroyParticle( self.effect_cast, false )
    ParticleManager:ReleaseParticleIndex( self.effect_cast )
end
