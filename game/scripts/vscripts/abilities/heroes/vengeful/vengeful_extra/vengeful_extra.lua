vengeful_extra = class({})
vengeful_extra_ultimate = class({})
LinkLuaModifier("modifier_vengeful_extra_thinker", "abilities/heroes/vengeful/vengeful_extra/modifier_vengeful_extra_thinker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_vengeful_extra", "abilities/heroes/vengeful/vengeful_extra/modifier_vengeful_extra", LUA_MODIFIER_MOTION_NONE)

function vengeful_extra:GetCastAnimationCustom()			return ACT_DOTA_CAST_ABILITY_2 end
function vengeful_extra:GetPlaybackRateOverride() 	        return 1.0 end
function vengeful_extra:GetCastPointSpeed() 				return 0 end
function vengeful_extra:GetCastPoint()					    return 0.1 end
function vengeful_extra:GetBehavior()						return DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_POINT end
function vengeful_extra:GetAbilityTextureName()			    return self:GetName() end
function vengeful_extra:GetCooldown(iLevel)				    return 8 end
function vengeful_extra:GetCastRange(vLocation, hTarget)	return 1200 end
function vengeful_extra:GetManaCost(iLevel)	                return 25 end

function vengeful_extra:IsMimicable()
    return true
end

function vengeful_extra:OnSpellStart()
	local caster = self:GetCaster()
	local point = ClampPosition(caster:GetAbsOrigin(), CustomAbilities:GetCursorPosition(self), self:GetCastRange(Vector(0,0,0), nil), nil)
	
    CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_vengeful_extra_thinker", --modifierName
		{}, --paramTable
		point, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)
end

function MimicSpell(hAbility, hAbilityOriginal, iEnergyCost)
    for key,value in pairs(hAbilityOriginal) do
        hAbility[key] = hAbilityOriginal[key]
    end

    hAbility.IsMimicable = function() return false end
    hAbility.GetManaCost = function() return 0 end
    hAbility.GetEnergyCost = function() return iEnergyCost end
end

MimicSpell(vengeful_extra_ultimate, vengeful_extra, 25)

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(vengeful_extra)
Abilities.Castpoint(vengeful_extra_ultimate)