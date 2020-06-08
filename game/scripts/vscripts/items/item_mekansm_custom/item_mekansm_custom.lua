item_mekansm_custom = class({})
LinkLuaModifier("modifier_item_mekansm_custom", "items/item_mekansm_custom/modifier_item_mekansm_custom", LUA_MODIFIER_MOTION_NONE)

function item_mekansm_custom:OnAbilityPhaseStart()
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_casting", { 
		duration = self:GetCastPoint(), 
		movement_speed = 0,
	})
	self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_GENERIC_CHANNEL_1, 1.0)
    return true
end

function item_mekansm_custom:OnAbilityPhaseInterrupted()
	self:GetCaster():FadeGesture(ACT_DOTA_GENERIC_CHANNEL_1)
	self:GetCaster():RemoveModifierByName("modifier_casting")
end

function item_mekansm_custom:OnSpellStart()
	self:GetCaster():FadeGesture(ACT_DOTA_GENERIC_CHANNEL_1)
	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor("radius")
	local duration = self:GetSpecialValueFor("duration")
	local heal = self:GetSpecialValueFor("heal")
   
    local allies = caster:FindUnitsInRadius(
        caster:GetOrigin(), 
        radius, 
        DOTA_UNIT_TARGET_TEAM_FRIENDLY, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER
   )

    for _,ally in pairs(allies) do
        ally:AddNewModifier(caster, self, "modifier_item_mekansm_custom", { duration = duration })
        ally:Heal(heal, caster)
        self:PlayEffectsTarget(ally)
    end

    CreateRadiusMarker(caster, caster:GetOrigin(), { 
        show_all = 1,
        radius = radius,
    })
    
    self:PlayEffects()
end

function item_mekansm_custom:PlayEffects()
	EmitSoundOn("DOTA_Item.Mekansm.Activate", self:GetCaster())

    local particle_cast = "particles/items2_fx/mekanism.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:ReleaseParticleIndex(effect_cast)
end

function item_mekansm_custom:PlayEffectsTarget(hTarget)
	EmitSoundOn("DOTA_Item.Mekansm.Target", hTarget)

    local particle_cast = "particles/items2_fx/mekanism_recipient.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget)
    ParticleManager:SetParticleControl(effect_cast, 1, hTarget:GetOrigin())
    ParticleManager:ReleaseParticleIndex(effect_cast)
end
