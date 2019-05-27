

modifier_skywrath_mage_basic_attack_charged_debuff_visuals_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_skywrath_mage_basic_attack_charged_debuff_visuals_lua:IsDebuff()
	return true
end

function modifier_skywrath_mage_basic_attack_charged_debuff_visuals_lua:IsHidden()
	return true
end

function modifier_skywrath_mage_basic_attack_charged_debuff_visuals_lua:IsStunDebuff()
	return false
end

function modifier_skywrath_mage_basic_attack_charged_debuff_visuals_lua:IsPurgable()
	return true
end


--------------------------------------------------------------------------------
-- Initializations
function modifier_skywrath_mage_basic_attack_charged_debuff_visuals_lua:OnCreated( kv )
    if IsServer() then
        self:PlayEffects()
    end
end

--------------------------------------------------------------------------
---- Destroyer
function modifier_skywrath_mage_basic_attack_charged_debuff_visuals_lua:OnDestroy( kv )
    if IsServer() then
        self:StopEffects()
    end
end


-- On activated
function modifier_skywrath_mage_basic_attack_charged_debuff_visuals_lua:PlayEffects()
    -- Get Resources
	local particle_cast = "particles/mod_units/heroes/hero_skywrath_mage/skywrath_mage_ancient_seal_debuff.vpcf"
    --local sound_cast = "Hero_SkywrathMage.ConcussiveShot.Target"
    -- Create Sound
    --EmitSoundOn(sound_cast, self:GetCaster())
    
    local origin = self:GetParent():GetOrigin()

    -- Create Particles
    self.effect_cast = ParticleManager:CreateParticle( 
        particle_cast, 
        PATTACH_CUSTOMORIGIN, 
        self:GetParent()
    )

    ParticleManager:SetParticleControlEnt( 
        self.effect_cast, 
        0, 
        self:GetParent(), 
        PATTACH_POINT_FOLLOW, 
        "follow_origin", 
        origin, 
        true 
    )
    ParticleManager:SetParticleControlEnt( 
        self.effect_cast, 
        1, 
        self:GetParent(), 
        PATTACH_POINT_FOLLOW, 
        "follow_origin", 
        origin, 
        true 
    )
end


function modifier_skywrath_mage_basic_attack_charged_debuff_visuals_lua:StopEffects()
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )
end
