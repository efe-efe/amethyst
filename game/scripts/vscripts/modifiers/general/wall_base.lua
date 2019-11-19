wall_base = class({})

function wall_base:OnCreated( params )
	if IsServer() then
		self.fow_blocker = EntIndexToHScript(params.fow_blocker) 
		self.prev_origin = self:GetParent():GetOrigin()
		--self:StartIntervalThink(0.1) TODO CHECK THIS; CAN THIS BE OPTIMIZED? CAN THIS BE ACTIVATED AGAIN?
	end
end

function wall_base:OnIntervalThink()
	local new_origin = self:GetParent():GetOrigin()
	if new_origin ~= self.prev_origin  then
		UTIL_Remove(self.fow_blocker)
		--[[self:GetParent():AddNewModifier(self:GetParent(), nil, "wall_phase", {})
		self:GetParent():SetOrigin(Vector(999999,999999,0))

		self.fow_blocker = SpawnEntityFromTableSynchronous("point_simple_obstruction", {origin = new_origin, block_fow = true})
		FindClearSpaceForUnit(self:GetParent(), self.fow_blocker:GetOrigin(), false)
		self:GetParent():RemoveModifierByName("wall_phase")
		self.prev_origin = self:GetParent():GetOrigin()
		]]--
	end
end


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
		UTIL_Remove(self.fow_blocker)	
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