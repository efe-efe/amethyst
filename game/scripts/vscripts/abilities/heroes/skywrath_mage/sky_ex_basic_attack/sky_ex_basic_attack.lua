sky_ex_basic_attack = class({})

--LOGIC IS INISDE BASIC ATTACK

function sky_ex_basic_attack:GetAlternateVersion()
    return self:GetCaster():FindAbilityByName("sky_basic_attack")
end

--------------------------------------------------------------------------------
-- Ability Start
function sky_ex_basic_attack:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()

	-- Animation and pseudo cast point
	StartAnimation(caster, { 
        duration = cast_point + 0.1, 
        activity = ACT_DOTA_CAST_ABILITY_1, 
        rate = 1.0 
    })
	caster:AddNewModifier(
        caster, 
        self,
        "modifier_cast_point", 
        {
            duration = cast_point,
            movement_speed = 10,
            no_target = 1,
        }
    )
end

--------------------------------------------------------------------------------
-- Ability Start
function sky_ex_basic_attack:OnCastPointEnd( point )
    self:PlayEffects()
end

--------------------------------------------------------------------------------
-- Graphics & Sounds
function sky_ex_basic_attack:PlayEffects()
    -- Get Resources
    local particle_cast = "particles/econ/items/ogre_magi/ogre_ti8_immortal_weapon/ogre_ti8_immortal_bloodlust_buff_ground.vpcf"
    local sound_cast = "Hero_Enchantress.EnchantCast"
    
    -- Sound
    EmitSoundOn(sound_cast, self:GetCaster())

    -- Create Particles
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:SetParticleControl( effect_cast, 3, self:GetCaster():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end