vengeful_basic_attack = class({})
LinkLuaModifier("modifier_vengeful_basic_attack", "abilities/heroes/vengeful/vengeful_basic_attack/modifier_vengeful_basic_attack", LUA_MODIFIER_MOTION_NONE)

GetCastPoint(){
	if(IsServer() ) {
		return super.GetCastPoint() + this.caster.GetAttackAnimationPoint()
	}
}

GetCooldown(level: number){
	if(IsServer() ) {
        const attacks_per_second = this.caster.GetAttacksPerSecond()
        const attack_speed = (1 / attacks_per_second)
		
		return super.GetCooldown(level) + attack_speed
	}
}

GetAnimation(){	    return GameActivity.DOTA_ATTACK }
GetPlaybackRateOverride(){    return 1.5 }
GetCastingCrawl(){ 		    return 10 }

OnSpellStart(){
	

	const stacks = CustomEntitiesLegacy:SafeGetModifierStacks(this.caster, "modifier_vengeful_basic_attack")
	if(stacks < 3 ) {
		this.ThrowProjectile()
	} else {
		const vengeful_second_attack = this.caster.FindAbilityByName("vengeful_second_attack")
		vengeful_second_attack:ThrowProjectile(true)
		CustomEntitiesLegacy:SafeDestroyModifier(this.caster, "modifier_vengeful_basic_attack")
	}

}

function vengeful_basic_attack:ThrowProjectile()
	
	const point = CustomAbilitiesLegacy:GetCursorPosition(this)
    const origin = this.caster.GetAbsOrigin()
	const projectile_speed = this.GetSpecialValueFor("projectile_speed")
	const projectile_direction = direction2D(origin, point)

    const mana_gain_pct = this.GetSpecialValueFor("mana_gain_pct")
	
	CustomEntitiesLegacy:ProjectileAttack(this.caster, {
		bIsBasicAttack = true,
		tProjectile = {
			EffectName = "particles/vengeful/vengeful_basic_attack.vpcf",
			vSpawnOrigin = origin + Vector(0, 0, 96),
			fDistance = this.GetSpecialValueFor("projectile_distance") ~= 0 and this.GetSpecialValueFor("projectile_distance") or this.GetCastRange(Vector(0,0,0), undefined),
			fStartRadius = this.GetSpecialValueFor("hitbox"),
			Source = this.caster,
			vVelocity = projectile_direction * projectile_speed,
			UnitBehavior = PROJECTILES_DESTROY,
			TreeBehavior = PROJECTILES_NOTHING,
			WallBehavior = PROJECTILES_DESTROY,
			GroundBehavior = PROJECTILES_NOTHING,
			fGroundOffset = 0,
			UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and ! CustomEntitiesLegacy:Allies(_self.Source, unit) },
			OnUnitHit = function(_self, unit) 
				CustomEntitiesLegacy:AttackWithBaseDamage(this.caster, {
					target = unit,
					hAbility = this,
				})

				if(_self.Source == this.caster and ! CustomEntitiesLegacy:IsObstacle(unit) ) {
					if(CustomEntitiesLegacy:ProvidesMana(unit) ) {
						CustomEntitiesLegacy:GiveManaAndEnergyPercent(this.caster, mana_gain_pct, true)
					}
					this.caster.AddNewModifier(this.caster, this, "modifier_vengeful_basic_attack", {})
				}
			},
			OnFinish = function(_self, position)
				this.PlayEffectsOnFinish(position: Vector)
			},
		}
	})

	this.PlayEffectsOnCast()
}

PlayEffectsOnCast(){
	EmitSoundOn("Hero_StormSpirit.Attack", this.caster)
}

PlayEffectsOnFinish(position: Vector){
	

	EmitSoundOnLocationWithCaster(position, "Hero_StormSpirit.ProjectileImpact", this.caster)

	const particle_cast = "particles/units/heroes/hero_stormspirit/stormspirit_base_attack_explosion.vpcf"
	const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.ABSORIGIN, this.caster)
	ParticleManager.SetParticleControl(particleId, 3, position)
	ParticleManager.ReleaseParticleIndex(particleId)
}

if(IsClient() ) { require("wrappers/abilities") }
Abilities.Castpoint(vengeful_basic_attack)

