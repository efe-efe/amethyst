modifier_ancient_mobility_thinker = class({})

function modifier_ancient_mobility_thinker:OnCreated()
    if IsServer() then
        self.radius = self:GetAbility():GetSpecialValueFor("radius")
        self.delay_time = self:GetAbility():GetSpecialValueFor("delay_time")
        self.duration = self:GetAbility():GetSpecialValueFor("duration")
        self:PlayEffects()
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
            caster:AddNewModifier(caster, self:GetAbility(), "modifier_generic_fading_haste", { duration = self.duration })
        else
            if unit:HasModifier("modifier_ancient_special_attack") then 
                unit:AddNewModifier(caster, self:GetAbility(), "modifier_generic_rooted_lua", { duration = self.duration })
                unit:RemoveModifierByName("modifier_ancient_special_attack")
            else
                unit:AddNewModifier(caster, self:GetAbility(), "modifier_generic_fading_slow", { duration = self.duration })
            end
        end
    end

    self:PlayEffectsTrigger()
    self:Destroy()
end

function modifier_ancient_mobility_thinker:PlayEffects()
    EmitSoundOnLocationWithCaster(self:GetParent():GetOrigin(), "Hero_Ancient_Apparition.IceVortex.lp", self:GetCaster())
    local particle_cast = "particles/units/heroes/hero_ancient_apparition/ancient_ice_vortex.vpcf"
    
    self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    
    ParticleManager:SetParticleControl( self.effect_cast, 0, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( self.effect_cast, 5, Vector(self.radius,self.radius,self.radius) )
end

function modifier_ancient_mobility_thinker:PlayEffectsTrigger()
    EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), "Hero_Ancient_Apparition.ChillingTouch.Target", self:GetParent() )

    local particle_cast = "particles/techies_blast_off_ringmodel.vpcf"

    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 1, self:GetParent():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )    
end


function modifier_ancient_mobility_thinker:StopEffects()
    StopSoundOn("Hero_Ancient_Apparition", nil)
    ParticleManager:DestroyParticle( self.effect_cast, false )
    ParticleManager:ReleaseParticleIndex( self.effect_cast )    
end
