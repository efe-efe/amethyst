modifier_vengeful_ex_counter = class({})

--------------------------------------------------------------------------------
function modifier_vengeful_ex_counter:IsDebuff() return false
end

function modifier_vengeful_ex_counter:IsHidden() return false
end

function modifier_vengeful_ex_counter:IsPurgable() return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_vengeful_ex_counter:OnCreated(kv)
	if IsServer() then
		self:PlayEffects()
	end
end

function modifier_vengeful_ex_counter:OnStackCountChanged(old)
	if IsServer() then
		if self:GetStackCount() <= old then
			return
		end
		if self:GetStackCount() <= 0 then
			self:Destroy()
        end
	end
end

function modifier_vengeful_ex_counter:OnDestroy()
	if IsServer() then
		self:StopEffects()
	end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_vengeful_ex_counter:CheckState()
	local state = {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true
	}

	return state
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_vengeful_ex_counter:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_vengeful_ex_counter:GetModifierMoveSpeedBonus_Percentage()
    return self:GetStackCount()
end

function modifier_vengeful_ex_counter:PlayEffects()
	local particle_cast = "particles/econ/items/lifestealer/lifestealer_immortal_backbone/lifestealer_immortal_backbone_rage_swirl.vpcf"
	self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_CUSTOMORIGIN, self:GetParent())
    ParticleManager:SetParticleControlEnt(
        self.effect_cast, 
        2, 
        self:GetParent(), 
        PATTACH_POINT_FOLLOW, 
        "attach_hitloc", 
        self:GetParent():GetOrigin(), 
        true 
   )
end

function modifier_vengeful_ex_counter:StopEffects()
	ParticleManager:DestroyParticle(self.effect_cast, false)
	ParticleManager:ReleaseParticleIndex(self.effect_cast)
end
