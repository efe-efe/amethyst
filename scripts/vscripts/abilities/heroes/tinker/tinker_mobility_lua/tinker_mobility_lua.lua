tinker_mobility_lua = class({})

function tinker_mobility_lua:OnAbilityPhaseStart()
	-- play effects
	self:PlayEffects_a()

	return true -- if success
end

function tinker_mobility_lua:OnSpellStart()
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

    --Effects
    self:PlayEffects_b()

    
    -- Put CD on the alternate of the ability
	local alternate_version = caster:FindAbilityByName("tinker_ex_mobility_lua")
	alternate_version:StartCooldown(self:GetCooldown(0))
end

function tinker_mobility_lua:PlayEffects_a()
	-- Get Resources
	local particle_cast = "particles/econ/events/ti7/blink_dagger_start_ti7.vpcf"
    local sound_cast = "DOTA_Item.BlinkDagger.Activate"
    
    -- Sound
    EmitSoundOn(sound_cast, self:GetCaster())

	-- Create Particles
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

function tinker_mobility_lua:PlayEffects_b()
	-- Get Resources
	local particle_cast = "particles/econ/events/ti7/blink_dagger_end_ti7.vpcf"
    local sound_cast = "DOTA_Item.BlinkDagger.NailedIt"
    
    -- Sound
    EmitSoundOn(sound_cast, self:GetCaster())

	-- Create Particles
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end