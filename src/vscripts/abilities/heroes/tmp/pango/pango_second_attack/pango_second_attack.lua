pango_second_attack = class({})
LinkLuaModifier("modifier_pango_second_attack_displacement", "abilities/heroes/pango/pango_second_attack/modifier_pango_second_attack_displacement", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_pango_second_attack_thinker", "abilities/heroes/pango/pango_second_attack/modifier_pango_second_attack_thinker", LUA_MODIFIER_MOTION_BOTH)

GetAnimation(){		return GameActivity.DOTA_TELEPORT_END } 
GetPlaybackRateOverride(){ 		return 2.0 }
GetCastingCrawl(){ 			return 80 }
function pango_second_attack:GetFadeGestureOnCast()			return false }

OnSpellStart(){
    
	const origin = this.caster.GetAbsOrigin()
	const point = CustomAbilitiesLegacy:GetCursorPosition(this)
    const distance = this.GetCastRange(Vector(0,0,0), undefined)
    const direction = (point - origin):Normalized()

    if(CustomEntitiesLegacy:GetDirection(this.caster).x ~= 0 or CustomEntitiesLegacy:GetDirection(this.caster).y ~=0 ) {
        this.Dash(CustomEntitiesLegacy:GetDirection(this.caster), distance)
    } else {
        this.Cut(origin, direction, distance)
    }
    EmitSoundOn("Hero_Pangolier.Swashbuckle.Cast", this.caster)
}

function pango_second_attack:Dash(vDirection, iDistance)
    

    this.caster.AddNewModifier(
        this.caster,
        this,
        "modifier_pango_second_attack_displacement",
        {
            x = vDirection.x,
            y = vDirection.y,
            r = iDistance,
            speed = iDistance/0.2,
            peak = 1,
        }
    )
}


function pango_second_attack:Cut(vOrigin, vDirection, iDistance)
    
    const point = vOrigin + (vDirection * iDistance)

    CreateModifierThinker(
        this.caster,
        this,
        "modifier_pango_second_attack_thinker",
        {
            x = point.x,
            y = point.y
        },
        vOrigin,
        this.caster.GetTeamNumber(),
        false
    )
}

if(IsClient() ) { require("wrappers/abilities") }
Abilities.Castpoint(pango_second_attack)