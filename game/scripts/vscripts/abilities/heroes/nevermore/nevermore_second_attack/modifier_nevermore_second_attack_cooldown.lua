modifier_nevermore_second_attack_cooldown = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_nevermore_second_attack_cooldown:IsHidden()
	return false--CAMBIAR
end

function modifier_nevermore_second_attack_cooldown:IsDebuff()
	return false
end

function modifier_nevermore_second_attack_cooldown:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializer
function modifier_nevermore_second_attack_cooldown:OnCreated()
    if IsServer() then
	    self:SetStackCount(1)
    end
end

--------------------------------------------------------------------------------
-- Refresh
function modifier_nevermore_second_attack_cooldown:OnRefresh()
    if IsServer() then
		self:IncrementStackCount()
		if self:GetStackCount() > 1 then
			self:PlayEffects(self:GetStackCount())
		end
    end
end

--------------------------------------------------------------------------------
-- Destroyer
function modifier_nevermore_second_attack_cooldown:OnDestroy()
	if IsServer() then
		local ability = self:GetParent():FindAbilityByName("nevermore_second_attack")
		ability:StartCooldown(ability:GetCooldown(0))
    end
end



function modifier_nevermore_second_attack_cooldown:OnStackCountChanged( old )
	if IsServer() then
		if self:GetStackCount() < 1 then
			self:Destroy()
		end
	end
end


function modifier_nevermore_second_attack_cooldown:PlayEffects(number)
	local particle_cast = "particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze_double.vpcf"
	if number == 3 then
		particle_cast = "particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze_triple.vpcf"
	end

	-- create particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end
