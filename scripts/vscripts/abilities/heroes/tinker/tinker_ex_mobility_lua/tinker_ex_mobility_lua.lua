tinker_ex_mobility_lua = class({})

function tinker_ex_mobility_lua:OnAbilityPhaseStart()
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

	-- play effects
	self:PlayEffects_a(point)
	return true -- if success
end

function tinker_ex_mobility_lua:OnAbilityPhaseInterrupted()
	self:StopEffects_a()
	return true -- if success
end


function tinker_ex_mobility_lua:OnSpellStart()
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
    self:StopEffects_a()
    --self:PlayEffects_b()

    -- Put CD on the alternate of the ability
	local alternate_version = caster:FindAbilityByName("tinker_mobility_lua")
	alternate_version:StartCooldown(self:GetCooldown(0))
end

function tinker_ex_mobility_lua:PlayEffects_a(point)
	-- Create sound
    local sound_cast = "Hero_Tinker.MechaBoots.Loop"
    EmitSoundOn(sound_cast, self:GetCaster())
    
    -- Create Particles
	local particle_cast_a = "particles/econ/items/tinker/boots_of_travel/teleport_start_bots.vpcf"
    local particle_cast_b = "particles/econ/items/tinker/boots_of_travel/teleport_end_bots.vpcf"
    
	self.effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	self.effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_WORLDORIGIN, nil )
    
    
    ParticleManager:SetParticleControl( self.effect_cast_a, 0, self:GetCaster():GetOrigin() )
    ParticleManager:SetParticleControl( self.effect_cast_b, 0, point )
end

function tinker_ex_mobility_lua:PlayEffects_b()    
    -- Create Particles
    local particle_cast = "particles/econ/events/pw_compendium_2014/teleport_end_ground_flash_pw2014.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

function tinker_ex_mobility_lua:StopEffects_a()
    local sound_cast = "Hero_Tinker.MechaBoots.Loop"
    StopSoundOn(sound_cast, self:GetCaster())

    ParticleManager:DestroyParticle( self.effect_cast_a, false )
    ParticleManager:DestroyParticle( self.effect_cast_b, false )
    ParticleManager:ReleaseParticleIndex( self.effect_cast_a )
    ParticleManager:ReleaseParticleIndex( self.effect_cast_b )
end