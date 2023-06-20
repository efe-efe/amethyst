modifier_nevermore_souls = class({})

IsHidden(){ return false }
IsDebuff(){ return false }
IsPurgable(){ return true }
RemoveOnDeath(){ return false }

OnCreated(){
    this.damage_per_stack = this.ability.GetSpecialValueFor("damage_per_stack")
	this.max_stacks = this.ability.GetSpecialValueFor("max_stacks")
	this.effects_cast_weapon = {}

	if(IsServer() ) {
	    this.SetStackCount(0)
    }
}

function modifier_nevermore_souls:OnStackCountChanged(iStackCount)
	if(IsServer() ) {
		if(this.GetStackCount() > this.max_stacks ) {
			this.SetStackCount(this.max_stacks)
			return
		}

		if(this.GetStackCount() <= 0 ) {
			this.StopEffects()
			return
		}

		if(this.GetStackCount() == this.max_stacks ) {
			this.StopEffects()
			this.PlayEffectsCharged()
		}
	}
}

function modifier_nevermore_souls:PlayEffectsCharged()
	this.CreateGlow(0)
	this.CreateGlow(1)
	this.CreateGlow(2)
}

function modifier_nevermore_souls:CreateGlow(index)
	const particle_cast = "particles/nevermore/nevermore_basic_attack_aura.vpcf"
	this.effects_cast_weapon[index] = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.ABSORIGIN_FOLLOW, this.caster)

	if(index == 0 ) {
		particle_cast = "particles/econ/items/lycan/ti9_immortal/lycan_ti9_immortal_howl_buff.vpcf"
		this.particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.ABSORIGIN_FOLLOW, this.caster)
	}
}

function modifier_nevermore_souls:StopEffects()
	for _,efx in pairs(this.effects_cast_weapon) do
		if(efx ~= undefined ) {
			ParticleManager.DestroyParticle(efx, false)
			ParticleManager.ReleaseParticleIndex(efx)
		}
	}

	if(this.particleId ) {
		ParticleManager.DestroyParticle(this.particleId, false)
		ParticleManager.ReleaseParticleIndex(this.particleId)
	}

	this.effects_cast_weapon = {}
}

DeclareFunctions(){
	return {
		ModifierFunction.PREATTACK_BONUS_DAMAGE
	}
}

GetModifierPreAttack_BonusDamage(){
    return this.damage_per_stack * this.GetStackCount()
}
