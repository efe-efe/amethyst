modifier_spectre_ex_mobility_lua = class({})

--- Misc 
function modifier_spectre_ex_mobility_lua:IsHidden()
    return true
end

function modifier_spectre_ex_mobility_lua:IsPurgable()
    return false
end


--------------------------------------------------------------------------------
-- Initializations
function modifier_spectre_ex_mobility_lua:OnCreated( kv )
    --Initializers
    if IsServer() then
        self.speed_buff = self:GetAbility():GetSpecialValueFor("speed_buff")
        self.damage_per_second = self:GetAbility():GetSpecialValueFor("damage_per_second")
        self.radius = 250

        self:PlayEffects()
        self:PlayEffects2()

        self:StartIntervalThink( 0.3 )
    end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_spectre_ex_mobility_lua:OnIntervalThink()
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
    end
end

--------------------------------------------------------------------------------
-- Destroyer
function modifier_spectre_ex_mobility_lua:OnDestroy( kv )
    if IsServer() then
        self:StopEffects()
    end
end


function modifier_spectre_ex_mobility_lua:OnAbilityExecuted( params )
	if IsServer() then
		if params.unit~=self:GetParent() then return end
		self:Destroy()
	end
end


--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_spectre_ex_mobility_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_EVENT_ON_ABILITY_EXECUTED,
	}

	return funcs
end

function modifier_spectre_ex_mobility_lua:GetModifierMoveSpeedBonus_Percentage()
    return self.speed_buff
end


-- Graphics & Animations
function modifier_spectre_ex_mobility_lua:PlayEffects( )
	local particle_cast = "particles/econ/items/juggernaut/jugg_ti8_sword/juggernaut_blade_fury_abyssal.vpcf"

	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    ParticleManager:SetParticleControl( self.effect_cast, 2, self:GetParent():GetOrigin() )
    
end

-- Graphics & Animations
function modifier_spectre_ex_mobility_lua:PlayEffects2( )
    local particle_cast = "particles/econ/items/silencer/silencer_ti6/silencer_last_word_status_ti6_ring_mist.vpcf"
    local sound_cast = "Hero_Spectre.Haunt"

	self.effect_cast2 = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    ParticleManager:SetParticleControl( self.effect_cast2, 0, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( self.effect_cast2, 3, self:GetParent():GetOrigin() )

    EmitSoundOn(sound_cast, self:GetParent())
    
end

function modifier_spectre_ex_mobility_lua:StopEffects()
    ParticleManager:DestroyParticle( self.effect_cast, false )
    ParticleManager:ReleaseParticleIndex( self.effect_cast )
    
    ParticleManager:DestroyParticle( self.effect_cast2, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast2 )
end

-- Graphics & Animations
function modifier_spectre_ex_mobility_lua:PlayEffects3( hTarget )
    local sound_cast = "Hero_Spectre.Desolate"

    EmitSoundOn(sound_cast, hTarget)
end
