queen_daggers = class({})

function queen_daggers:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_1 end
function queen_daggers:GetPlaybackRateOverride()    return 0.8 end
function queen_daggers:GetCastPointSpeed() 			return 0 end

function queen_daggers:OnSpellStart()
    local caster = self:GetCaster()
    local origin = caster:GetAbsOrigin()
    local count = 16
    local angle_diff = 360/count
    local vector = origin + Vector(1, 0, 0)
    local queen_attack = caster:FindAbilityByName("queen_attack")
    local distance = queen_attack:GetCastRange(Vector(0,0,0), nil) * 2

    for i = 0, count - 1 do
        local location = RotatePosition(origin, QAngle(0, angle_diff * i, 0), vector)
        queen_attack:LaunchProjectile(location, 600, distance, 7)
    end

    EmitSoundOn("Hero_QueenOfPain.ShadowStrike", caster)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(queen_daggers)
