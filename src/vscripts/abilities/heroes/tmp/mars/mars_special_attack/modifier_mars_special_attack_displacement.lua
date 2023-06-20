modifier_mars_special_attack_displacement = class({})

OnCreated(params){
	if(IsServer() ) {
		this.extra_damage = this.ability.GetSpecialValueFor("extra_damage")
		this.debuff_duration = this.ability.GetSpecialValueFor("debuff_duration")
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

function modifier_mars_special_attack_displacement:OnCollide(params)
	if(IsServer() ) {
		const stun = false

		if(params.type == UNIT_COLLISION ) {
			for _,unit in pairs(params.units) do
				if(unit:GetName() == "npc_dota_phantomassassin_gravestone" ) {
					stun = true
					break
				}
			}
		}

		if(params.type == WALL_COLLISION or params.type == TREE_COLLISION ) {
			stun = true
		}

		if(stun ) {
			const damage_table = {
				victim = this.parent,
				attacker = this.caster,
				damage = this.extra_damage,
				damage_type = DamageTypes.MAGICAL,
			}
			ApplyDamage(damage_table)

			if(this.ability.GetLevel() >= 2 ) {
				this.parent.AddNewModifier(this.caster, this.ability, "modifier_generic_stunned", { duration = this.debuff_duration })
			} else { 
				this.parent.AddNewModifier(this.caster, this.ability, "modifier_generic_root", { duration = this.debuff_duration })
			}

			this.PlayEffectsOnImpact()
			this.Destroy()
		}
	}
}

function modifier_mars_special_attack_displacement:PlayEffectsOnImpact()
	const origin = this.parent.GetAbsOrigin()
	const particle_cast = "particles/units/heroes/hero_mars/mars_spear_impact.vpcf"
	const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.WORLDORIGIN, undefined)
   	ParticleManager.SetParticleControl(particleId, 0, Vector(origin.x, origin.y, origin.z - 64))
   	ParticleManager.SetParticleControl(particleId, 1, this.GetDirection() * 1000)
	ParticleManager.SetParticleControlForward(particleId, 0, this.GetDirection())
	ParticleManager.ReleaseParticleIndex(particleId)
}

function modifier_mars_special_attack_displacement:GetCollisionOffset()
	return 50
}

function modifier_mars_special_attack_displacement:GetCollisionTargetFilter()
	return DOTA_UNIT_TARGET_ALL
}

if(IsClient() ) { require("wrappers/modifiers") }
Modifiers.Displacement(modifier_mars_special_attack_displacement)
Modifiers.Animation(modifier_mars_special_attack_displacement)