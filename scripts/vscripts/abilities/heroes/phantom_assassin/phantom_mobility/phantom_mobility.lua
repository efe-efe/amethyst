phantom_mobility = class({})
LinkLuaModifier( "modifier_phantom_mobility", "abilities/heroes/phantom_assassin/phantom_mobility/modifier_phantom_mobility", LUA_MODIFIER_MOTION_NONE )

function phantom_mobility:OnAbilityPhaseStart()
	-- play effects
	self:PlayEffects_a()

	return true -- if success
end

function phantom_mobility:OnSpellStart()
    --Initialize variables
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()
    local point = self:GetCursorPosition()
    local max_range = self:GetSpecialValueFor("max_range")
    local buff_duration = self:GetSpecialValueFor("buff_duration")


    -- determine target position
    local difference = point - origin

    if difference:Length2D() > max_range then
        point = origin + (point - origin):Normalized() * max_range
    end

    -- teleport
    FindClearSpaceForUnit( caster, point , true )

    caster:AddNewModifier(
        caster,
        self,
        "modifier_phantom_mobility",
        {duration = buff_duration}
    )

    local special_attack = caster:FindAbilityByName("phantom_special_attack")
    local ex_special_attack = caster:FindAbilityByName("phantom_ex_special_attack")
    special_attack:EndCooldown()
    ex_special_attack:EndCooldown()

    --Effects
    self:PlayEffects_b()
end

function phantom_mobility:PlayEffects_a()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_phantom_assassin/phantom_assassin_phantom_strike_start.vpcf"
    local sound_cast = "Hero_PhantomAssassin.Strike.Start"
    
    -- Sound
    EmitSoundOn(sound_cast, self:GetCaster())

	-- Create Particles
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

function phantom_mobility:PlayEffects_b()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_phantom_assassin/phantom_assassin_phantom_strike_end.vpcf"
    local sound_cast = "Hero_PhantomAssassin.Strike.End"
    
    -- Sound
    EmitSoundOn(sound_cast, self:GetCaster())

	-- Create Particles
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end