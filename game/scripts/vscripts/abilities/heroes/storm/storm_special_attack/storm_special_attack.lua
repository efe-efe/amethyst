storm_special_attack = class({})
storm_ex_special_attack = class({})
LinkLuaModifier("modifier_storm_special_attack_thinker", "abilities/heroes/storm/storm_special_attack/modifier_storm_special_attack_thinker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_storm_special_attack_efx", "abilities/heroes/storm/storm_special_attack/modifier_storm_special_attack_efx", LUA_MODIFIER_MOTION_NONE)

LinkLuaModifier("modifier_storm_ex_special_attack_displacement", "abilities/heroes/storm/storm_special_attack/modifier_storm_ex_special_attack_displacement", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_storm_ex_special_attack", "abilities/heroes/storm/storm_special_attack/modifier_storm_ex_special_attack", LUA_MODIFIER_MOTION_NONE)

function storm_special_attack:GetCastAnimationCustom()		return ACT_DOTA_ATTACK end
function storm_special_attack:GetPlaybackRateOverride() 	    return 1.5 end
function storm_special_attack:GetCastPointSpeed() 			return 10 end
function storm_special_attack:GetAnimationTranslate() 		return "overload" end

function storm_special_attack:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	local point = self:GetCursorPosition()
	local point = Clamp(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)

	local damage = self:GetSpecialValueFor("ability_damage")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")

	CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_storm_special_attack_thinker", --modifierName
		{},
		point, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)

	self:PlayEffectsOnCast()
    EmitSoundOn('Hero_StormSpirit.ElectricVortexCast', caster)
end

function storm_special_attack:PlayEffectsOnFinish(pos)
	EmitSoundOnLocationWithCaster(pos, "Hero_StormSpirit.ProjectileImpact", caster)
	
	local particle_cast = "particles/units/heroes/hero_stormspirit/stormspirit_base_attack_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, pos)
	ParticleManager:SetParticleControl(effect_cast, 3, pos)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function storm_special_attack:PlayEffectsOnCast()
	EmitSoundOn("Hero_StormSpirit.Attack", self:GetCaster())
end

function storm_ex_special_attack:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_4 end
function storm_ex_special_attack:GetPlaybackRateOverride()      return 1.0 end
function storm_ex_special_attack:GetCastPointSpeed() 			return 0 end

function storm_ex_special_attack:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
    local min_range = self:GetSpecialValueFor("min_range")
    local speed = self:GetSpecialValueFor("speed")
	local point = Clamp(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), min_range)

	local direction = (point - origin):Normalized()
    local distance = (point - origin):Length2D()

    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_storm_ex_special_attack_displacement", -- modifier name
        {
            x = direction.x,
            y = direction.y,
            r = distance,
            speed = speed,
            peak = 1,
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
Abilities.Castpoint(storm_special_attack)
Abilities.Castpoint(storm_ex_special_attack)