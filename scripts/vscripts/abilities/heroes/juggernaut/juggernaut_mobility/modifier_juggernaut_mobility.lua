modifier_juggernaut_mobility = class({})

--- Misc 
function modifier_juggernaut_mobility:IsHidden()
    return false
end

function modifier_juggernaut_mobility:IsDebuff()
	return false
end

function modifier_juggernaut_mobility:IsPurgable()
    return false
end


--------------------------------------------------------------------------------
-- Initializations
function modifier_juggernaut_mobility:OnCreated( kv )
    self.speed_buff_pct = self:GetAbility():GetSpecialValueFor("speed_buff_pct")

    --Initializers
    if IsServer() then
        self.damage_per_second = self:GetAbility():GetSpecialValueFor("damage_per_second")
        self.radius = 250

        -- Animation and pseudo cast point
        StartAnimation(self:GetParent(), { 
            duration = self:GetDuration(), 
            activity = ACT_DOTA_OVERRIDE_ABILITY_1, 
            rate = 1.0
        })

        self:PlayEffects()
        self:StartIntervalThink( 0.3 )
    end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_juggernaut_mobility:OnIntervalThink()
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

    for _,enemy in pairs(enemies) do
        local damage = {
            victim = enemy,
            attacker = self:GetParent(),
            damage = self.damage_per_second,
            damage_type = DAMAGE_TYPE_PURE,
        }
        self:PlayEffects3(enemy)
        ApplyDamage( damage )
        
        EmitSoundOn("Hero_Juggernaut.Impact ", enemy)
    end
end

--------------------------------------------------------------------------------
-- Destroyer
function modifier_juggernaut_mobility:OnDestroy( kv )
    if IsServer() then
        self:StopEffects()
        EmitSoundOn("Hero_Juggernaut.BladeFuryStop", self:GetParent())
    end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_juggernaut_mobility:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
	}

	return funcs
end

function modifier_juggernaut_mobility:GetModifierMoveSpeedBonus_Percentage()
    return self.speed_buff_pct
end

function modifier_juggernaut_mobility:GetModifierIgnoreMovespeedLimit( params )
    return 1
end

--------------------------------------------------------------------------------
-- Modifier State
function modifier_juggernaut_mobility:CheckState()
	local state = {
        [MODIFIER_STATE_SILENCED] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}

	return state
end

--------------------------------------------------------------------------------
--Graphics & Animations
function modifier_juggernaut_mobility:PlayEffects( )
	EmitSoundOn("Hero_Juggernaut.BladeFuryStart", self:GetParent())

	local particle_cast = "particles/units/heroes/hero_juggernaut/juggernaut_blade_fury.vpcf"

	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    ParticleManager:SetParticleControl( self.effect_cast, 5, Vector( 200, 1, 1 ) )
    ParticleManager:SetParticleControl( self.effect_cast, 2, self:GetParent():GetOrigin() )
    
end


function modifier_juggernaut_mobility:StopEffects()
    StopSoundOn("Hero_Juggernaut.BladeFuryStart", self:GetParent())

    ParticleManager:DestroyParticle( self.effect_cast, false )
    ParticleManager:ReleaseParticleIndex( self.effect_cast )
end

function modifier_juggernaut_mobility:PlayEffects3( hTarget )
    local sound_cast = "Hero_Spectre.Desolate"

    EmitSoundOn(sound_cast, hTarget)
end


function modifier_juggernaut_mobility:GetEffectName()
	return "particles/econ/events/ti9/phase_boots_ti9.vpcf"
end

function modifier_juggernaut_mobility:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
