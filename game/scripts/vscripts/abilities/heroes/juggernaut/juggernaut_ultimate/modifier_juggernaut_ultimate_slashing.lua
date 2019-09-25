modifier_juggernaut_ultimate_slashing = class({})

--- Misc 
function modifier_juggernaut_ultimate_slashing:IsHidden()
    return false
end

function modifier_juggernaut_ultimate_slashing:IsDebuff()
	return false
end

function modifier_juggernaut_ultimate_slashing:IsPurgable()
    return false
end


--------------------------------------------------------------------------------
-- Initializations
function modifier_juggernaut_ultimate_slashing:OnCreated( kv )
    self.radius = self:GetAbility():GetSpecialValueFor("find_radius")

    --Initializers
    if IsServer() then
        self.damage_per_second = self:GetParent():GetAttackDamage()
        self.current_position = self:GetParent():GetOrigin()
        self.previous_position = self:GetParent():GetOrigin()
        local attacks_per_second = self:GetParent():GetAttacksPerSecond()
	    local attack_speed = math.abs( 1 / attacks_per_second )


        StartAnimation(self:GetParent(), {
            duration=self:GetDuration() + 0.1, 
            activity=ACT_DOTA_OVERRIDE_ABILITY_4, 
            rate=1.5
        })
        
        self:OnIntervalThink()
        self:StartIntervalThink( attack_speed )
    end
end


--------------------------------------------------------------------------------
-- Destroyer
function modifier_juggernaut_ultimate_slashing:OnDestroy( kv )
    if IsServer() then
        GameRules:EndAnimation(self:GetParent())
    end
end


--------------------------------------------------------------------------------
-- Interval Effects
function modifier_juggernaut_ultimate_slashing:OnIntervalThink()

    local enemies = FindUnitsInRadius( 
        self:GetParent():GetTeamNumber(), -- int, your team number
        self:GetParent():GetOrigin(), -- point, center point
        nil, -- handle, cacheUnit. (not known)
        self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
        DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
        0, -- int, flag filter
        0, -- int, order filter
        false -- bool, can grow cache
    )
    
    if #enemies > 0 then
        local enemy_index = RandomInt(1, #enemies)
        local target = enemies[enemy_index]

        while target:Attribute_GetIntValue("dummy", 0) == 1 do
            enemy_index = RandomInt(1, #enemies)
            target = enemies[enemy_index]
        end

        local damage_table = {
            victim = target,
            attacker = self:GetParent(),
            damage = self.damage_per_second,
            damage_type = DAMAGE_TYPE_PURE,
        }
        ApplyDamage( damage_table )

        FindClearSpaceForUnit(self:GetParent(), target:GetAbsOrigin() + RandomVector(128), false)

        local direction = target:GetOrigin() - self:GetParent():GetOrigin()
        direction.z = self:GetParent():GetForwardVector().z
        self:GetParent():SetForwardVector(direction:Normalized())

        self.current_position = self:GetParent():GetOrigin()

        self:PlayEffects(target)
        self:PlayEffects_b()

        self.previous_position = self.current_position
    else
        self:Destroy()
    end
end

--------------------------------------------------------------------------------
-- Destroyer
function modifier_juggernaut_ultimate_slashing:OnDestroy( kv )
    if IsServer() then
    end
end


--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_juggernaut_ultimate_slashing:DeclareFunctions()
	local funcs = {
	}

	return funcs
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_juggernaut_ultimate_slashing:CheckState()
	local state = {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_juggernaut_ultimate_slashing:PlayEffects( hTarget )
    local particle_cast = "particles/units/heroes/hero_juggernaut/juggernaut_omni_slash_tgt.vpcf"
    -- create particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget )
    ParticleManager:ReleaseParticleIndex( effect_cast )
    
    EmitSoundOn("Hero_Juggernaut.OmniSlash.Damage", hTarget)
end

function modifier_juggernaut_ultimate_slashing:PlayEffects_b( )
-- Play particle trail when moving
    local trail_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_juggernaut/juggernaut_omni_slash_trail.vpcf", PATTACH_ABSORIGIN, self:GetCaster())
    ParticleManager:SetParticleControl(trail_pfx, 0, self.previous_position)
    ParticleManager:SetParticleControl(trail_pfx, 1, self.current_position)
    ParticleManager:ReleaseParticleIndex(trail_pfx)
end


function modifier_juggernaut_ultimate_slashing:GetEffectName()
	return "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_trigger.vpcf"
end