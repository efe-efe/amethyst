skywrath_mage_mobility_lua = class({})

function skywrath_mage_mobility_lua:OnSpellStart()
    --Initialize variables
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()
    local point = self:GetCursorPosition()
    local max_range = self:GetSpecialValueFor("range")


    -- determine target position
    local difference = point - origin

    if difference:Length2D() > max_range then
        point = origin + (point - origin):Normalized() * max_range
    end

    -- teleport
    FindClearSpaceForUnit( caster, point , true )

	-- Delete timer for the basic attack
	local basic_attack_timer = caster:FindModifierByNameAndCaster( 
		"modifier_skywrath_mage_basic_attack_charged_timer_lua", caster 
	)
	if basic_attack_timer~=nil then
		if not basic_attack_timer:IsNull() then
            basic_attack_timer:Destroy()
		end
    end
    --remove cooldown from basic attack charged
    local basic_attack_charged = caster:FindAbilityByName("skywrath_mage_basic_attack_charged_lua")
    basic_attack_charged:EndCooldown()

    --Effects
    self:PlayEffects()
end

function skywrath_mage_mobility_lua:PlayEffects()
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