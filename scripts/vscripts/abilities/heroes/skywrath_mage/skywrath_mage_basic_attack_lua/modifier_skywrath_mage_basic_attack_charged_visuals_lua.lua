modifier_skywrath_mage_basic_attack_charged_visuals_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_skywrath_mage_basic_attack_charged_visuals_lua:IsHidden()
	return false
end

function modifier_skywrath_mage_basic_attack_charged_visuals_lua:IsDebuff()
	return false
end

function modifier_skywrath_mage_basic_attack_charged_visuals_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_skywrath_mage_basic_attack_charged_visuals_lua:OnCreated( kv )
    if IsServer() then
        self:PlayEffects()
        self:PlayEffects2()
    end
end

--------------------------------------------------------------------------------
-- Destructor
function modifier_skywrath_mage_basic_attack_charged_visuals_lua:OnDestroy( kv )
    if IsServer() then
        self:StopEffects2()
    end
end

--------------------------------------------------------------------------------
-- Graphics & Animations

function modifier_skywrath_mage_basic_attack_charged_visuals_lua:PlayEffects()
	-- Get Resources
	local sound_cast = "Hero_Wisp.Spirits.Destroy"
	local particle_cast = "particles/mod_units/heroes/hero_wisp/wisp_death.vpcf"
    local origin = self:GetCaster():GetOrigin()

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster()  )

	-- Create Particles
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end


function modifier_skywrath_mage_basic_attack_charged_visuals_lua:GetEffectName()
	return "particles/econ/items/dark_willow/dark_willow_ti8_immortal_head/dw_crimson_ti8_immortal_ambient_embers_b.vpcf"
end

function modifier_skywrath_mage_basic_attack_charged_visuals_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_skywrath_mage_basic_attack_charged_visuals_lua:PlayEffects2()
    if IsServer() then
        -- Get Resources
        local particle_cast = "particles/mod_units/heroes/hero_wisp/wisp_overcharge_c.vpcf"
        local origin = self:GetParent():GetOrigin()
        
        self.effect_cast = ParticleManager:CreateParticle( 
            particle_cast, 
            PATTACH_CUSTOMORIGIN, 
            nil
        )

        ParticleManager:SetParticleControlEnt( 
            self.effect_cast, 
            0, 
            self:GetParent(), 
            PATTACH_POINT_FOLLOW, 
            "attach_attack1", 
            origin + Vector( 0, 0, 96 ), 
            true 
        )
    end
end

function modifier_skywrath_mage_basic_attack_charged_visuals_lua:StopEffects2()
    if IsServer() then
        ParticleManager:DestroyParticle( self.effect_cast, false )
        ParticleManager:ReleaseParticleIndex( self.effect_cast )
    end
end

