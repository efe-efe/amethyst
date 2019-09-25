modifier_nevermore_second_attack = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_nevermore_second_attack:IsHidden()
	return false
end

function modifier_nevermore_second_attack:IsDebuff()
	return true
end

function modifier_nevermore_second_attack:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializer
function modifier_nevermore_second_attack:OnCreated()
    if IsServer() then
	    self:SetStackCount(1)
        -- Start Interval
    end
end

--------------------------------------------------------------------------------
-- Initializer
function modifier_nevermore_second_attack:OnRefresh()
    if IsServer() then
	    self:IncrementStackCount()
		-- Start Interval
		self:PlayEffects(self:GetStackCount())
    end
end

function modifier_nevermore_second_attack:OnStackCountChanged( old )
	if IsServer() then
		if self:GetStackCount() < 1 then
			self:Destroy()
		end
	end
end

function modifier_nevermore_second_attack:PlayEffects(number)
	local particle_cast = "particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze_double.vpcf"
	if number == 3 then
		particle_cast = "particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze_triple.vpcf"
	end

	-- create particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end
