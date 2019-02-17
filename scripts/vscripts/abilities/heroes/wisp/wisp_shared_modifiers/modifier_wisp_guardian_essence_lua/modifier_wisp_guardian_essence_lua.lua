modifier_wisp_guardian_essence_lua = class({})

--------------------------------------------------------------------------------

function modifier_wisp_guardian_essence_lua:IsDebuff()
	return true
end

function modifier_wisp_guardian_essence_lua:IsHidden()
	return false
end

function modifier_wisp_guardian_essence_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_wisp_guardian_essence_lua:OnCreated( kv )
	if IsServer() then
		self:PlayEffects()
		self:SetDuration( 2.0, true )
	end
end

--------------------------------------------------------------------------------
-- Destroyer
function modifier_wisp_guardian_essence_lua:OnDestroy( kv )
	if IsServer() then
		self:StopEffects()
	end
end

--[[
--------------------------------------------------------------------------------

function modifier_wisp_guardian_essence_lua:GetEffectName()
	return "particles/econ/items/centaur/battle_dress_of_the_proven/centaur_proven_axe_edge_a.vpcf"
end

function modifier_wisp_guardian_essence_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
]]--

--------------------------------------------------------------------------------

function modifier_wisp_guardian_essence_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/generic_gameplay/rune_doubledamage_owner_glow.vpcf"

	-- Create Particles
	self.effect_cast = ParticleManager:CreateParticle( 
		particle_cast, 
		PATTACH_ABSORIGIN_FOLLOW, 
		self:GetParent() 
	)
end


function modifier_wisp_guardian_essence_lua:StopEffects()
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )
end