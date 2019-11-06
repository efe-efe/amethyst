phantom_counter_mobility = class({})
LinkLuaModifier( "modifier_phantom_counter", "abilities/heroes/phantom/phantom_counter/modifier_phantom_counter", LUA_MODIFIER_MOTION_NONE )

function phantom_counter_mobility:HasPriority()
    return true
end

--------------------------------------------------------------------------------
-- Ability Start
function phantom_counter_mobility:OnCastPointEnd()
    local caster = self:GetCaster()
    local ability = caster:FindAbilityByName("phantom_counter")
    local radius = self:GetSpecialValueFor("radius")
    local heal = ability:GetSpecialValueFor("heal")
    local duration = ability:GetSpecialValueFor("duration")
	local point = CalcRange(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)

    SafeDestroyModifier("modifier_phantom_banish", caster, caster)
    FindClearSpaceForUnit( caster, point , true )

    CreateRadiusMarker(caster, caster:GetOrigin(), { 
        show_all = 1,
        radius = radius,
    })

    caster:Heal(heal, caster)
    caster:AddNewModifier(caster, ability, "modifier_phantom_counter", { duration = duration })

    self:PlayEffectsOnCast()
end

--------------------------------------------------------------------------------
-- Graphics & Sounds
function phantom_counter_mobility:PlayEffectsOnCast()
    -- Create Sound
    EmitSoundOn( "Hero_PhantomAssassin.Blur.Break", self:GetCaster()  )

    -- Create Particles
    local particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_end.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:SetParticleControl( effect_cast, 3, self:GetCaster():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

if IsClient() then require("abilities") end
Abilities.Initialize( 
    phantom_counter_mobility,
    nil, 
	{ movement_speed = 0, hide_indicator = 1, hide_castbar = 1 }
)