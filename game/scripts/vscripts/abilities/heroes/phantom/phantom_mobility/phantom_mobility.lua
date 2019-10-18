phantom_mobility = class({})

--------------------------------------------------------------------------------
-- Passive Modifier
function phantom_mobility:GetIntrinsicModifierName()
	return "modifier_generic_charges_two"
end

-----------------------------------------------------------
-- Ability Start
function phantom_mobility:OnCastPointEnd()
	local caster = self:GetCaster()
	self.origin = caster:GetOrigin()
	local point = self:GetCursorPosition()

	local direction = (point - self.origin):Normalized()
	local distance = self:GetSpecialValueFor("min_range")

    if caster:IsWalking() then
        direction = caster:GetDirection()
    end

    --Knockback
    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_generic_displacement", -- modifier name
        {
            x = direction.x,
            y = direction.y,
            r = distance,
            speed = 1800,
            peak = 30,
            colliding = 0,
            activity = ACT_DOTA_CAST_ABILITY_2,
            rate = 1.5,
        } -- kv
    )


    self:PlayEffectsOnCast()
end

function phantom_mobility:OnDisplacementEnd()
	local origin = self:GetCaster():GetOrigin()
    self:PlayEffectsOnDisplacementEnd( origin )
end

function phantom_mobility:PlayEffectsOnCast()
    local caster = self:GetCaster()
    -- Sound
    EmitSoundOn("Hero_PhantomAssassin.Strike.Start", caster)


end

function phantom_mobility:PlayEffectsOnDisplacementEnd( origin )
    -- Sound
    --EmitSoundOn( "Hero_PhantomAssassin.Strike.End", self:GetCaster())
    -- Play particle trail when moving
    local trail_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_juggernaut/juggernaut_omni_slash_trail.vpcf", PATTACH_ABSORIGIN, self:GetCaster())
    ParticleManager:SetParticleControl(trail_pfx, 0, self.origin)
    ParticleManager:SetParticleControl(trail_pfx, 1, origin )
    ParticleManager:ReleaseParticleIndex(trail_pfx)
end

if IsClient() then require("abilities") end
Abilities.Initialize( 
	phantom_mobility,
	{ activity = ACT_DOTA_CAST_ABILITY_1, rate = 2.0 },
	{ movement_speed = 100 }
)