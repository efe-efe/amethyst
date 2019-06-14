modifier_wisp_basic_attack_link_lua = class({})
LinkLuaModifier( "modifier_wisp_basic_attack_lua", "abilities/heroes/wisp/wisp_basic_attack_lua/modifier_wisp_basic_attack_lua", LUA_MODIFIER_MOTION_NONE )

function modifier_wisp_basic_attack_link_lua:OnCreated()
    local wisp = self:GetParent()
    local ally = self:GetCaster()

    if IsServer() then
        ally:AddNewModifier(
            wisp,
            self:GetAbility(),
            "modifier_wisp_basic_attack_lua",
            { duration = self:GetDuration() }
        )
    end

    self:PlayEffects(self:GetParent())
end

function modifier_wisp_basic_attack_link_lua:OnDestroy()
    self:StopEffects()
end

function modifier_wisp_basic_attack_link_lua:PlayEffects( hTarget )
    -- Get Resources
    if IsServer() then
        local particle_cast = "particles/econ/items/wisp/wisp_tether_ti7.vpcf"

        self.effect_cast = ParticleManager:CreateParticle( 
            particle_cast,
            PATTACH_CUSTOMORIGIN, 
            nil
        )

        local origin = self:GetCaster():GetOrigin()

        ParticleManager:SetParticleControlEnt( 
            self.effect_cast, 
            0, 
            self:GetCaster(), 
            PATTACH_POINT_FOLLOW, 
            "attach_hitloc", 
            self:GetCaster():GetOrigin() + Vector( 0, 0, 96 ), 
            true 
        );
        ParticleManager:SetParticleControlEnt( 
            self.effect_cast, 
            1, 
            hTarget, 
            PATTACH_POINT_FOLLOW, 
            "attach_attack1", 
            hTarget:GetOrigin(), 
            true 
        );
    end
end


function modifier_wisp_basic_attack_link_lua:StopEffects()
    if IsServer() then
        ParticleManager:DestroyParticle( self.effect_cast, false )
        ParticleManager:ReleaseParticleIndex( self.effect_cast )
    end
end