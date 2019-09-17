modifier_treant_natures_punishment = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_treant_natures_punishment:IsHidden()
	return false
end

function modifier_treant_natures_punishment:IsDebuff()
	return false
end

function modifier_treant_natures_punishment:IsStunDebuff()
	return false
end

function modifier_treant_natures_punishment:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_treant_natures_punishment:OnCreated( kv )
    self.healing_reduction_pct = self:GetAbility():GetSpecialValueFor("healing_reduction_pct")

	-- references
    if IsServer() then
		self:SetStackCount(1)
		self:PlayEffects()
	end
end

function modifier_treant_natures_punishment:OnRefresh( kv )
	-- references
	local max_stack = self:GetAbility():GetSpecialValueFor( "stack_limit" )

	if IsServer() then
		if self:GetStackCount()<max_stack then
			self:StopEffects()
			self:IncrementStackCount()
			self:PlayEffects()
		end
	end
end

function modifier_treant_natures_punishment:OnRemoved()
    if IsServer() then
        self:GetParent().healing_reduction_pct = self:GetParent().healing_reduction_pct - self.healing_reduction_pct * self:GetStackCount()
    end
end


function modifier_treant_natures_punishment:OnStackCountChanged( old )
    if IsServer() then
        local new = self:GetStackCount()

		if new < 1 then
			self:Destroy()
        else
            if old < new then 
                self:GetParent().healing_reduction_pct = self:GetParent().healing_reduction_pct + self.healing_reduction_pct
            else 
                self:GetParent().healing_reduction_pct = self:GetParent().healing_reduction_pct - self.healing_reduction_pct
            end
        end
	end
end

function modifier_treant_natures_punishment:OnDestroy( kv )
	self:StopEffects()
end

function modifier_treant_natures_punishment:PlayEffects( second )
    local particle_cast = "particles/units/heroes/hero_abaddon/abaddon_curse_counter_stack.vpcf"

	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
    ParticleManager:SetParticleControl( self.effect_cast, 1, Vector(0, self:GetStackCount(), 0) )
end

function modifier_treant_natures_punishment:StopEffects()
	if self.effect_cast ~= nil then
		ParticleManager:DestroyParticle( self.effect_cast, false )
		ParticleManager:ReleaseParticleIndex( self.effect_cast )
	end
end


