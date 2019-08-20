modifier_nevermore_counter = class({})
--LinkLuaModifier( "modifier_nevermore_counter_thinker", "abilities/heroes/nevermore/nevermore_counter/modifier_nevermore_counter_thinker", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Classifications
function modifier_nevermore_counter:IsHidden()
	return false
end

function modifier_nevermore_counter:IsDebuff()
	return false
end

function modifier_nevermore_counter:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_nevermore_counter:OnCreated( kv )
    if IsServer() then
        -- Can't move
        self:GetParent():SetMoveCapability(DOTA_UNIT_CAP_MOVE_NONE)
        self.duration = self:GetAbility():GetSpecialValueFor("duration")
        --Effects
        EmitSoundOn("Hero_Nevermore.RequiemOfSoulsCast", self:GetParent())
    end
end

--------------------------------------------------------------------------------
-- On destroy
function modifier_nevermore_counter:OnDestroy( kv )
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
        StopSoundOn("Hero_Nevermore.RequiemOfSoulsCast",  self:GetParent())
    end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_nevermore_counter:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_nevermore_counter:CheckState()
	local state = {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_SILENCED] = true,
	}

	return state
end

function modifier_nevermore_counter:GetModifierIncomingDamage_Percentage( params )
    if IsServer() then
		local caster = self:GetParent()
        local attacker = params.attacker

        -- Pure damage doesnt trigger the counter
        if params.damage_type ~= DAMAGE_TYPE_PURE then
            
            local RemovePositiveBuffs = false
            local RemoveDebuffs = true
            local BuffsCreatedThisFrameOnly = false
            local RemoveStuns = true
            local RemoveExceptions = false

            -- Apply dispell after debuffs and stuns are applied
            Timers:CreateTimer(0.001, function()
                caster:Purge( RemovePositiveBuffs, RemoveDebuffs, BuffsCreatedThisFrameOnly, RemoveStuns, RemoveExceptions)
            end)


            --[[CreateModifierThinker(
                caster, --hCaster
                self:GetAbility(), --hAbility
                "modifier_nevermore_counter_thinker", --modifierName
                { duration = 1.0 }, --paramTable
                caster:GetOrigin(), --vOrigin
                caster:GetTeamNumber(), --nTeamNumber
                false --bPhantomBlocker
            )]]

            local ability = caster:FindAbilityByName("nevermore_counter_mobility")
            caster:CastAbilityOnPosition(Vector(0,0,0), ability, caster:GetPlayerID())

            -- End
            self:PlayEffects()

            self:Destroy()
            return -100
        end
        return 0
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_nevermore_counter:GetStatusEffectName()
	return "particles/status_fx/status_effect_guardian_angel.vpcf"
end

function modifier_nevermore_counter:PlayEffects()
    local caster = self:GetParent()
    -- Create sounds
    local sound_cast = "Hero_Nevermore.RequiemOfSouls"
    EmitSoundOn(sound_cast, caster)

	-- create particle
	local particle_cast = "particles/econ/events/ti9/blink_dagger_ti9_start_lvl2.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, caster:GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
    
    -- create particle
	local particle_cast_b = "particles/econ/events/ti9/phase_boots_ti9_body_magic.vpcf"
	local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast_b, 0, caster:GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast_b )

    
end

--[[
    -- Create particle
    local particle_cast = "particles/units/heroes/hero_terrorblade/terrorblade_scepter.vpcf"

    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster)
    ParticleManager:SetParticleControl(effect_cast, 0, caster:GetOrigin()) 
    ParticleManager:SetParticleControl(effect_cast, 1, Vector(2000,2000,2000)) 
    ParticleManager:SetParticleControl(effect_cast, 2, Vector(2000,2000,2000)) 
    ParticleManager:SetParticleControl(effect_cast, 15, Vector(244,50,50)) 
    ParticleManager:SetParticleControl(effect_cast, 16, Vector(1,0,0)) 
	ParticleManager:ReleaseParticleIndex( effect_cast )
]]