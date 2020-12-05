sniper_mobility = class({})
LinkLuaModifier("modifier_sniper_shrapnel_thinker_custom", "abilities/heroes/sniper/sniper_shared_modifiers/modifier_sniper_shrapnel_thinker_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sniper_mobility_displacement", "abilities/heroes/sniper/sniper_mobility/modifier_sniper_mobility_displacement", LUA_MODIFIER_MOTION_BOTH)

function sniper_mobility:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_1 end
function sniper_mobility:GetPlaybackRateOverride() 	return 2.0 end

function sniper_mobility:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	local min_range = self:GetSpecialValueFor("min_range")
	local radius = self:GetSpecialValueFor("radius")
	local stun_duration = self:GetSpecialValueFor("stun_duration")
	local point = ClampPosition(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), min_range)
    local shrapnel = caster:FindAbilityByName("sniper_special_attack")

	local direction = (point - origin):Normalized()
	local distance = (point - origin):Length2D()

    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_sniper_mobility_displacement", -- modifier name
        {
            x = direction.x,
            y = direction.y,
            r = distance,
            speed = (distance/0.5),
			peak = 400,
        }
	)

	CreateModifierThinker(
		caster, --hCaster
		shrapnel, --hAbility
		"modifier_sniper_shrapnel_thinker_custom", --modifierName
		{ duration = shrapnel:GetSpecialValueFor("duration") }, --paramTable
		caster:GetAbsOrigin(), --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)

	if self:GetLevel() == 2 then
		caster:FindAbilityByName("sniper_second_attack"):EndCooldown()
	end

    self:PlayEffectsOnCast()
end

function sniper_mobility:PlayEffectsOnCast()
	EmitSoundOn("Hero_Techies.LandMine.Detonate", self:GetCaster())	

	local particle_cast = "particles/econ/courier/courier_cluckles/courier_cluckles_ambient_rocket_explosion.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect_cast, 0, self:GetCaster():GetOrigin())
    ParticleManager:SetParticleControl(effect_cast, 3, self:GetCaster():GetOrigin())
    ParticleManager:ReleaseParticleIndex(effect_cast)  
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(sniper_mobility)