modifier_spectre_extra = class({})

function modifier_spectre_extra:IsHidden() return false end
function modifier_spectre_extra:IsDebuff() return false end
function modifier_spectre_extra:IsPurgable() return false end

function modifier_spectre_extra:IsAura()
	return true
end
function modifier_spectre_extra:GetModifierAura()
	return "modifier_spectre_debuff"
end
function modifier_spectre_extra:GetAuraRadius()
	return self.radius
end
function modifier_spectre_extra:GetAuraDuration()
	return 0.0
end
function modifier_spectre_extra:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_BOTH
end
function modifier_spectre_extra:GetAuraEntityReject(hEntity)
    if self:GetCaster():IsAlly(hEntity) then
        return true 
    end
    return false
end
function modifier_spectre_extra:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_spectre_extra:OnCreated( kv )
    self.speed_buff_pct = self:GetAbility():GetSpecialValueFor("speed_buff_pct")
    self.radius = self:GetAbility():GetSpecialValueFor("radius")

    if IsServer() then
        self:PlayEffectsOnCreated()
    end
end

function modifier_spectre_extra:OnDestroy( kv )
    if IsServer() then
        self:GetAbility():StartCooldown(self:GetAbility():GetCooldown(self:GetAbility():GetLevel()))
        self:StopEffects()
    end
end

function modifier_spectre_extra:DeclareFunctions()
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
end

function modifier_spectre_extra:GetModifierMoveSpeedBonus_Percentage()
    return self.speed_buff_pct
end

function modifier_spectre_extra:PlayEffectsOnCreated( )
    local parent = self:GetParent()
    EmitSoundOn("Hero_Spectre.Haunt", parent)

	local particle_cast = "particles/econ/items/juggernaut/jugg_ti8_sword/juggernaut_blade_fury_abyssal.vpcf"
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, parent )
    ParticleManager:SetParticleControl( self.effect_cast, 2, parent:GetOrigin() )
    
    
    local particle_cast = "particles/econ/items/silencer/silencer_ti6/silencer_last_word_status_ti6_ring_mist.vpcf"
	self.effect_cast_ring = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, parent )
    ParticleManager:SetParticleControl( self.effect_cast_ring, 3, parent:GetOrigin() )
end

function modifier_spectre_extra:StopEffects()
    if self.effect_cast ~= nil then
        ParticleManager:DestroyParticle( self.effect_cast, false )
        ParticleManager:ReleaseParticleIndex( self.effect_cast )
    end
    if self.effect_cast_ring ~= nil then
        ParticleManager:DestroyParticle( self.effect_cast_ring, false )
        ParticleManager:ReleaseParticleIndex( self.effect_cast_ring )
    end
end

function modifier_spectre_extra:GetStatusLabel() return "Darkness" end
function modifier_spectre_extra:GetStatusPriority() return 1 end
function modifier_spectre_extra:GetStatusStyle() return "Darkness" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Status(modifier_spectre_extra)