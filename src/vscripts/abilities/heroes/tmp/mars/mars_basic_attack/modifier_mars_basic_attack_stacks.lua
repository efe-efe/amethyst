modifier_mars_basic_attack_stacks = class({})

IsHidden(){ return false }
IsDebuff(){ return false }
IsStunDebuff(){ return false }
IsPurgable(){ return true }

OnCreated(){
	if(IsServer() ) {
		this.effects_cast_weapon = {}
		this.SetStackCount(1)
	}
}

OnRefresh(){
	const max_stacks = this.ability.GetSpecialValueFor("max_stacks")

	if(IsServer() ) {
		if(this.GetStackCount() < max_stacks ) {
			this.effects_cast_weapon = {}
			this.IncrementStackCount()

			if(this.GetStackCount() == max_stacks ) {
				this.PlayEffectsCharged()
			}
		}
	}
}

OnDestroy(){
	if(IsServer() ) {
		this.StopEffects()
	}
}

function modifier_mars_basic_attack_stacks:PlayEffectsCharged()
	ReplenishEFX(this.parent)
	
	this.CreateGlow(0)
	this.CreateGlow(1)
	this.CreateGlow(2)
	this.CreateGlow(3)
	this.CreateGlow(4)
	this.CreateGlow(5)
}

function modifier_mars_basic_attack_stacks:CreateGlow(index)
	const particle_cast = "particles/units/heroes/hero_invoker_kid/invoker_kid_forge_spirit_ambient_fire.vpcf"
	const this.caster = this.parent
	const origin = this.caster.GetAbsOrigin()
	this.effects_cast_weapon[index] = ParticleManager.CreateParticle(
		particle_cast, 
		ParticleAttachment.ABSORIGIN_FOLLOW, 
		this.caster
	)
}

function modifier_mars_basic_attack_stacks:StopEffects()
	for _,efx in pairs(this.effects_cast_weapon) do
		if(efx ~= undefined ) {
			ParticleManager.DestroyParticle(efx, false)
			ParticleManager.ReleaseParticleIndex(efx)
		}
	}
}