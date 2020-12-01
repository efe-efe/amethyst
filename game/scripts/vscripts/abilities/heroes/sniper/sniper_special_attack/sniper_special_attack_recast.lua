sniper_special_attack_recast = class({})
LinkLuaModifier("modifier_sniper_shrapnel_thinker_custom", "abilities/heroes/sniper/sniper_shared_modifiers/modifier_sniper_shrapnel_thinker_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sniper_shrapnel_debuff", "abilities/heroes/sniper/sniper_shared_modifiers/modifier_sniper_shrapnel_debuff", LUA_MODIFIER_MOTION_NONE)

function sniper_special_attack_recast:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_1 end
function sniper_special_attack_recast:GetPlaybackRateOverride() 	return 1.5 end
function sniper_special_attack_recast:GetCastPointSpeed() 			return 10 end

function sniper_special_attack_recast:OnSpellStart()
	local caster = self:GetCaster()
	local point = ClampPosition(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)
	local duration = self:GetSpecialValueFor("duration")

	CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_sniper_shrapnel_thinker_custom", --modifierName
		{ duration = duration },
		Vector(point.x, point.y, caster:GetOrigin().z), --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)
	
	self:PlayEffects(point)

	if self:GetLevel() == 2 then
		caster:AddNewModifier(caster, self, "modifier_sniper_special_attack_recast_recast", { duration = 1.5 })
	end
end

function sniper_special_attack_recast:PlayEffects(point)
	EmitSoundOn("Hero_Sniper.ShrapnelShoot", self:GetCaster())

	local particle_cast = "particles/units/heroes/hero_sniper/sniper_shrapnel_launch.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		self:GetCaster():GetOrigin(), -- unknown
		false -- unknown, true
	)
	ParticleManager:SetParticleControl(effect_cast, 1, point + Vector(0, 0, 2000))
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(sniper_special_attack_recast)