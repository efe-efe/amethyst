modifier_juggernaut_counter = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_juggernaut_counter:IsHidden()
	return false
end

function modifier_juggernaut_counter:IsDebuff()
	return false
end

function modifier_juggernaut_counter:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_juggernaut_counter:OnCreated( params )
    self.movement_speed = params.movement_speed

    if IsServer() then
        -- Can't move
        self:GetParent():SetMoveCapability(DOTA_UNIT_CAP_MOVE_NONE)

        --Effects
        --self:PlayEffectsActivateTick()
        --self:PlayEffectsSpin()

		self:GetParent():AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_generic_projectile_reflector_lua",
			{ duration = self:GetDuration() }
		)

        -- Animation and pseudo cast point

        StartAnimation(self:GetParent(), { 
            duration = self:GetDuration() + 0.1, 
            activity = ACT_DOTA_SPAWN, 
            rate = 0.1
        })

        --[[
        StartAnimation(self:GetParent(), { 
            duration = self:GetDuration() + 0.1, 
            activity = ACT_DOTA_OVERRIDE_ABILITY_1, 
            rate = 1.5
        })]]
    end
end

--------------------------------------------------------------------------------
-- On destroy
function modifier_juggernaut_counter:OnDestroy( kv )
    if IsServer() then
        --Can move again
        self:GetParent():SetMoveCapability(DOTA_UNIT_CAP_MOVE_GROUND)
        
        --Quits the animation
        local order = 
        {
            OrderType = DOTA_UNIT_ORDER_STOP,
            UnitIndex = self:GetParent():entindex()
        }
        ExecuteOrderFromTable(order)

        --Remove effects
        self:PlayEffectsActivateTick()
        --self:StopEffects()
        GameRules.EndAnimation(self:GetParent())
    end
end


--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_juggernaut_counter:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_juggernaut_counter:GetModifierMoveSpeedBonus_Percentage()
    if self.movement_speed ~= nil then
        local reduction = - (100 - self.movement_speed)
        return reduction
    end
end

function modifier_juggernaut_counter:GetModifierIncomingDamage_Percentage( params )
    if IsServer() then
		local caster = self:GetParent()
        local attacker = params.attacker

        -- Pure damage doesnt trigger the counter
        if params.damage_type ~= DAMAGE_TYPE_PURE then
            self:PlayEffects_b()
            -- Purge
            local RemovePositiveBuffs = false
            local RemoveDebuffs = true
            local BuffsCreatedThisFrameOnly = false
            local RemoveStuns = true
            local RemoveExceptions = false

            -- Apply dispell after debuffs and stuns are applied
            Timers:CreateTimer(0.001, function()
                caster:Purge( RemovePositiveBuffs, RemoveDebuffs, BuffsCreatedThisFrameOnly, RemoveStuns, RemoveExceptions)
            end)

            caster:AddNewModifier(
                caster,
                self:GetAbility(),
                "modifier_juggernaut_counter_buff",
                { duration = 3.0 }
            )

            -- End
            self:Destroy()
            return -100
        end
        return 0
	end
end

-- Status Effects
function modifier_juggernaut_counter:CheckState()
	local state = {
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Sounds

--On casted
function modifier_juggernaut_counter:PlayEffectsSpin()
	-- Get Resources
    local particle_cast = "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_blade_fury_disk.vpcf"
    self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    ParticleManager:SetParticleControl( self.effect_cast, 5, Vector( 100, 1, 1 ) )
end


function modifier_juggernaut_counter:PlayEffectsActivateTick()
    -- Get Resources
    EmitSoundOn("Hero_Juggernaut.Attack", self:GetCaster())
	local particle_cast = "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_omni_slash_tgt_bonus.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end



function modifier_juggernaut_counter:StopEffects()
    if IsServer() then
        ParticleManager:DestroyParticle( self.effect_cast, false )
        ParticleManager:ReleaseParticleIndex( self.effect_cast )
    end
end

-- On activated
function modifier_juggernaut_counter:PlayEffects_b()
    -- Get Resources
	local particle_cast = "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_trigger_sphere.vpcf"
    
    -- Create Sound
    EmitSoundOn( "Hero_Juggernaut.BladeDance" , self:GetCaster())
    
    -- particles 1
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    ParticleManager:ReleaseParticleIndex( effect_cast )

end

-- Graphics & Animations
function modifier_juggernaut_counter:GetStatusEffectName()
	return "particles/status_fx/status_effect_guardian_angel.vpcf"
end