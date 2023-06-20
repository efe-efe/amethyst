vengeful_extra = class({})
vengeful_extra_ultimate = class({})
LinkLuaModifier("modifier_vengeful_extra_thinker", "abilities/heroes/vengeful/vengeful_extra/modifier_vengeful_extra_thinker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_vengeful_extra", "abilities/heroes/vengeful/vengeful_extra/modifier_vengeful_extra", LUA_MODIFIER_MOTION_NONE)

GetAnimation(){			return GameActivity.DOTA_CAST_ABILITY_2 }
GetPlaybackRateOverride(){ 	        return 1.0 }
GetCastingCrawl(){ 				return 0 }
GetCastPoint(){					    return 0.1 }
function vengeful_extra:GetBehavior()						return DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_POINT }
function vengeful_extra:GetAbilityTextureName()			    return this.GetName() }
GetCooldown(level: number){				    return 8 }
function vengeful_extra:GetCastRange(vLocation, target)	return 1200 }
function vengeful_extra:GetManaCost(iLevel)	                return 25 }

function vengeful_extra:IsMimicable()
    return true
}

OnSpellStart(){
	
	const point = ClampPosition(this.caster.GetAbsOrigin(), CustomAbilitiesLegacy:GetCursorPosition(this), this.GetCastRange(Vector(0,0,0), undefined), undefined)
	
    CreateModifierThinker(
		this.caster, --hCaster
		this, --hAbility
		"modifier_vengeful_extra_thinker", --modifierName
		{}, --paramTable
		point, --vOrigin
		this.caster.GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)
}

function MimicSpell(hAbility, hAbilityOriginal, iEnergyCost)
    for key,value in pairs(hAbilityOriginal) do
        hAbility[key] = hAbilityOriginal[key]
    }

    hAbility.IsMimicable = function() return false }
    hAbility.GetManaCost = function() return 0 }
    hAbility.GetEnergyCost = function() return iEnergyCost }
}

MimicSpell(vengeful_extra_ultimate, vengeful_extra, 25)

if(IsClient() ) { require("wrappers/abilities") }
Abilities.Castpoint(vengeful_extra)
Abilities.Castpoint(vengeful_extra_ultimate)