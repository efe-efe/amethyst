modifier_skywrath_mage_special_attack_thinker_lua = class({})
LinkLuaModifier( "modifier_skywrath_mage_special_attack_movement_lua", "abilities/heroes/skywrath_mage/skywrath_mage_special_attack_lua/modifier_skywrath_mage_special_attack_movement_lua", LUA_MODIFIER_MOTION_HORIZONTAL )


--------------------------------------------------------------------------------

function modifier_skywrath_mage_special_attack_thinker_lua:IsHidden()
	return true
end

--------------------------------------------------------------------------------

function modifier_skywrath_mage_special_attack_thinker_lua:OnCreated( kv )
    if IsServer() then
        self.radius = self:GetAbility():GetSpecialValueFor( "radius" )

        self:PlayEffects()

        -- Start Interval
        self:StartIntervalThink( 0.2 )        
    end
end

function modifier_skywrath_mage_special_attack_thinker_lua:OnDestroy()
	if IsServer() then
		UTIL_Remove( self:GetParent() )
	end
end

--------------------------------------------------------------------------------
function modifier_skywrath_mage_special_attack_thinker_lua:OnIntervalThink()
    local thinker = self:GetParent()
    local thinker_origin = thinker:GetOrigin()

    local enemies = FindUnitsInRadius( 
        thinker:GetTeamNumber(), -- int, your team number
        thinker_origin, -- point, center point
        nil, -- handle, cacheUnit. (not known)
        self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
        DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
        0, -- int, flag filter
        0, -- int, order filter
        false -- bool, can grow cache
    )

    for _,enemy in pairs(enemies) do
        local x = enemy:GetOrigin().x - thinker_origin.x
        local y = enemy:GetOrigin().y - thinker_origin.y
        local difference = enemy:GetOrigin() - thinker_origin
        local distance = self.radius - difference:Length2D()

        local movement_modifier = enemy:AddNewModifier(
            self:GetCaster(), -- player source
            self:GetAbility(), -- ability source
            "modifier_skywrath_mage_special_attack_movement_lua", -- modifier name
            {
                x = x,
                y = y,
                r = distance,
            } -- kv
        )
    end
end

function modifier_skywrath_mage_special_attack_thinker_lua:PlayEffects()
    -- Get Resources
    local sound_cast = "Hero_Omniknight.GuardianAngel"
	local particle_cast = "particles/units/heroes/hero_skywrath_mage/skywrath_mage_mystic_flare_ambient.vpcf"
    
    -- particles 1
    local effect_cast = ParticleManager:CreateParticle( 
            particle_cast, 
            PATTACH_WORLDORIGIN, 
            nil 
        )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, self:GetDuration(), 10 ) )
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