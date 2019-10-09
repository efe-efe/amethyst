modifier_spectre_ex_second_attack = class({})

--------------------------------------------------------------------------------
-- Initializations
function modifier_spectre_ex_second_attack:OnCreated( kv )
	self.movement_speed  = 80

	if IsServer() then
		self.counter = 0
		self.projectile_spell = self:GetParent():FindAbilityByName("spectre_ex_second_attack_projectile")
		self.projectiles_count =  self:GetAbility():GetSpecialValueFor("projectiles_count")
		self.delay_time = self.projectile_spell:GetCastPoint() + 0.1
		self.effects = {}
		self:StartIntervalThink( self.delay_time )

		ProgressBars:AddProgressBar(self:GetParent(), self:GetName(), {
            style = "Generic",
            text = "projectiles",
            progressBarType = "duration",
            priority = 0,
        })
	end
end

function modifier_spectre_ex_second_attack:OnDestroy()
	if IsServer() then
		self:StopEffects()
	end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_spectre_ex_second_attack:OnIntervalThink()
	if self.counter < self.projectiles_count then
		self:PlayEffects(self.counter)
		self.counter = self.counter + 1

		self:GetCaster():CastAbilityImmediately(self.projectile_spell, self:GetCaster():GetEntityIndex())
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_spectre_ex_second_attack:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_spectre_ex_second_attack:GetModifierMoveSpeedBonus_Percentage()
	return - (100 - self.movement_speed)
end

--------------------------------------------------------------------------------
-- Graphics & sounds
function modifier_spectre_ex_second_attack:PlayEffects( i )
	local particle_cast = "particles/econ/items/mirana/mirana_ti8_immortal_mount/mirana_ti8_immortal_leap_start_embers.vpcf"
	local origin = self:GetParent():GetOrigin()
	
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt( self.effect_cast, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", origin, true );
	ParticleManager:SetParticleControlEnt( self.effect_cast, 3, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", origin, true );
	
	self.effects[i] = self.effect_cast
end

function modifier_spectre_ex_second_attack:StopEffects()
	for i = 0, self.counter - 1 do
		ParticleManager:DestroyParticle(self.effects[i], false)
		ParticleManager:ReleaseParticleIndex(self.effects[i])
	end
end