modifier_sniper_ex_mobility_thinker = class({})
LinkLuaModifier( "modifier_sniper_ex_mobility", "abilities/heroes/sniper/sniper_ex_mobility/modifier_sniper_ex_mobility", LUA_MODIFIER_MOTION_NONE )

function modifier_sniper_ex_mobility_thinker:OnCreated()
    if IsServer() then
        local thinker = self:GetParent()
        local delay = 0.1
        self.thinker_origin = thinker:GetOrigin()
        self.think_interval = self:GetAbility():GetSpecialValueFor("think_interval")
        self.duration = self:GetAbility():GetSpecialValueFor("duration")

        self.radius = self:GetAbility():GetSpecialValueFor("radius")
        self.damage_per_think = self:GetAbility():GetSpecialValueFor("damage_per_think")
        self.slow_linger = self:GetAbility():GetSpecialValueFor("slow_linger")
        self.base_damage = self:GetAbility():GetSpecialValueFor("base_damage")

        -- Create Sound
        local sound_cast = "Hero_Disruptor.ThunderStrike.Thunderator"
        EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), sound_cast, self:GetCaster() )

        CreateModifierThinker(
            self:GetCaster(), --hCaster
            self:GetAbility(), --hAbility
            "modifier_thinker_indicator", --modifierName
            { 
                show_all = 1,
                radius = self.radius,
                delay_time = self.duration,
            }, --paramTable
            self.thinker_origin, --vOrigin
            self:GetCaster():GetTeamNumber(), --nTeamNumber
            false --bPhantomBlocker
        )

        self:OnIntervalThink()
        self:StartIntervalThink( self.think_interval )
    end
end

function modifier_sniper_ex_mobility_thinker:OnDestroy()
    if IsServer() then
		UTIL_Remove( self:GetParent() )
	end
end

--------------------------------------------------------------------------------
function modifier_sniper_ex_mobility_thinker:OnIntervalThink()
    local caster = self:GetCaster()

    self:PlayEffects()
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
        enemy:AddNewModifier(
            caster, -- player source
            self:GetAbility(), -- ability source
            "modifier_sniper_ex_mobility", -- modifier name
            { duration = self.slow_linger } -- kv
        )
        
        local damage = {
            victim = enemy,
            attacker = caster,
            damage = self.damage_per_think,
            damage_type = DAMAGE_TYPE_PURE,
        }

        ApplyDamage( damage )
    end
end

function modifier_sniper_ex_mobility_thinker:PlayEffects()
    -- Cast Particles
    local particle_cast = "particles/econ/items/disruptor/disruptor_ti8_immortal_weapon/disruptor_ti8_immortal_thunder_strike_bolt.vpcf"
    
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )

    ParticleManager:SetParticleControl( effect_cast, 0, self.thinker_origin )
    ParticleManager:SetParticleControl( effect_cast, 2, self.thinker_origin )
    ParticleManager:ReleaseParticleIndex( effect_cast )    
end



