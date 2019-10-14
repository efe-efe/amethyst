sniper_ultimate = class({})
LinkLuaModifier( "modifier_sniper_ultimate_timer", "abilities/heroes/sniper/sniper_ultimate/modifier_sniper_ultimate_timer", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function sniper_ultimate:OnSpellStart()
	self:PlayEffectsOnPhase()
end

function sniper_ultimate:OnCastPointEnd()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
	local projectile = caster:FindAbilityByName("sniper_ultimate_projectile")
    
    caster:AddNewModifier(
        caster, -- player source
		self, -- ability source
		"modifier_channeling", -- modifier name
		{ 
            duration = duration,
            style = "Ultimate",
            title = "ultimate",
            movement_speed = 0,
            channeling_tick = 0.45,
            immediate = 1,
        } -- kv
    )
    self:PlayEffectsOnCast()
end

function sniper_ultimate:OnChannelingTick()
    local caster = self:GetCaster()
    local ability = caster:FindAbilityByName("sniper_ultimate_projectile")
    caster:CastAbilityImmediately(ability, caster:GetEntityIndex())
end

function sniper_ultimate:OnChannelingEnd()
    self:PlayEffectsOnChannelingEnd()
end

function sniper_ultimate:OnStopPseudoCastPoint()
	self:StopEffectsOnPhase()
end

function sniper_ultimate:PlayEffectsOnChannelingEnd()
    local origin = self:GetCaster():GetOrigin()

    -- Cast Particlres
    local particle_cast_a = "particles/mod_units/heroes/hero_sniper/techies_base_attack_smokeburst.vpcf"
    local particle_cast_b  = "particles/mod_units/heroes/hero_sniper/techies_base_attack_explosion.vpcf"
    
    
    local effect_cast_a = ParticleManager:CreateParticle( 
        particle_cast_a, 
        PATTACH_CUSTOMORIGIN, 
        nil
    )

    local effect_cast_b = ParticleManager:CreateParticle( 
        particle_cast_b, 
        PATTACH_CUSTOMORIGIN, 
        nil
    )

    ParticleManager:SetParticleControlEnt( 
        effect_cast_a, 
        7, 
        self:GetCaster(), 
        PATTACH_POINT_FOLLOW, 
        "attach_attack1", 
        origin + Vector( 0, 0, 96 ), 
        true 
    )

    ParticleManager:SetParticleControlEnt( 
        effect_cast_b, 
        0, 
        self:GetCaster(), 
        PATTACH_POINT_FOLLOW, 
        "attach_attack1", 
        origin + Vector( 0, 0, 96 ), 
        true 
    )

    ParticleManager:SetParticleControlEnt( 
        effect_cast_b, 
        3, 
        self:GetCaster(), 
        PATTACH_POINT_FOLLOW, 
        "attach_attack1", 
        origin + Vector( 0, 0, 96 ), 
        true 
    )
    
    ParticleManager:ReleaseParticleIndex( effect_cast_a )
    ParticleManager:ReleaseParticleIndex( effect_cast_b )
end

function sniper_ultimate:PlayEffectsOnPhase()
    EmitGlobalSound( "sniper_snip_ability_assass_02")
end

function sniper_ultimate:StopEffectsOnPhase()
    StopGlobalSound( "sniper_snip_ability_assass_02" )
end

function sniper_ultimate:PlayEffectsOnCast()
    local sound_cast = "sniper_snip_laugh_08"
    EmitGlobalSound( sound_cast)
end

if IsClient() then require("abilities") end
Abilities.Initialize( 
	sniper_ultimate,
	{ activity = ACT_DOTA_CAST_ABILITY_1, rate = 1.5 },
	{ movement_speed = 0}
)