nevermore_ex_ultimate = class({})


--------------------------------------------------------------------------------
-- Ability Start
function nevermore_ex_ultimate:OnSpellStart()
	-- Initialize bariables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()

	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=0.7, activity=ACT_DOTA_RAZE_2, rate=1.3})
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point", { 
		duration = cast_point,
		movement_speed = 10,
		no_target = 1
	})
end

--------------------------------------------------------------------------------
-- Ability Start
function nevermore_ex_ultimate:OnEndPseudoCastPoint()
	-- get references
	local caster = self:GetCaster()
	local heal_per_soul = self:GetSpecialValueFor("heal_per_soul")
	local stacks = 0

	local modifier = self:GetCaster():FindModifierByNameAndCaster( "modifier_nevermore_souls", caster )
	if modifier~=nil then
		stacks = modifier:GetStackCount()
		modifier:Destroy()
	end

	self:PlayEffects()
	caster:Heal(heal_per_soul * stacks, caster)
end


--------------------------------------------------------------------------------
-- Effects
function nevermore_ex_ultimate:PlayEffects()
	local caster = self:GetCaster()

	-- Create sounds
	local sound_cast = "DOTA_Item.SoulRing.Activate"
	EmitSoundOn( sound_cast, caster )

	-- Create Particles
	local particle_cast = "particles/mod_units/heroes/hero_nevermore/nevermore_shadowraze.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )	
	ParticleManager:SetParticleControl( effect_cast, 0, caster:GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 60, Vector(68, 243, 0) )
	ParticleManager:SetParticleControl( effect_cast, 61, Vector(1, 0, 0) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end