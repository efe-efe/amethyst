modifier_sky_ultimate_thinker = class({})
LinkLuaModifier( "modifier_sky_special_attack_movement", "abilities/heroes/skywrath_mage/sky_special_attack/modifier_sky_special_attack_movement", LUA_MODIFIER_MOTION_HORIZONTAL )

--------------------------------------------------------------------------------

function modifier_sky_ultimate_thinker:IsHidden()
	return true
end
--------------------------------------------------------------------------------

function modifier_sky_ultimate_thinker:OnCreated( kv )
    if IsServer() then
        self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
        self.damage_heal_per_think = self:GetAbility():GetSpecialValueFor( "damage_heal_per_think" )
        self.think_interval = self:GetAbility():GetSpecialValueFor( "think_interval" )
        self:PlayEffects()

        -- Start Interval
        self:StartIntervalThink( self.think_interval )        
    end
end

function modifier_sky_ultimate_thinker:OnDestroy()
    if IsServer() then
        local sound_cast = "Hero_SkywrathMage.MysticFlare"
		StopSoundOn( sound_cast, self:GetCaster() )
		UTIL_Remove( self:GetParent() )
	end
end

--------------------------------------------------------------------------------
function modifier_sky_ultimate_thinker:OnIntervalThink()
    local thinker = self:GetParent()
    local thinker_origin = thinker:GetOrigin()
    local caster = self:GetCaster()

    --Find enemies to damage
    local enemies = FindUnitsInRadius( 
        caster:GetTeamNumber(), -- int, your team number
        thinker_origin, -- point, center point
        nil, -- handle, cacheUnit. (not known)
        self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
        DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
        0, -- int, flag filter
        0, -- int, order filter
        false -- bool, can grow cache
    )

    --Find allies to heal
    local allies = FindUnitsInRadius( 
        caster:GetTeamNumber(), -- int, your team number
        thinker_origin, -- point, center point
        nil, -- handle, cacheUnit. (not known)
        self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
        DOTA_UNIT_TARGET_TEAM_FRIENDLY, -- int, team filter
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
        0, -- int, flag filter
        0, -- int, order filter
        false -- bool, can grow cache
    )

    --Damage enemies
    for _,enemy in pairs(enemies) do
        local damage = {
            victim = enemy,
            attacker = caster,
            damage = self.damage_heal_per_think,
            damage_type = DAMAGE_TYPE_PURE,
        }

        ApplyDamage( damage )
    end

    --Heal allies
    for _,ally in pairs(allies) do
       ally:Heal(self.damage_heal_per_think, caster)
    end
end

function modifier_sky_ultimate_thinker:PlayEffects()
    -- Get Resources
    local sound_cast = "Hero_SkywrathMage.MysticFlare"
	local particle_cast = "particles/econ/items/skywrath_mage/skywrath_mage_weapon_empyrean/skywrath_mage_mystic_flare_ambient_empyrean_gold.vpcf"
    
    -- particles 1
    local effect_cast = ParticleManager:CreateParticle( 
            particle_cast, 
            PATTACH_WORLDORIGIN, 
            nil 
        )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, self:GetDuration(), self.think_interval ) )
    ParticleManager:ReleaseParticleIndex( effect_cast )

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
    )
    
    EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), sound_cast, self:GetCaster() )
end