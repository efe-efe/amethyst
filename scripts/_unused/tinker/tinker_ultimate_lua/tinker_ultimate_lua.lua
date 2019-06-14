tinker_ultimate_lua = class({})
LinkLuaModifier( "modifier_tinker_ultimate_lua", "abilities/heroes/tinker/tinker_ultimate_lua/modifier_tinker_ultimate_lua", LUA_MODIFIER_MOTION_NONE )

function tinker_ultimate_lua:OnAbilityPhaseStart()
	-- play effects
	local sound_cast = "tinker_tink_laugh_04"
	EmitGlobalSound( sound_cast )
	return true -- if success
end

function tinker_ultimate_lua:OnAbilityPhaseInterrupted()	
    -- stop effects 
	local sound_cast = "tinker_tink_happy_01"
	StopGlobalSound( sound_cast )
	return true -- if success
end

function tinker_ultimate_lua:OnSpellStart()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")

    caster:AddNewModifier(
        caster,
        self,
        "modifier_tinker_ultimate_lua",
        { duration = duration }
    )

    caster:SwapAbilities( 
        "tinker_special_attack_lua",
        "tinker_ultimate_special_attack_lua",
        false,
        true
    )

    self:PlayEffects()
end

--------------------------------------------------------------------------------
-- Effects
function tinker_ultimate_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_tinker/tinker_rearm.vpcf"
	local sound_cast = "Hero_Tinker.RearmStart"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	EmitSoundOn( sound_cast, self:GetCaster() )
end