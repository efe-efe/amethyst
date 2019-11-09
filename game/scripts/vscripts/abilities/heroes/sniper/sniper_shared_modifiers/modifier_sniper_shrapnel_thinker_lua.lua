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
        
        EmitSoundOn("Hero_Sniper.MKG_ShrapnelShatter", self:GetParent())
    end
end

function modifier_sniper_shrapnel_thinker_lua:OnDestroy()
    if IsServer() then
        
        StopSoundOn("Hero_Sniper.MKG_ShrapnelShatter", self:GetParent())
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
    local enemies = caster:FindUnitsInRadius( 
        self.thinker_origin, 
        self.radius, 
        DOTA_UNIT_TARGET_TEAM_ENEMY, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER
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
