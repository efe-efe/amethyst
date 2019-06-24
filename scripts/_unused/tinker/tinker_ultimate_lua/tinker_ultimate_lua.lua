tinker_ultimate = class({})
LinkLuaModifier( "modifier_tinker_ultimate", "abilities/heroes/tinker/tinker_ultimate/modifier_tinker_ultimate", LUA_MODIFIER_MOTION_NONE )

function tinker_ultimate:OnAbilityPhaseStart()
	-- play effects
	local sound_cast = "tinker_tink_laugh_04"
	EmitGlobalSound( sound_cast )
	return true -- if success
end

function tinker_ultimate:OnAbilityPhaseInterrupted()	
    -- stop effects 
	local sound_cast = "tinker_tink_happy_01"
	StopGlobalSound( sound_cast )
	return true -- if success
end

function tinker_ultimate:OnSpellStart()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")

    caster:AddNewModifier(
        caster,
        self,
        "modifier_tinker_ultimate",
        { duration = duration }
    )

    caster:SwapAbilities( 
        "tinker_special_attack",
        "tinker_ultimate_special_attack_lua",
        false,
        true
    )

    self:PlayEffects()
end

--------------------------------------------------------------------------------
-- Effects
function tinker_ultimate:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_tinker/tinker_rearm.vpcf"
	local sound_cast = "Hero_Tinker.RearmStart"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	EmitSoundOn( sound_cast, self:GetCaster() )
end