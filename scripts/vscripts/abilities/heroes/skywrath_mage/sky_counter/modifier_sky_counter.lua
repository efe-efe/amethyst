modifier_sky_counter =  class({}) 
LinkLuaModifier( "modifier_sky_counter_movement", "abilities/heroes/skywrath_mage/sky_counter/modifier_sky_counter_movement", LUA_MODIFIER_MOTION_HORIZONTAL )

--------------------------------------------------------------------------------
-- Classifications
function modifier_sky_counter:IsHidden()
	return false
end

function modifier_sky_counter:IsDebuff()
	return false
end

function modifier_sky_counter:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sky_counter:OnCreated( kv )
    if IsServer() then
        self.buff_duration = self:GetAbility():GetSpecialValueFor("buff_duration")
        self.heal_amount = self:GetAbility():GetSpecialValueFor("heal_amount")
        self.knockback_radius = self:GetAbility():GetSpecialValueFor("knockback_radius")
        self.damage = self:GetAbility():GetAbilityDamage()
        self.knockback_distance = self:GetAbility():GetSpecialValueFor("knockback_distance")

        -- Can't move
        self:GetParent():SetMoveCapability(DOTA_UNIT_CAP_MOVE_NONE)

        --Effects
        self:PlayEffects()
    end
end

--------------------------------------------------------------------------------
-- On destroy
function modifier_sky_counter:OnDestroy( kv )
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
        self:StopEffects()
    end
end


--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sky_counter:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}

	return funcs
end

function modifier_sky_counter:GetModifierIncomingDamage_Percentage( params )
    if IsServer() then
		local caster = self:GetParent()
        local attacker = params.attacker

        -- Pure damage doesnt trigger the counter
        if params.damage_type ~= DAMAGE_TYPE_PURE then
            
            self:PlayEffects2()
            -- Heal
            caster:Heal(self.heal_amount, caster)

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

            -- Find enemies
            local enemies = FindUnitsInRadius( 
                caster:GetTeamNumber(), -- int, your team number
                caster:GetOrigin(), -- point, center point
                nil, -- handle, cacheUnit. (not known)
                self.knockback_radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
                DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
                DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
                0, -- int, flag filter
                0, -- int, order filter
                false -- bool, can grow cache
            )

            for _,enemy in pairs(enemies) do
                --Knockback

                local x = enemy:GetOrigin().x - caster:GetOrigin().x
                local y = enemy:GetOrigin().y - caster:GetOrigin().y
                local distance = self.knockback_distance
                local movement_modifier = enemy:AddNewModifier(
                    caster, -- player source
                    self:GetAbility(), -- ability source
                    "modifier_sky_counter_movement", -- modifier name
                    {
                        x = x,
                        y = y,
                        r = distance,
                    } -- kv
                )

                --Damage
                local damageTable = {
                    victim = enemy,
                    attacker = caster,
                    damage = self.damage,
                    damage_type = DAMAGE_TYPE_MAGICAL,
                    ability = self:GetAbility() --Optional.
                }
                
                ApplyDamage(damageTable)
            end
        
            -- End
            self:Destroy()
            return -100
        end
        return 0
	end
end

-- Status Effects
function modifier_sky_counter:CheckState()
	local state = {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Sounds

--On casted
function modifier_sky_counter:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_silencer/silencer_last_word_status.vpcf"
    local sound_cast = "Hero_SkywrathMage.AncientSeal.Target"

    -- Create Sound
    EmitSoundOn(sound_cast, self:GetCaster())

    -- Create Particles
    self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
end


function modifier_sky_counter:StopEffects()
    if IsServer() then
        ParticleManager:DestroyParticle( self.effect_cast, false )
        ParticleManager:ReleaseParticleIndex( self.effect_cast )
    end
end

-- On activated
function modifier_sky_counter:PlayEffects2()
    -- Get Resources
	local particle_cast = "particles/units/heroes/hero_skywrath_mage/skywrath_mage_mystic_flare_ambient.vpcf"
    local sound_cast = "Hero_SkywrathMage.ConcussiveShot.Target"
    
    -- Create Sound
    EmitSoundOn(sound_cast, self:GetCaster())
    
    -- particles 1
    local effect_cast = ParticleManager:CreateParticle( 
            particle_cast, 
            PATTACH_WORLDORIGIN, 
            nil 
        )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.knockback_radius, 0.4 , 0 ) )
    ParticleManager:ReleaseParticleIndex( effect_cast )

end

-- Graphics & Animations
function modifier_sky_counter:GetStatusEffectName()
	return "particles/status_fx/status_effect_guardian_angel.vpcf"
end