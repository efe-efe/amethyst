phantom_mobility = class({})
LinkLuaModifier( "modifier_phantom_mobility_charges", "abilities/heroes/phantom/phantom_mobility/modifier_phantom_mobility_charges", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phantom_mobility_displacement", "abilities/heroes/phantom/phantom_mobility/modifier_phantom_mobility_displacement", LUA_MODIFIER_MOTION_BOTH )

function phantom_mobility:GetIntrinsicModifierName()
	return "modifier_phantom_mobility_charges"
end

function phantom_mobility:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	local point = self:GetCursorPosition()

	local direction = (point - origin):Normalized()
    local distance = self:GetCastRange(Vector(0,0,0), nil)

    if caster:GetDirection().x ~= 0 or caster:GetDirection().y ~=0 then
        direction = caster:GetDirection()
    end

    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_phantom_mobility_displacement", -- modifier name
        {
            x = direction.x,
            y = direction.y,
            r = distance,
            speed = distance/0.15,
            peak = 30,
        }
    )

    self:PlayEffectsOnCast()
end

function phantom_mobility:PlayEffectsOnCast()
    EmitSoundOn("Hero_PhantomAssassin.Strike.Start", self:GetCaster())

    local effect_cast = ParticleManager:CreateParticle("particles/blink_purple.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())

    ParticleManager:ReleaseParticleIndex(effect_cast)
end
