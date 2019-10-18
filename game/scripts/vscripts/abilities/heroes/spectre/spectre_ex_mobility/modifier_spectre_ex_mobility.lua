modifier_spectre_ex_mobility = class({})

--- Misc 
function modifier_spectre_ex_mobility:IsHidden()
    return false
end

function modifier_spectre_ex_mobility:IsDebuff()
	return false
end

function modifier_spectre_ex_mobility:IsPurgable()
    return false
end


--------------------------------------------------------------------------------
-- Initializations
function modifier_spectre_ex_mobility:OnCreated( kv )
    self.speed_buff_pct = self:GetAbility():GetSpecialValueFor("speed_buff_pct")

    if IsServer() then
        self.damage_per_second = self:GetAbility():GetSpecialValueFor("damage_per_second")
        self.radius = 250
        self.damage_done = 0

        self:PlayEffectsOnCreated()
        self:StartIntervalThink( 0.3 )

		ProgressBars:AddProgressBar(self:GetParent(), self:GetName(), {
			style = "Darkness",
			text = "darkness",
			progressBarType = "duration",
			priority = 3,
		})
    end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_spectre_ex_mobility:OnIntervalThink()
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
        self.damage_done = self.damage_done + self.damage_per_second
        self:PlayEffectsOnTarget(enemy)
        ApplyDamage( damage )
    end
end

--------------------------------------------------------------------------------
-- Destroyer
function modifier_spectre_ex_mobility:OnDestroy( kv )
    if IsServer() then
        self:GetParent():Heal( self.damage_done, self:GetParent() )
        self:StopEffects()
    end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_spectre_ex_mobility:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
	}

	return funcs
end

function modifier_spectre_ex_mobility:GetModifierMoveSpeedBonus_Percentage()
    return self.speed_buff_pct
end

function modifier_spectre_ex_mobility:GetModifierIgnoreMovespeedLimit( params )
    return 1
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_spectre_ex_mobility:PlayEffectsOnCreated( )
    local parent = self:GetParent()
    EmitSoundOn("Hero_Spectre.Haunt", parent)

	local particle_cast = "particles/econ/items/juggernaut/jugg_ti8_sword/juggernaut_blade_fury_abyssal.vpcf"
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, parent )
    ParticleManager:SetParticleControl( self.effect_cast, 2, parent:GetOrigin() )
    
    
    local particle_cast = "particles/econ/items/silencer/silencer_ti6/silencer_last_word_status_ti6_ring_mist.vpcf"
	self.effect_cast_ring = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, parent )
    ParticleManager:SetParticleControl( self.effect_cast_ring, 3, parent:GetOrigin() )
end

function modifier_spectre_ex_mobility:StopEffects()
    if self.effect_cast ~= nil then
        ParticleManager:DestroyParticle( self.effect_cast, false )
        ParticleManager:ReleaseParticleIndex( self.effect_cast )
    end
    if self.effect_cast_ring ~= nil then
        ParticleManager:DestroyParticle( self.effect_cast_ring, false )
        ParticleManager:ReleaseParticleIndex( self.effect_cast_ring )
    end
end

-- Graphics & Animations
function modifier_spectre_ex_mobility:PlayEffectsOnTarget( hTarget )
    EmitSoundOn("Hero_Spectre.Desolate", hTarget)
end
