modifier_ancient_mobility_thinker = class({})
LinkLuaModifier( "modifier_ancient_mobility_buff", "abilities/heroes/ancient/ancient_mobility/modifier_ancient_mobility_buff", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ancient_mobility_debuff", "abilities/heroes/ancient/ancient_mobility/modifier_ancient_mobility_debuff", LUA_MODIFIER_MOTION_NONE )

function modifier_ancient_mobility_thinker:OnCreated()
    if IsServer() then
        self.duration = self:GetAbility():GetSpecialValueFor("duration")
        self.radius = self:GetAbility():GetSpecialValueFor("radius")
        self.delay_time = self:GetAbility():GetSpecialValueFor("delay_time")
        self.ms_swing_linger = self:GetAbility():GetSpecialValueFor("ms_swing_linger")
        self.initialized = false

        self:StartIntervalThink( self.delay_time )
    end
end

function modifier_ancient_mobility_thinker:OnDestroy()
    if IsServer() then
        self:StopEffects()
		UTIL_Remove( self:GetParent() )
	end
end

--------------------------------------------------------------------------------
function modifier_ancient_mobility_thinker:OnIntervalThink()
    local caster = self:GetCaster()
    if self.initialized == false then
        AddFOWViewer( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), self.radius, self.duration, false )
        self:PlayEffects()

        CreateModifierThinker(
            caster, --hCaster
            self:GetAbility(), --hAbility
            "modifier_thinker_indicator", --modifierName
            { 
                show_all = 1,
                radius = self.radius,
                delay_time = self.duration,
            }, --paramTable
            self:GetParent():GetOrigin(), --vOrigin
            caster:GetTeamNumber(), --nTeamNumber
            false --bPhantomBlocker
        )
    
        self.initialized = true
        self:StartIntervalThink( 0.1 )  
    end

    local units = caster:FindUnitsInRadius(
        self:GetParent():GetOrigin(), 
        self.radius, 
        DOTA_UNIT_TARGET_TEAM_BOTH, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER
    )

    for _,unit in pairs(units) do
        if caster:IsAlly(unit) then
            unit:AddNewModifier(caster, self:GetAbility(), "modifier_ancient_mobility_buff", { duration = self.ms_swing_linger })
        else
            unit:AddNewModifier(caster, self:GetAbility(), "modifier_ancient_mobility_debuff", { duration = self.ms_swing_linger })
        end
    end
end

function modifier_ancient_mobility_thinker:PlayEffects()
    EmitSoundOnLocationWithCaster(self:GetParent():GetOrigin(), "Hero_Ancient_Apparition.IceVortex.lp", self:GetCaster())
    local particle_cast = "particles/econ/items/ancient_apparition/ancient_apparation_ti8/ancient_ice_vortex_ti8.vpcf"
    
    self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    
    ParticleManager:SetParticleControl( self.effect_cast, 0, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( self.effect_cast, 5, Vector(self.radius,self.radius,self.radius) )
end

function modifier_ancient_mobility_thinker:StopEffects()
    StopSoundOn("Hero_Ancient_Apparition", nil)
    ParticleManager:DestroyParticle( self.effect_cast, false )
    ParticleManager:ReleaseParticleIndex( self.effect_cast )    
end

