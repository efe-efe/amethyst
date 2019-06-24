modifier_phantom_counter = class({})
LinkLuaModifier( "modifier_phantom_counter_buff", "abilities/heroes/phantom_assassin/phantom_counter/modifier_phantom_counter_buff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
function modifier_phantom_counter:IsDebuff()
	return false
end

function modifier_phantom_counter:IsHidden()
	return true
end

function modifier_phantom_counter:IsPurgable()
	return false
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_phantom_counter:OnCreated( kv )
    if IsServer() then
        self:PlayEffects_a()
		self:GetParent():AddNoDraw()
	end
end

function modifier_phantom_counter:OnRefresh( kv )
	
end

function modifier_phantom_counter:OnDestroy( kv )
	if IsServer() then
		self:GetParent():RemoveNoDraw()

		-- Add speed buff
        local speed_duration = self:GetAbility():GetSpecialValueFor( "speed_duration" )

		self:GetParent():AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_phantom_counter_buff",
			{ duration = speed_duration }
		)

		self:PlayEffects_b()
	end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_phantom_counter:CheckState()
	local state = {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}

	return state
end


function modifier_phantom_counter:PlayEffects_a()
	-- Create Sound
	local sound_cast = "Hero_PhantomAssassin.Blur"
    EmitSoundOn( sound_cast, self:GetCaster()  )

	-- Create Particles
	local particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_event_glitch.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetCaster() )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_phantom_counter:PlayEffects_b()
        -- Create Sound
        local sound_cast = "Hero_PhantomAssassin.Blur.Break"
        EmitSoundOn( sound_cast, self:GetCaster()  )
    
		-- Create Particles
		local particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_event_glitch.vpcf"
        local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
        ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
        ParticleManager:SetParticleControl( effect_cast, 3, self:GetCaster():GetOrigin() )

        ParticleManager:ReleaseParticleIndex( effect_cast )
end
