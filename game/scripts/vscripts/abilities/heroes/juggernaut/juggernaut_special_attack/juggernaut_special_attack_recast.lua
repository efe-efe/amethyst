juggernaut_special_attack_recast = class({})

function juggernaut_special_attack_recast:OnSpellStart()
    local caster = self:GetCaster()
    local origin = caster:GetAbsOrigin()
    local target_entity = EntIndexToHScript(self.target_index)
 
	local random_number = RandomInt(1, 9)
	if random_number > 1 then
		EmitSoundOn("juggernaut_jug_ability_bladefury_0" .. random_number, caster)
	end

    FindClearSpaceForUnit(caster, target_entity:GetAbsOrigin() + target_entity:GetForwardVector() * - 80, true)
    
	local particle_cast = "particles/juggernaut/special_attack_recast.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect_cast, 0, origin)
    ParticleManager:SetParticleControl(effect_cast, 1, self:GetCaster():GetOrigin())
    ParticleManager:SetParticleControl(effect_cast, 3, self:GetCaster():GetOrigin())
    ParticleManager:ReleaseParticleIndex(effect_cast)

    caster:StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 2.0)

end

function juggernaut_special_attack_recast:SetTargetIndex(target_index)
    self.target_index = target_index
end