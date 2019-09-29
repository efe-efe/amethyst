mount = class({})
LinkLuaModifier( "modifier_mount", "abilities/heroes/common/mount/modifier_mount.lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function mount:OnCastPointEnd( point )
    local caster = self:GetCaster()
    EmitSoundOn("Courier.Spawn", caster)
    
    caster:AddNewModifier(
        caster,
        self,
        "modifier_mount",
        { }
    )

    -- Swap abilities back to be able to stop
    caster:SwapAbilities( 
		"mount",
		"charge",
		false,
		true
	)

    self:PlayEffectsOnCast()
    self:StopEffectsCasting()
end

function mount:OnStopPseudoCastPoint()
    self:StopEffectsCasting()
end

function mount:PlayEffectsOnCast()
    local effect_cast =  ParticleManager:CreateParticle( 
        "particles/units/heroes/hero_earth_spirit/espirit_geomagentic_grip_caster.vpcf",
        PATTACH_ABSORIGIN_FOLLOW, 
        self:GetCaster()
    )
    ParticleManager:SetParticleControl( effect_cast, 10, self:GetCaster():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

function mount:PlayEffectsCasting()
    local particle_cast = "particles/econ/items/silencer/silencer_ti6/silencer_last_word_status_ti6_ring_ember.vpcf"
    self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
end

function mount:StopEffectsCasting()
    if self.effect_cast ~= nil then
        ParticleManager:DestroyParticle( self.effect_cast, false )
        ParticleManager:ReleaseParticleIndex( self.effect_cast )
    end
end

if IsClient() then require("abilities") end
Abilities.Initialize( 
	mount,
	{ activity = ACT_DOTA_GENERIC_CHANNEL_1, rate = 1.5 },
	{ movement_speed = 0 }
)