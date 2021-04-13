queen_blink = class({})

function queen_blink:GetCastAnimationCustom() return ACT_DOTA_CAST_ABILITY_2 end
function queen_blink:GetPlaybackRateOverride() return 1.0 end
function queen_blink:GetCastPointSpeed() return 0 end

function queen_blink:OnAbilityPhaseStart()
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()
    local point = ClampPosition(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)
    local radius = 250--self:GetSpecialValueFor("radius")
    CreateTimedRadiusMarker(caster, point, radius, self:GetCastPoint(), 0.2, RADIUS_SCOPE_PUBLIC):FindModifierByName('radius_marker_thinker')
    CreateTimedRadiusMarker(caster, origin, radius, self:GetCastPoint(), 0.2, RADIUS_SCOPE_PUBLIC):FindModifierByName('radius_marker_thinker')

    return true
end

function queen_blink:OnSpellStart()
	local caster = self:GetCaster()
    local point = ClampPosition(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)

    self:Blink(point)
end

function queen_blink:Blink(vPosition)
	local caster = self:GetCaster()
    self:BeforeBlink()
    FindClearSpaceForUnit(caster, vPosition, true)
    self:AfterBlink()
    caster:StartGesture(ACT_DOTA_CAST_ABILITY_2_END)
end

function queen_blink:AoeEffect()
    local radius = 250--self:GetSpecialValueFor("radius")
	local caster = self:GetCaster()
    local origin = caster:GetOrigin()
    local damage_table = {
        attacker = caster,
        damage = 7,
        damage_type = DAMAGE_TYPE_PURE,
    }
    local silence_duration = 1.0

    ApplyCallbackForUnitsInArea(caster, origin, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)
        damage_table.victim = unit
        ApplyDamage(damage_table)
        unit:AddNewModifier(caster, self, 'modifier_generic_silence', { duration = silence_duration })
    end)
end

function queen_blink:BeforeBlink()
	local caster = self:GetCaster()
    local origin = caster:GetOrigin()
    EFX("particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_blink_start.vpcf", PATTACH_WORLDORIGIN, nil, {
        cp0 = origin,
        cp1 = caster:GetForwardVector(),
        cp4 = Vector(10, 1, 0),
        release = true,
    })
    EFX("particles/units/heroes/hero_queenofpain/queen_blink_shard_start.vpcf", PATTACH_WORLDORIGIN, nil, {
        cp0 = origin,
        cp2 = Vector(self.radius, 0, 0),
        release = true,
    })
    EmitSoundOn('Hero_QueenOfPain.Blink_out', caster)
    EmitSoundOn('Hero_QueenOfPain.Blink_out.Shard', caster)
    self:AoeEffect()
end

function queen_blink:AfterBlink()
	local caster = self:GetCaster()
    local origin = caster:GetOrigin()
    EmitSoundOn('Hero_QueenOfPain.Blink_in.Shard', caster)
    EmitSoundOn('Hero_QueenOfPain.Blink_in', caster)
    EFX("particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_blink_end.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster, {
        release = true,
    })
    EFX("particles/units/heroes/hero_queenofpain/queen_blink_shard_end.vpcf", PATTACH_WORLDORIGIN, nil, {
        cp0 = origin,
        cp2 = Vector(self.radius, 0, 0),
        release = true,
    })
    self:AoeEffect()
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(queen_blink)