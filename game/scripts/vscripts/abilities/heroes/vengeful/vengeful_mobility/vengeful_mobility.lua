vengeful_mobility = class({})
LinkLuaModifier( "modifier_vengeful_mobility_illusion", "abilities/heroes/vengeful/vengeful_mobility/modifier_vengeful_mobility_illusion", LUA_MODIFIER_MOTION_NONE )

-----------------------------------------------------------
-- Ability Start
function vengeful_mobility:OnCastPointEnd()
	local caster = self:GetCaster()
	self.origin = caster:GetOrigin()
	local point = self:GetCursorPosition()
	local name = caster:GetUnitName()

    print(caster:GetLastAbility():GetName())
	local direction = (point - self.origin):Normalized()
	local distance = self:GetSpecialValueFor("min_range")

    if caster:IsWalking() then
        direction = caster:GetDirection()
    end
    
    local swap = caster:FindAbilityByName("vengeful_mobility_swap")
    swap.illusion_index = self:IllusionLogic():GetEntityIndex()
    
    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_generic_displacement", -- modifier name
        {
            x = direction.x,
            y = direction.y,
            r = distance,
            speed = 1800,
            peak = 80,
            colliding = 0,
            activity = ACT_DOTA_TELEPORT_END,
            rate = 1.0,
        } -- kv
    )

    caster:SwapAbilities( 
        "vengeful_mobility",
        "vengeful_mobility_swap",
        false,
        true
    )
    self:PlayEffectsOnCast()
end

function vengeful_mobility:OnDisplacementEnd()
	local origin = self:GetCaster():GetOrigin()
    self:PlayEffectsOnDisplacementEnd( origin )

end

function vengeful_mobility:IllusionLogic()
    local caster = self:GetCaster()
    local illusion_duration = self:GetSpecialValueFor("duration")

    local illusion = CreateIllusions( caster, caster, {
        duration = illusion_duration,
        outgoing_damage = -100, 
        incoming_damage = 0,
    }, 1, 0, false, true )


    --self:PlayEffectsIllusion( illusion[1] )
    illusion[1]:AddNewModifier(caster, self, "modifier_vengeful_mobility_illusion", {})


    return illusion[1]
end


-----------------------------------------------------------
-- Graphics and sounds
function vengeful_mobility:PlayEffectsOnCast()
    local caster = self:GetCaster()
    -- Sound
    EmitSoundOn("Hero_PhantomAssassin.Strike.Start", caster)
end

function vengeful_mobility:PlayEffectsOnDisplacementEnd( origin )
    -- Sound
    --EmitSoundOn( "Hero_PhantomAssassin.Strike.End", self:GetCaster())
    -- Play particle trail when moving
    local trail_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_juggernaut/juggernaut_omni_slash_trail.vpcf", PATTACH_ABSORIGIN, self:GetCaster())
    ParticleManager:SetParticleControl(trail_pfx, 0, self.origin)
    ParticleManager:SetParticleControl(trail_pfx, 1, origin )
    ParticleManager:ReleaseParticleIndex(trail_pfx)
end

function vengeful_mobility:PlayEffectsIllusion( hTarget )
    local particle_cast = "particles/units/heroes/hero_pugna/pugna_decrepify.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget)
    ParticleManager:SetParticleControl(effect_cast, 3, hTarget:GetOrigin())
    ParticleManager:ReleaseParticleIndex(effect_cast)
end

if IsClient() then require("abilities") end
Abilities.Initialize( 
	vengeful_mobility,
	{ activity = ACT_DOTA_CAST_ABILITY_1, rate = 2.0 },
	{ movement_speed = 100 }
)