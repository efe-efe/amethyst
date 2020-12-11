storm_mobility = class({})
storm_ex_mobility = class({})

LinkLuaModifier("modifier_storm_mobility_thinker", "abilities/heroes/storm/storm_mobility/modifier_storm_mobility_thinker", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_storm_ex_mobility_thinker", "abilities/heroes/storm/storm_mobility/modifier_storm_ex_mobility_thinker", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_storm_mobility_charges", "abilities/heroes/storm/storm_mobility/modifier_storm_mobility_charges", LUA_MODIFIER_MOTION_BOTH)

function storm_mobility:GetIntrinsicModifierName()
	return "modifier_storm_mobility_charges"
end

function storm_mobility:GetCastAnimationCustom()		return ACT_DOTA_SPAWN end
function storm_mobility:GetPlaybackRateOverride()       return 1.5 end
function storm_mobility:GetCastPointSpeed() 			return 50 end

function storm_mobility:GetCastPoint()
    if self:GetCaster():HasModifier('modifier_storm_extra_displacement') then
        return 0.0
    end

    return self.BaseClass.GetCastPoint(self)
end

function storm_mobility:OnSpellStart()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
    local origin = caster:GetAbsOrigin()
    local groundPosition = GetGroundPosition(origin, caster)
    
    local thinker = CreateModifierThinker(
        caster, --hCaster
        self, --hAbility
        "modifier_storm_mobility_thinker", --modifierName
        { duration = duration },
        groundPosition,
        caster:GetTeamNumber(), --nTeamNumber
        true --bPhantomBlocker
    )
    
    EmitSoundOn("Hero_StormSpirit.StaticRemnantPlant", caster)
    LinkAbilityCooldowns(caster, 'storm_ex_mobility')
end


function storm_ex_mobility:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_1 end
function storm_ex_mobility:GetPlaybackRateOverride()       return 1.0 end
function storm_ex_mobility:GetCastPointSpeed() 			return 10 end

function storm_ex_mobility:OnSpellStart()
    local caster = self:GetCaster()
    local origin = caster:GetAbsOrigin()
    local duration = self:GetSpecialValueFor("duration")
    local point = ClampPosition(caster:GetAbsOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)

    local thinker = CreateModifierThinker(
        caster, --hCaster
        self, --hAbility
        "modifier_storm_ex_mobility_thinker", --modifierName
        { duration = duration },
        point, --vOrigin
        caster:GetTeamNumber(), --nTeamNumber
        true --bPhantomBlocker
    )      

    
	local efx = EFX("particles/storm/storm_ex_mobility_launch.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster, {
		cp1 = point + Vector(0, 0, 2000)
	})
	ParticleManager:SetParticleControlEnt(
		efx,
		0,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		origin, -- unknown
		false -- unknown, true
	)

    EmitSoundOn("Hero_StormSpirit.StaticRemnantPlant", caster)
    LinkAbilityCooldowns(caster, 'storm_mobility')
end


if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(storm_mobility)
Abilities.Castpoint(storm_ex_mobility)