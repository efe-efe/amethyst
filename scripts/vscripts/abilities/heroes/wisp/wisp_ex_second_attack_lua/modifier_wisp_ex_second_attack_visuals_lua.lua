modifier_wisp_ex_second_attack_visuals_lua = class({})

--------------------------------------------------------------------------------
function modifier_wisp_ex_second_attack_visuals_lua:IsDebuff()
	return true
end

function modifier_wisp_ex_second_attack_visuals_lua:IsHidden()
	return false
end

function modifier_wisp_ex_second_attack_visuals_lua:IsPurgable()
	return true
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_wisp_ex_second_attack_visuals_lua:OnCreated( kv )
	if IsServer() then
		-- logic
		self:PlayEffects( self:GetParent() )
	end
end

function modifier_wisp_ex_second_attack_visuals_lua:OnRefresh( kv )
	
end

function modifier_wisp_ex_second_attack_visuals_lua:OnDestroy( kv )
	if IsServer() then
		self:StopEffects()
	end
end

function modifier_wisp_ex_second_attack_visuals_lua:PlayEffects( hTarget )
	-- Get Resources
	local particle_cast = "particles/mod_units/heroes/hero_wisp/wisp_tether.vpcf"

	self.effect_cast = ParticleManager:CreateParticle( 
		particle_cast,
		PATTACH_CUSTOMORIGIN, 
		nil
	)

	local origin = self:GetCaster():GetOrigin()

	ParticleManager:SetParticleControlEnt( 
		self.effect_cast, 
		0, 
		self:GetCaster(), 
		PATTACH_POINT_FOLLOW, 
		"attach_attack1", 
		self:GetCaster():GetOrigin() + Vector( 0, 0, 96 ), 
		true 
	);
	ParticleManager:SetParticleControlEnt( 
		self.effect_cast, 
		1, 
		hTarget, 
		PATTACH_POINT_FOLLOW, 
		"attach_hitloc", 
		hTarget:GetOrigin(), 
		true 
	);

end

function modifier_wisp_ex_second_attack_visuals_lua:StopEffects()
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )
end
