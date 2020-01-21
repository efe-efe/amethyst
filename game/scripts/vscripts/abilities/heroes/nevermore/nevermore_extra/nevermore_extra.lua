nevermore_extra = class({})

--------------------------------------------------------------------------------
-- Ability Start
function nevermore_extra:OnCastPointEnd()
	local caster = self:GetCaster()
	local heal_per_soul = self:GetSpecialValueFor("heal_per_soul")
	local heal = self:GetSpecialValueFor("heal")
	local stacks = 0

	local modifier = self:GetCaster():FindModifierByNameAndCaster( "modifier_nevermore_souls", caster )
	if modifier~=nil then
		stacks = modifier:GetStackCount() + stacks
		modifier:Destroy()
	end

	self:PlayEffects()
	caster:Heal(heal + (heal_per_soul * stacks), caster)
end

--------------------------------------------------------------------------------
-- Effects
function nevermore_extra:PlayEffects()
	local caster = self:GetCaster()
	EmitSoundOn( "DOTA_Item.SoulRing.Activate", caster )

	-- Create Particles
	local particle_cast = "particles/mod_units/heroes/hero_nevermore/nevermore_shadowraze.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )	
	ParticleManager:SetParticleControl( effect_cast, 0, caster:GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 60, Vector(68, 243, 0) )
	ParticleManager:SetParticleControl( effect_cast, 61, Vector(1, 0, 0) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	nevermore_extra,
	{ activity = ACT_DOTA_RAZE_2, rate = 1.3 },
	{ movement_speed = 10 }
)