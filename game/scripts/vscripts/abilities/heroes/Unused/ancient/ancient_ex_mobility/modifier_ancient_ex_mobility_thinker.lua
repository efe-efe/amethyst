modifier_ancient_ex_mobility_thinker = class({})
LinkLuaModifier( "modifier_ancient_ex_mobility", "abilities/heroes/ancient/ancient_ex_mobility/modifier_ancient_ex_mobility", LUA_MODIFIER_MOTION_NONE )

function modifier_ancient_ex_mobility_thinker:OnCreated()
    if IsServer() then
        self.radius = self:GetAbility():GetSpecialValueFor("radius")
        self.delay_time = self:GetAbility():GetSpecialValueFor("delay_time")
        self.ability_damage = self:GetAbility():GetSpecialValueFor("ability_damage")
        self.heal = self:GetAbility():GetSpecialValueFor("heal")
        self.think_interval = self:GetAbility():GetSpecialValueFor("think_interval")
        self.stun_duration = self:GetAbility():GetSpecialValueFor("stun_duration")

        self.ticks = 3 
        self.counter = 1
        
        CreateModifierThinker(
            self:GetCaster(), --hCaster
            self:GetAbility(), --hAbility
            "modifier_thinker_indicator", --modifierName
            { 
                show_all = 1,
                radius = self.radius,
                delay_time = self.think_interval * (self.ticks + 1),
            }, --paramTable
            self:GetParent():GetOrigin(), --vOrigin
            self:GetCaster():GetTeamNumber(), --nTeamNumber
            false --bPhantomBlocker
        )
        self:StartIntervalThink( self.think_interval )
        self:PlayEffects()
    end
end

function modifier_ancient_ex_mobility_thinker:OnDestroy()
    if IsServer() then
        self:StopEffects()
		UTIL_Remove( self:GetParent() )
	end
end

--------------------------------------------------------------------------------
function modifier_ancient_ex_mobility_thinker:OnIntervalThink()
    local caster = self:GetCaster()
    local units = caster:FindUnitsInRadius(
        self:GetParent():GetOrigin(), 
        self.radius, 
        DOTA_UNIT_TARGET_TEAM_BOTH, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER
    )

    local final_heal = self.heal
    local final_damage = self.ability_damage

    if self.counter == self.ticks then
        final_damage = final_damage * 2
        final_heal = final_heal * 2
        self:PlayEffectsLastTick()
    end

    for _,unit in pairs(units) do
        if caster:IsAlly(unit) then
            unit:Heal(final_heal, caster)
        else
            if self.counter == self.ticks then
                unit:AddNewModifier(caster, self:GetAbility() , "modifier_generic_stunned", { duration = self.stun_duration })
            end
            --if unit:HasModifier("modifier_ancient_special_attack") then 
                --unit:AddNewModifier(caster, self:GetAbility(), "modifier_generic_root", { duration = self.duration })
                --unit:RemoveModifierByName("modifier_ancient_special_attack")
            --else
                local damage_table = {
                    victim = unit,
                    attacker = caster,
                    damage = final_damage,
                    damage_type = DAMAGE_TYPE_PURE,
                }
    
                ApplyDamage( damage_table )
            --end
        end
        unit:AddNewModifier(caster, self:GetAbility(), "modifier_ancient_ex_mobility", { duration = self.think_interval })

    end

    self:PlayEffectsTrigger()
    if self.counter == self.ticks then
        self:Destroy()
        return
    end

    self.counter = self.counter + 1
end

function modifier_ancient_ex_mobility_thinker:PlayEffects()
    EmitSoundOnLocationWithCaster(self:GetParent():GetOrigin(), "Hero_Ancient_Apparition.IceVortex.lp", self:GetCaster())
    local particle_cast = "particles/econ/items/ancient_apparition/ancient_apparation_ti8/ancient_ice_vortex_ti8.vpcf"
    
    self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    
    ParticleManager:SetParticleControl( self.effect_cast, 0, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( self.effect_cast, 5, Vector(self.radius,self.radius,self.radius) )
end

function modifier_ancient_ex_mobility_thinker:PlayEffectsTrigger()
    EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), "Hero_Ancient_Apparition.ChillingTouch.Target", self:GetParent() )

    local particle_cast = "particles/techies_blast_off_ringmodel.vpcf"

    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 1, self:GetParent():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )    
end

function modifier_ancient_ex_mobility_thinker:PlayEffectsLastTick()
    EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), "Hero_Ancient_Apparition.IceVortex.TI8", self:GetParent() )
    local particle_cast = "particles/econ/items/ancient_apparition/aa_blast_ti_5/ancient_apparition_ice_blast_sphere_final_explosion_smoke_ti5.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )


    particle_cast = "particles/earthshaker_arcana_echoslam_start_v2_ring_rope.vpcf"
    effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
    
end

function modifier_ancient_ex_mobility_thinker:StopEffects()
    StopSoundOn("Hero_Ancient_Apparition", nil)
    ParticleManager:DestroyParticle( self.effect_cast, false )
    ParticleManager:ReleaseParticleIndex( self.effect_cast )    
end

