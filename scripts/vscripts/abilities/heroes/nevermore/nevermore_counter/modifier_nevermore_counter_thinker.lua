modifier_nevermore_counter_thinker = class({})
LinkLuaModifier( "modifier_nevermore_counter_debuff", "abilities/heroes/nevermore/nevermore_counter/modifier_nevermore_counter_debuff", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nevermore_souls", "abilities/heroes/nevermore/nevermore_shared_modifiers/modifier_nevermore_souls", LUA_MODIFIER_MOTION_NONE )

--Clasifications
--------------------------------------------------------------------------------
function modifier_nevermore_counter_thinker:IsHidden()
	return true
end

--Initializer
--------------------------------------------------------------------------------
function modifier_nevermore_counter_thinker:OnCreated( kv )
    self.armor_duration = self:GetAbility():GetSpecialValueFor( "armor_duration" )
    self.radius = 100--self:GetAbility():GetSpecialValueFor( "radius" )

    if IsServer() then

        -- Start Interval
        self:StartIntervalThink( 0.05 )        
    end
end

function modifier_nevermore_counter_thinker:OnDestroy()
	if IsServer() then
		UTIL_Remove( self:GetParent() )
	end
end

--On think
--------------------------------------------------------------------------------
function modifier_nevermore_counter_thinker:OnIntervalThink()
    --self:PlayEffects()
    local thinker = self:GetParent()
    local thinker_origin = thinker:GetOrigin()
    
    local ent = Entities:FindAllInSphere(thinker_origin, self.radius)

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
        enemy:AddNewModifier(
            self:GetCaster(),
            self:GetAbility(),
            "modifier_nevermore_counter_debuff",
            { duration = self.armor_duration }
        )
    end

    self.radius = self.radius + 100
end

function modifier_nevermore_counter_thinker:PlayEffects()
	local particle_cast = "particles/econ/events/darkmoon_2017/darkmoon_calldown_marker_ring.vpcf"
    
    -- particles 1
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 1 , 1 ) )
    ParticleManager:SetParticleControl( effect_cast, 2, Vector( 1, 1, 1 ) )
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
end