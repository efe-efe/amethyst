phantom_mobility = class({})
LinkLuaModifier("modifier_phantom_mobility_charges", "abilities/heroes/phantom/phantom_mobility/modifier_phantom_mobility_charges", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phantom_mobility_displacement", "abilities/heroes/phantom/phantom_mobility/modifier_phantom_mobility_displacement", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_phantom_mobility_debuff", "abilities/heroes/phantom/phantom_mobility/modifier_phantom_mobility_debuff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phantom_mobility_shield", "abilities/heroes/phantom/phantom_mobility/modifier_phantom_mobility_shield", LUA_MODIFIER_MOTION_NONE)

function phantom_mobility:GetIntrinsicModifierName()
	return "modifier_phantom_mobility_charges"
end

function phantom_mobility:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	local point = CustomAbilitiesLegacy:GetCursorPosition(self)
	local direction = (point - origin):Normalized()
    local distance = self:GetCastRange(Vector(0,0,0), caster) + caster:GetCastRangeBonus()
    local caster_direction = CustomEntitiesLegacy:GetDirection(caster)

    if caster_direction.x ~= 0 or caster_direction.y ~=0 then
        direction = caster_direction
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

    caster:FindAbilityByName("phantom_basic_attack"):TryThrowKnives("modifier_upgrade_phantom_dash_damage")
    self:PlayEffectsOnCast()
end

function phantom_mobility:PlayEffectsOnCast()
    EmitSoundOn("Hero_PhantomAssassin.Strike.Start", self:GetCaster())

    local effect_cast = ParticleManager:CreateParticle("particles/blink_purple.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())

    ParticleManager:ReleaseParticleIndex(effect_cast)
end
