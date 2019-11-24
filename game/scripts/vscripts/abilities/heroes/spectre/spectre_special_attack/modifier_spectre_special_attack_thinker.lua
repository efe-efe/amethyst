modifier_spectre_special_attack_thinker = class({})
LinkLuaModifier( "modifier_spectre_special_attack_buff", "abilities/heroes/spectre/spectre_special_attack/modifier_spectre_special_attack_buff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Initializations
function modifier_spectre_special_attack_thinker:OnCreated( params )
    self.buff_duration = self:GetAbility():GetSpecialValueFor("buff_duration")
	self.radius = 100

    if IsServer() then
        self:StartIntervalThink( 0.05 )
        self:PlayEffects(params.spiral)
    end
end

function modifier_spectre_special_attack_thinker:OnDestroy()
    if IsServer() then
        self:StopEffects()
    end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_spectre_special_attack_thinker:OnIntervalThink()
    local allies = self:GetCaster():FindUnitsInRadius(
        self:GetParent():GetOrigin(), 
        self.radius, 
        DOTA_UNIT_TARGET_TEAM_FRIENDLY, 
        DOTA_UNIT_TARGET_HERO, 
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER
    )

    for _,ally in pairs(allies) do
        if ally == self:GetCaster() then
            ally:AddNewModifier(
                self:GetCaster(), 
                self:GetAbility(), 
                "modifier_spectre_special_attack_buff", 
                {duration =  self.buff_duration}
            )
        end
    end
end

function modifier_spectre_special_attack_thinker:PlayEffects(spiral)
    local pos = self:GetParent():GetOrigin()
    local particle_cast = "particles/econ/items/dazzle/dazzle_ti6/dazzle_ti6_shallow_grave_ground_steam.vpcf"
    self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( self.effect_cast, 0, pos )
    ParticleManager:SetParticleControl( self.effect_cast, 1, pos )
    
	particle_cast = "particles/econ/items/lifestealer/ls_ti9_immortal/ls_ti9_open_wounds_ground.vpcf"
	self.effect_cast_dark = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( self.effect_cast_dark, 0, pos )
    ParticleManager:SetParticleControl( self.effect_cast_dark, 5, pos )
    
    if spiral ~= nil then
        -- Get Resources
        particle_cast = "particles/econ/items/slark/slark_ti6_blade/slark_ti6_pounce_start_spiral.vpcf"
        local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
        ParticleManager:SetParticleControl( effect_cast, 0, pos )
        ParticleManager:SetParticleControl( effect_cast, 3, pos )
        ParticleManager:ReleaseParticleIndex( effect_cast )
    end
end


function modifier_spectre_special_attack_thinker:StopEffects()
    if self.effect_cast then
        ParticleManager:DestroyParticle(self.effect_cast, false)
        ParticleManager:ReleaseParticleIndex( self.effect_cast )
    end

    if self.effect_cast_dark then
        ParticleManager:DestroyParticle(self.effect_cast_dark, false)
        ParticleManager:ReleaseParticleIndex( self.effect_cast_dark )
    end
end