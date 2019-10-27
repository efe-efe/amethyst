spectre_ex_second_attack = class({})
LinkLuaModifier( "modifier_spectre_ex_second_attack", "abilities/heroes/spectre/spectre_ex_second_attack/modifier_spectre_ex_second_attack", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function spectre_ex_second_attack:OnSpellStart()
	self:PlayEffectsOnPhase()
end

--------------------------------------------------------------------------------
-- End casting
function spectre_ex_second_attack:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	if IsServer() then
		local delay_time = self:GetCastPoint()
		self.projectiles_count = self:GetSpecialValueFor("projectiles_count")

		local duration = delay_time * (self.projectiles_count + 1)
		self.projectile_spell = caster:FindAbilityByName("spectre_ex_second_attack_projectile")
		self.counter = 0

		caster:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_channeling", -- modifier name
			{ 
				duration = duration,
				movement_speed = 80,
				channeling_tick = self.projectile_spell:GetCastPoint() + 0.1,
				immediate = 1,
			} -- kv
		)
		
	end
end

function spectre_ex_second_attack:OnChannelingTick()
	if IsServer() then
		if self.counter < self.projectiles_count then
			self:PlayEffects()
			self.counter = self.counter + 1
			self:GetCaster():CastAbilityImmediately(self.projectile_spell, self:GetCaster():GetEntityIndex())
		end
	end
end

function spectre_ex_second_attack:PlayEffects()
	local particle_cast = "particles/econ/items/mirana/mirana_ti8_immortal_mount/mirana_ti8_immortal_leap_start_embers.vpcf"
	local origin = self:GetCaster():GetOrigin()
	
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt( effect_cast, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", origin, true );
	ParticleManager:SetParticleControlEnt( effect_cast, 3, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", origin, true );
	ParticleManager:ReleaseParticleIndex( effect_cast )

end

function spectre_ex_second_attack:PlayEffectsOnPhase()
	EmitSoundOn( "Hero_Spectre.Haunt", self:GetCaster())
	local particle_cast = "particles/econ/items/terrorblade/terrorblade_back_ti8/terrorblade_sunder_ti8_swirl_rope.vpcf"

	-- Create Particles
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 15, Vector(128, 32, 108) )
	ParticleManager:SetParticleControl( effect_cast, 16, Vector(1, 0, 0) )

	ParticleManager:ReleaseParticleIndex( effect_cast )
end

if IsClient() then require("abilities") end
Abilities.Initialize( 
	spectre_ex_second_attack,
	{ activity = ACT_DOTA_GENERIC_CHANNEL_1, rate = 1.0 },
	{ movement_speed = 50 }
)