tinker_ultimate_special_attack_lua = class({})
LinkLuaModifier( "modifier_generic_pseudo_cast_point_lua", "abilities/generic/modifier_generic_pseudo_cast_point_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Channeling
function tinker_ultimate_special_attack_lua:OnSpellStart(  )
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()

	-- stop effects
	local sound_cast = "Hero_Tinker.Rearm"
	StopSoundOn( sound_cast, self:GetCaster() )
	
	-- Animation and pseudo cast point
	self:Animate()
	self:PlayEffects()
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point_lua", { duration = cast_point})
end

--------------------------------------------------------------------------------
-- Effects
function tinker_ultimate_special_attack_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_tinker/tinker_rearm.vpcf"
	local sound_cast = "Hero_Tinker.RearmStart"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	EmitSoundOn( sound_cast, self:GetCaster() )
end

function tinker_ultimate_special_attack_lua:OnEndPseudoCastPoint()
	local caster = self:GetCaster()

	-- find all refreshable abilities
	for i=0,caster:GetAbilityCount()-1 do
		local ability = caster:GetAbilityByIndex( i )
		if ability and ability:GetAbilityType()~=DOTA_ABILITY_TYPE_ATTRIBUTES then
			if ability ~= self then
				ability:RefreshCharges()
				ability:EndCooldown()
			end
		end
	end


	local sound_cast = "Hero_Tinker.Rearm"
	EmitSoundOn( sound_cast, self:GetCaster() )
	-- effects
end

function tinker_ultimate_special_attack_lua:Animate()
	local cast_point = self:GetCastPoint()
	StartAnimation(self:GetCaster(), {
		duration = cast_point, 
		activity = ACT_DOTA_TELEPORT_END, 
		translate = "bot", 
		rate = 0.6
	})
end
