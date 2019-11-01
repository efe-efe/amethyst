wall_base = class({})

--------------------------------------------------------------------------------
-- Modifier Effects
function wall_base:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH,
	}
	return funcs
end

function wall_base:OnDeath( params )
	if IsServer() then 		
		if params.unit ~= self:GetParent() then return end
        self:PlayEffectsOnDeath()
        self:GetParent():AddNoDraw()
    end
end

function wall_base:PlayEffectsOnDeath()
    local parent = self:GetParent()
	local origin = parent:GetOrigin()
	
	EmitSoundOnLocationWithCaster(origin, "Hero_Furion.ForceOfNature", parent)
    
	local particle_cast_a = "particles/box_destroy.vpcf"
	local particle_cast_b = "particles/world_destruction_fx/tree_destruction_snow_b.vpcf"

	local effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_WORLDORIGIN, parent )
	local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_WORLDORIGIN, parent )
	
	ParticleManager:SetParticleControl( effect_cast_a, 0, origin )
	ParticleManager:SetParticleControl( effect_cast_a, 1, origin )
	ParticleManager:SetParticleControl( effect_cast_a, 2, origin )
	ParticleManager:SetParticleControl( effect_cast_a, 4, origin )
	ParticleManager:SetParticleControl( effect_cast_a, 5, origin )

    ParticleManager:SetParticleControl( effect_cast_b, 0, origin)
    ParticleManager:SetParticleControl( effect_cast_b, 5, origin)

	ParticleManager:ReleaseParticleIndex( effect_cast_a )
	ParticleManager:ReleaseParticleIndex( effect_cast_b )
end