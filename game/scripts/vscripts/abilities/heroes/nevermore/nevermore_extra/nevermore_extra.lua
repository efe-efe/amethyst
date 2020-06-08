nevermore_extra = class({})

function nevermore_extra:GetCastAnimationCustom()		return ACT_DOTA_RAZE_2 end
function nevermore_extra:GetPlaybackRateOverride() 		return 1.3 end
function nevermore_extra:GetCastPointSpeed() 			return 0 end
function nevermore_extra:GetFadeGestureOnCast()			return false end

function nevermore_extra:OnSpellStart()
	self:GetCaster():RemoveGesture(self:GetCastAnimationCustom())

	local caster = self:GetCaster()
	local heal_per_soul = self:GetSpecialValueFor("heal_per_soul")
	local heal = self:GetSpecialValueFor("heal")
	local stacks = 0

	local modifier = self:GetCaster():FindModifierByNameAndCaster("modifier_nevermore_souls", caster)
	if modifier~=nil then
		stacks = modifier:GetStackCount() + stacks
		modifier:Destroy()
	end

	self:PlayEffects()
	caster:Heal(heal + (heal_per_soul * stacks), caster)

end

function nevermore_extra:PlayEffects()
	local caster = self:GetCaster()
	EmitSoundOn("DOTA_Item.SoulRing.Activate", caster)

	local particle_cast = "particles/mod_units/heroes/hero_nevermore/nevermore_shadowraze.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster)	
	ParticleManager:SetParticleControl(effect_cast, 0, caster:GetOrigin())
	ParticleManager:SetParticleControl(effect_cast, 60, Vector(68, 243, 0))
	ParticleManager:SetParticleControl(effect_cast, 61, Vector(1, 0, 0))
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(nevermore_extra)