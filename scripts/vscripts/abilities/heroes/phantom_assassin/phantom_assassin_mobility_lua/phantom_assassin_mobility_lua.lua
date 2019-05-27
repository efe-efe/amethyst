phantom_assassin_mobility_lua = class({})
LinkLuaModifier( "modifier_phantom_assassin_mobility_lua", "abilities/heroes/phantom_assassin/phantom_assassin_mobility_lua/modifier_phantom_assassin_mobility_lua", LUA_MODIFIER_MOTION_NONE )

function phantom_assassin_mobility_lua:OnAbilityPhaseStart()
	-- play effects
	self:PlayEffects_a()

	return true -- if success
end

function phantom_assassin_mobility_lua:OnSpellStart()
    --Initialize variables
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()
    local point = self:GetCursorPosition()
    local max_range = self:GetSpecialValueFor("range")
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
        "modifier_phantom_assassin_mobility_lua",
        {duration = buff_duration}
    )

    --Effects
    self:PlayEffects_b()
end

function phantom_assassin_mobility_lua:PlayEffects_a()
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

function phantom_assassin_mobility_lua:PlayEffects_b()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_phantom_assassin/phantom_assassin_phantom_strike_end.vpcf"
    local sound_cast = "Hero_PhantomAssassin.Strike.End"
    
    -- Sound
    EmitSoundOn(sound_cast, self:GetCaster())

	-- Create Particles
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end