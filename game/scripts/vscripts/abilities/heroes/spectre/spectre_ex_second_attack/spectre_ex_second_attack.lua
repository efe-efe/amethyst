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
	local projectiles_count = self:GetSpecialValueFor("projectiles_count")
	local delay_time = self:GetCastPoint() + 0.1
	local duration = delay_time * (projectiles_count + 1)

	caster:AddNewModifier(caster, self, "modifier_spectre_ex_second_attack", { duration = duration })
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