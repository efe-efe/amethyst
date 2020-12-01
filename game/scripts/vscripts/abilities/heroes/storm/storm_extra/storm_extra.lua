storm_extra = class({})
LinkLuaModifier("modifier_storm_extra_displacement", "abilities/heroes/storm/storm_extra/modifier_storm_extra_displacement", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_storm_extra", "abilities/heroes/storm/storm_extra/modifier_storm_extra", LUA_MODIFIER_MOTION_NONE)

function storm_extra:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_4 end
function storm_extra:GetPlaybackRateOverride()      return 1.0 end
function storm_extra:GetCastPointSpeed() 			return 0 end

function storm_extra:OnAbilityPhaseStart()
    if self:GetCaster():HasModifier('modifier_storm_extra_displacement') then
        return false
    end

    return true
end

function storm_extra:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
    local min_range = self:GetSpecialValueFor("min_range")
    local speed = self:GetSpecialValueFor("speed")
	local point = ClampPosition(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), min_range)

	local direction = (point - origin):Normalized()
    local distance = (point - origin):Length2D()
    local level = 0

    if caster:HasModifier('modifier_storm_ex_basic_attack') then
        local modifier = caster:FindModifierByName('modifier_storm_ex_basic_attack')
        level = modifier:GetLevel()
    end

    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_storm_extra_displacement", -- modifier name
        {
            x = direction.x,
            y = direction.y,
            r = distance,
            speed = speed,
            peak = 1,
            level = level
        }
    )

    local random_number = RandomInt(1, 32)
    local sound_name = 'stormspirit_ss_ability_lightning_'
    if random_number < 10 then
        sound_name = sound_name .. '0' .. random_number
    else 
        sound_name = sound_name ..random_number 
    end
    EmitSoundOn(sound_name, caster)
    self:EndCooldown()
end


if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(storm_extra)