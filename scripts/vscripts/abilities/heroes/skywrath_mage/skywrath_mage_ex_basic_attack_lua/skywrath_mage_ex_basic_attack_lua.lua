skywrath_mage_ex_basic_attack_lua = class({})

--------------------------------------------------------------------------------
-- Ability Start
function skywrath_mage_ex_basic_attack_lua:OnSpellStart()
    local caster = self:GetCaster()
    self:PlayEffects()
end

--------------------------------------------------------------------------------
-- Graphics & Sounds
function skywrath_mage_ex_basic_attack_lua:PlayEffects()
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

--