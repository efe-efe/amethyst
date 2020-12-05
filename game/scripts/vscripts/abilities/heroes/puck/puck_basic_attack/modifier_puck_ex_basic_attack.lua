modifier_puck_ex_basic_attack = class({})

function modifier_puck_ex_basic_attack:OnCreated(params)
	if IsServer() then
        self:GetParent():SwapAbilities(
            "puck_basic_attack", 
            "puck_basic_attack_related", 
            false, 
            true
	   	)
	   
		local particle_cast = "particles/econ/items/mirana/mirana_ti8_immortal_mount/mirana_ti8_immortal_leap_trail_embers.vpcf"
		self.efx_trail = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())

		local particle_cast = "particles/puck/puck_mobility_trail.vpcf"
		self.efx_dust = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	end
end

function modifier_puck_ex_basic_attack:OnDestroy()
	StopSoundOn("Hero_Puck.Phase_Shift", self:GetParent())
	if IsServer() then
        self:GetParent():SwapAbilities(
            "puck_basic_attack", 
            "puck_basic_attack_related", 
            true,
            false
         )
		ParticleManager:DestroyParticle(self.efx_trail, false)
		ParticleManager:ReleaseParticleIndex(self.efx_trail)

		ParticleManager:DestroyParticle(self.efx_dust, false)
		ParticleManager:ReleaseParticleIndex(self.efx_dust)

		local particle_cast = "particles/econ/items/mirana/mirana_ti8_immortal_mount/mirana_ti8_immortal_leap_start_embers.vpcf"
		local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		ParticleManager:ReleaseParticleIndex(effect_cast)

        self:GetAbility():StartCooldown(self:GetAbility():GetCooldown(0))
	end
end

function modifier_puck_ex_basic_attack:GetStatusEffectName()
	return "particles/status_fx/status_effect_ghost.vpcf"
end

function modifier_puck_ex_basic_attack:GetStatusLabel() return "Fairy Form" end
function modifier_puck_ex_basic_attack:GetStatusPriority() return 4 end
function modifier_puck_ex_basic_attack:GetStatusStyle() return "FairyDust" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_puck_ex_basic_attack)