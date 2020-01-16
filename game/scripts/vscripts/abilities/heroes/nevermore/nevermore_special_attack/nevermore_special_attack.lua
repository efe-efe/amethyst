nevermore_special_attack = class({})

function nevermore_special_attack:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = CalcRange(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)
	local delay_time = self:GetSpecialValueFor( "delay_time" )
	local radius = self:GetSpecialValueFor("radius")

	local particle_cast = "particles/econ/items/oracle/oracle_fortune_ti7/oracle_fortune_ti7_aoe.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )
	ParticleManager:SetParticleControl( effect_cast, 3, caster:GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	
	self:EndCooldown()
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	nevermore_special_attack,
	{ activity = ACT_DOTA_RAZE_2, rate = 1.5 },
	{ movement_speed = 80 }
)