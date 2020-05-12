modifier_phantom_ex_basic_attack = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_phantom_ex_basic_attack:IsHidden() return false
end

function modifier_phantom_ex_basic_attack:IsDebuff() return false
end

function modifier_phantom_ex_basic_attack:IsStunDebuff()
	return false
end

function modifier_phantom_ex_basic_attack:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_phantom_ex_basic_attack:OnCreated( kv )
	-- references
    if IsServer() then
        
        local ability = self:GetParent():FindAbilityByName("phantom_basic_attack")

        self:GetParent():SwapAbilities(
            "phantom_basic_attack", 
            "phantom_basic_attack_related", 
            false, 
            not ability:IsHidden()
        )
        
        self:GetParent():AddStatusBar({
            label = "dancing daggers", modifier = self, priority = 2, stylename="DancingBlades"
        }) 
        self:PlayEffectsOnCast()
	end
end

function modifier_phantom_ex_basic_attack:OnDestroy( kv )
    if IsServer() then
        local ability = self:GetParent():FindAbilityByName("phantom_basic_attack_related")
        
        self:GetParent():SwapAbilities(
            "phantom_basic_attack", 
            "phantom_basic_attack_related", 
            not ability:IsHidden(),
            false
        )

        local particle_cast = "particles/econ/events/ti5/blink_dagger_end_sparkles_end_lvl2_ti5.vpcf"
        local origin = self:GetParent():GetOrigin()
        local effect_cast = ParticleManager:CreateParticle( 
            particle_cast, 
            PATTACH_CUSTOMORIGIN, 
            self:GetParent()
        )
    
        ParticleManager:SetParticleControlEnt( 
            effect_cast, 
            0, 
            self:GetParent(), 
            PATTACH_POINT_FOLLOW, 
            "attach_hitloc", 
            origin, 
            true 
        )
        ParticleManager:SetParticleControlEnt( 
            effect_cast, 
            1, 
            self:GetParent(), 
            PATTACH_POINT_FOLLOW, 
            "attach_hitloc", 
            origin, 
            true 
        )

        self:StopEffects()
	end
end

function modifier_phantom_ex_basic_attack:PlayEffectsOnCast()
    local particle_cast = "particles/econ/courier/courier_axolotl_ambient/courier_axolotl_ambient_lvl4_trail_steam.vpcf"
    local origin = self:GetParent():GetOrigin()

    self.effect_cast_sparks = ParticleManager:CreateParticle( 
        particle_cast, 
        PATTACH_CUSTOMORIGIN, 
        self:GetParent()
    )

    ParticleManager:SetParticleControlEnt( 
        self.effect_cast_sparks, 
        0, 
        self:GetParent(), 
        PATTACH_POINT_FOLLOW, 
        "attach_hitloc", 
        origin, 
        true 
    )
end

function modifier_phantom_ex_basic_attack:StopEffects()
    if self.effect_cast_sparks ~= nil then
        ParticleManager:DestroyParticle( self.effect_cast_sparks, false )
        ParticleManager:ReleaseParticleIndex( self.effect_cast_sparks )
    end
    
end
