modifier_ancient_ultimate_recast = class({})

function modifier_ancient_ultimate_recast:OnCreated(params)
	if IsServer() then
		local ability = self:GetParent():FindAbilityByName("ancient_ultimate_projectile")
		local radius = ability:GetSpecialValueFor("radius")

		self:GetParent():AddNewModifier(self:GetParent(), ability, "modifier_target_indicator_permanent", {
			radius = radius,
		})

		CustomGameEventManager:Send_ServerToAllClients("change_distance_offset", { offset = 600.0, lerp = 50, playerId = self:GetCaster():GetPlayerID() })
		self:PlayEffects()
	end
end

function modifier_ancient_ultimate_recast:OnDestroy()
	if IsServer() then
		
		self:GetParent():RemoveModifierByName("modifier_target_indicator_permanent")
		CustomGameEventManager:Send_ServerToAllClients("change_distance_offset", { offset = 0.0, lerp = 50, playerId = self:GetCaster():GetPlayerID() })
		self:StopEffects()
	end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_ancient_ultimate_recast:CheckState()
	return { [MODIFIER_STATE_ROOTED] = true }
end

function modifier_ancient_ultimate_recast:PlayEffects()
	local particle_cast = "particles/econ/items/crystal_maiden/crystal_maiden_maiden_of_icewrack/maiden_freezing_field_snow_arcana1.vpcf"
	self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
end


function modifier_ancient_ultimate_recast:StopEffects()
	if self.effect_cast then
		ParticleManager:DestroyParticle(self.effect_cast, false)
		ParticleManager:ReleaseParticleIndex(self.effect_cast)
	end
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Recast(
	modifier_ancient_ultimate_recast,
	{ ability_name = "ancient_ultimate_projectile", key = "F", charges = 4 }
)
