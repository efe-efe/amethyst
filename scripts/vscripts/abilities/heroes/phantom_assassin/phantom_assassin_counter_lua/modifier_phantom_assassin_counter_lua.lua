modifier_phantom_assassin_counter_lua = class({})

--------------------------------------------------------------------------------
function modifier_phantom_assassin_counter_lua:IsDebuff()
	return false
end

function modifier_phantom_assassin_counter_lua:IsHidden()
	return true
end

function modifier_phantom_assassin_counter_lua:IsPurgable()
	return false
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_phantom_assassin_counter_lua:OnCreated( kv )
    if IsServer() then
        self:PlayEffects_a()
		self:GetParent():AddNoDraw()
	end
end

function modifier_phantom_assassin_counter_lua:OnRefresh( kv )
	
end

function modifier_phantom_assassin_counter_lua:OnDestroy( kv )
	if IsServer() then
		self:GetParent():RemoveNoDraw()
		self:PlayEffects_b()
	end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_phantom_assassin_counter_lua:CheckState()
	local state = {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}

	return state
end


function modifier_phantom_assassin_counter_lua:PlayEffects_a()
	-- Get Resources
	local sound_cast = "Hero_PhantomAssassin.Blur"
	local particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_event_glitch.vpcf"
    
	-- Create Sound
    EmitSoundOn( sound_cast, self:GetCaster()  )

    -- Create Particles
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetCaster() )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )

end

function modifier_phantom_assassin_counter_lua:PlayEffects_b()
		-- Get Resources
        local sound_cast = "Hero_PhantomAssassin.Blur.Break"
        local particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_disk_end.vpcf"
        
        -- Create Sound
        EmitSoundOn( sound_cast, self:GetCaster()  )
    
        -- Create Particles
        local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
        ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
        ParticleManager:SetParticleControl( effect_cast, 3, self:GetCaster():GetOrigin() )

        ParticleManager:ReleaseParticleIndex( effect_cast )
end
