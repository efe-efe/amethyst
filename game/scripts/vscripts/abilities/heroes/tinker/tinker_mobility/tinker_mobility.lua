tinker_mobility = class({})
--------------------------------------------------------------------------------
-- Ability Start
function tinker_mobility:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
	self:PlayEffects_a()

	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=0.3, activity=ACT_DOTA_CAST_ABILITY_2, rate=1.2})
	caster:AddNewModifier(caster, self , "modifier_cast_point", { 
        duration = cast_point
	})
end

function tinker_mobility:OnCastPointEnd( point )
    --Initialize variables
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()
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
end

function tinker_mobility:PlayEffects_a()
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

function tinker_mobility:PlayEffects_b()
	-- Get Resources
	local particle_cast = "particles/econ/events/ti7/blink_dagger_end_ti7.vpcf"
    local sound_cast = "DOTA_Item.BlinkDagger.NailedIt"
    
    -- Sound
    EmitSoundOn(sound_cast, self:GetCaster())

	-- Create Particles
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end