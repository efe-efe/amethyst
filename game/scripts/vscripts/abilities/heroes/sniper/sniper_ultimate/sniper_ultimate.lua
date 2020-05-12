sniper_ultimate = class({})
LinkLuaModifier("modifier_sniper_ultimate_channeling", "abilities/heroes/sniper/sniper_ultimate/modifier_sniper_ultimate_channeling", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sniper_ultimate_displacement", "abilities/heroes/sniper/sniper_ultimate/modifier_sniper_ultimate_displacement", LUA_MODIFIER_MOTION_BOTH)

function sniper_ultimate:GetCastPoint()
	return self:GetSpecialValueFor("cast_point")
end

function sniper_ultimate:OnAbilityPhaseStart()
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_casting", { 
		duration = self:GetCastPoint(), 
		movement_speed = 0,
	})
	self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 2.5)


    self:PlayEffectsOnPhase()
    return true
end

function sniper_ultimate:OnAbilityPhaseInterrupted()
	self:GetCaster():FadeGesture(ACT_DOTA_CAST_ABILITY_1)
    self:GetCaster():RemoveModifierByName("modifier_casting")
    
    self:StopEffectsOnPhase()
end

function sniper_ultimate:OnSpellStart()
    self:GetCaster():RemoveModifierByName("modifier_casting")
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
    
    caster:AddNewModifier(
        caster, 
        self, 
        "modifier_sniper_ultimate_channeling", 
        { duration = duration }
    ) 
    self:PlayEffectsOnCast()
end

function sniper_ultimate:OnChannelingTick()
    local caster = self:GetCaster()
    local ability = caster:FindAbilityByName("sniper_ultimate_projectile")
    caster:CastAbilityImmediately(ability, caster:GetEntityIndex())
end

function sniper_ultimate:PlayEffectsOnPhase()
    EmitGlobalSound("sniper_snip_ability_assass_02")
end

function sniper_ultimate:StopEffectsOnPhase()
    StopGlobalSound("sniper_snip_ability_assass_02")
end

function sniper_ultimate:PlayEffectsOnCast()
    EmitGlobalSound("sniper_snip_laugh_08")
end