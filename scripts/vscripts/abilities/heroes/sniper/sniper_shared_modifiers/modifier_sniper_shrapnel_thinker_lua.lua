modifier_sniper_shrapnel_thinker_lua = class({})
LinkLuaModifier( "modifier_sniper_shrapnel_debuff", "abilities/heroes/sniper/sniper_shared_modifiers/modifier_sniper_shrapnel_debuff", LUA_MODIFIER_MOTION_NONE )

function modifier_sniper_shrapnel_thinker_lua:OnCreated()
    if IsServer() then
        self.thinker_origin = self:GetParent():GetOrigin()
        self.think_interval = self:GetAbility():GetSpecialValueFor("think_interval")
        self.duration = self:GetAbility():GetSpecialValueFor("duration")

        self.radius = self:GetAbility():GetSpecialValueFor("radius")
        self.damage_per_think = self:GetAbility():GetSpecialValueFor("damage_per_think")
        self.slow_linger = self:GetAbility():GetSpecialValueFor("slow_linger")

        self.delay_time = self:GetAbility():GetSpecialValueFor("delay_time")

        self.initialized = false

        self:StartIntervalThink( self.delay_time )  
    end
end

function modifier_sniper_shrapnel_thinker_lua:OnDestroy()
    if IsServer() then
		ParticleManager:DestroyParticle( self.effect_cast, false )
        ParticleManager:ReleaseParticleIndex( self.effect_cast )    
		UTIL_Remove( self:GetParent() )
	end
end

--------------------------------------------------------------------------------
function modifier_sniper_shrapnel_thinker_lua:OnIntervalThink()
    local caster = self:GetCaster()

    if self.initialized == false then
        -- Start Interval
        AddFOWViewer( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), self.radius, self.duration, false )
        self:PlayEffects()
        self.initialized = true

        CreateModifierThinker(
            caster, --hCaster
            self:GetAbility(), --hAbility
            "modifier_thinker_indicator", --modifierName
            { 
                show_all = 1,
                radius = self.radius,
                delay_time = self.duration,
            }, --paramTable
            self.thinker_origin, --vOrigin
            caster:GetTeamNumber(), --nTeamNumber
            false --bPhantomBlocker
        )
    

        self:StartIntervalThink( self.think_interval )  
    end

    -- Find enemies
    local enemies = FindUnitsInRadius( 
        caster:GetTeamNumber(), -- int, your team number
        self.thinker_origin, -- point, center point
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
            attacker = caster,
            damage = self.damage_per_think,
            damage_type = DAMAGE_TYPE_PURE,
        }

        ApplyDamage( damage )
        
        enemy:AddNewModifier(
            caster,
            self:GetAbility(),
            "modifier_sniper_shrapnel_debuff",
            {duration = self.slow_linger}
        )
    end
end

function modifier_sniper_shrapnel_thinker_lua:PlayEffects()
    local particle_cast = "particles/mod_units/heroes/hero_sniper/sniper_shrapnel.vpcf"
    
    self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    
    ParticleManager:SetParticleControl( self.effect_cast, 0, self.thinker_origin )
    ParticleManager:SetParticleControl( self.effect_cast, 1, Vector(self.radius,0,0))
    ParticleManager:SetParticleControl( self.effect_cast, 2, self.thinker_origin )
end
