modifier_mars_second_attack_displacement = class({})

OnCreated(params){
	if(IsServer() ) {
		this.fading_slow_duration = this.ability.GetSpecialValueFor("fading_slow_duration")
		this.fading_slow_pct = this.ability.GetSpecialValueFor("fading_slow_pct")
	}
}

OnDestroy(){
	if(IsServer() ) {
		this.parent.AddNewModifier(this.caster, this.ability, "modifier_generic_fading_slow", { 
			duration = this.fading_slow_duration,
			maxSlowPct = this.fading_slow_pct 
		})
    }
}

DeclareFunctions(){
	return {
		ModifierFunction.OVERRIDE_ANIMATION,
		ModifierFunction.OVERRIDE_ANIMATION_RATE,
	}
}

GetOverrideAnimation(){ 		return GameActivity.DOTA_FLAIL }
GetOverrideAnimationRate(){ 	return 1.0 }

CheckState(){
	return {
        [ModifierState.NO_HEALTH_BAR] = true,
		[ModifierState.NO_UNIT_COLLISION] = true,
	}
}


function modifier_mars_second_attack_displacement:OnCollide(params)
	if(IsServer() ) {
		if(params.type == UNIT_COLLISION ) {
			for _,unit in pairs(params.units) do
				if(unit:GetName() == "npc_dota_phantomassassin_gravestone" ) {
					this.Destroy()
				}
			}
		}

		if(params.type == WALL_COLLISION ) {
			this.Destroy()
		}
	}
}

function modifier_mars_second_attack_displacement:GetCollisionTargetFilter()
	return DOTA_UNIT_TARGET_ALL
}

if(IsClient() ) { require("wrappers/modifiers") }
Modifiers.Displacement(modifier_mars_second_attack_displacement)
Modifiers.Animation(modifier_mars_second_attack_displacement)