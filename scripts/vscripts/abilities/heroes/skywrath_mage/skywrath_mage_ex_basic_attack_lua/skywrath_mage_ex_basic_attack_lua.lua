skywrath_mage_ex_basic_attack_lua = class({})

-- This function is used to change between abilities and ex abilities
--------------------------------------------------------------------------------
function skywrath_mage_ex_basic_attack_lua:GetRelatedName()
    local ability_name = ""
    local caster = self:GetCaster()

    -- find and destroy visual modifier
	local basic_attack_timer = caster:FindModifierByNameAndCaster( 
		"modifier_skywrath_mage_basic_attack_charged_timer_lua", caster 
    )

    if basic_attack_timer~=nil then
        if not basic_attack_timer:IsNull() then
            ability_name = "skywrath_mage_basic_attack_lua"
        else
            ability_name = "skywrath_mage_basic_attack_charged_lua"
        end
    else
        ability_name = "skywrath_mage_basic_attack_charged_lua"
    end

    return ability_name
end

--------------------------------------------------------------------------------
-- Ability Start
function skywrath_mage_ex_basic_attack_lua:OnSpellStart()
    local caster = self:GetCaster()

    -- Delete timer for the basic attack
	local basic_attack_timer = caster:FindModifierByNameAndCaster( 
		"modifier_skywrath_mage_basic_attack_charged_timer_lua", caster 
	)
	if basic_attack_timer~=nil then
		if not basic_attack_timer:IsNull() then
            basic_attack_timer:Destroy()
		end
    end

    local basic_attack_charged = caster:FindAbilityByName("skywrath_mage_basic_attack_charged_lua")
    basic_attack_charged:EndCooldown()
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