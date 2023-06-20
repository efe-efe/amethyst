nevermore_basic_attack = class({})
LinkLuaModifier("modifier_nevermore_souls", "abilities/heroes/nevermore/nevermore_shared_modifiers/modifier_nevermore_souls", LUA_MODIFIER_MOTION_NONE)

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

GetAnimation(){	return GameActivity.DOTA_ATTACK }
GetPlaybackRateOverride(){ 	return 1.5 }
GetCastingCrawl(){ 		return 10 }

GetIntrinsicModifierName(){
	return 'modifier_nevermore_souls'
}

OnSpellStart(){
	
	const point = CustomAbilitiesLegacy:GetCursorPosition(this)
	const origin = this.caster.GetAbsOrigin()

	const projectile_speed = this.GetSpecialValueFor("projectile_speed")
	const projectile_direction = direction2D(origin, point)

    const mana_gain_pct = this.GetSpecialValueFor("mana_gain_pct")

	const damage = this.caster.GetAverageTrueAttackDamage(this.caster)

	const projectile = {
		EffectName = "particles/nevermore/nevermore_basic_attack.vpcf",
		vSpawnOrigin = origin + Vector(0, 0, 96),
		fDistance = this.GetCastRange(Vector(0,0,0), undefined),
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
			const damage_table = {
				victim = unit,
				attacker = _self.Source,
				damage = damage,
				damage_type = DamageTypes.PHYSICAL,
				ability = this
			}
			ApplyDamage(damage_table)

			if(_self.Source == this.caster and ! CustomEntitiesLegacy:IsObstacle(unit) ) {
				if(CustomEntitiesLegacy:ProvidesMana(unit) ) {
					CustomEntitiesLegacy:GiveManaAndEnergyPercent(this.caster, mana_gain_pct, true)
				}

				if(! CustomEntitiesLegacy:IsGem(unit) ) {
					this.caster.FindModifierByName('modifier_nevermore_souls'):IncrementStackCount()
					this.PlayEffectsSoul(unit)
				}
			}

			CustomEntitiesLegacy:OnBasicAttackImpact(_self.Source, unit)
		},
		OnFinish = function(_self, position)
			this.PlayEffectsOnFinish(position: Vector)
		},
	}

	ProjectilesManagerInstance:CreateProjectile(projectile)
	this.PlayEffectsOnCast()
}

PlayEffectsOnCast(){
	EmitSoundOn("Hero_Nevermore.Attack", this.caster)
}

PlayEffectsOnFinish(position: Vector){
	

	EmitSoundOnLocationWithCaster(position, "Hero_Nevermore.ProjectileImpact", this.caster)

	const particle_cast = "particles/units/heroes/hero_nevermore/nevermore_base_attack_impact.vpcf"
	const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.ABSORIGIN, this.caster)
	ParticleManager.SetParticleControl(particleId, 1, position)
	ParticleManager.ReleaseParticleIndex(particleId)
}

PlayEffectsSoul(target){
	const info = {
		Target = this.caster,
		Source = target,
		EffectName = "particles/units/heroes/hero_nevermore/nevermore_necro_souls.vpcf",
		iMoveSpeed = 400,
		vSourceLoc= target.GetAbsOrigin(),                -- Optional
		bDodgeable = false,                                -- Optional
		bReplaceExisting = false,                         -- Optional
		flExpireTime = GameRules:GetGameTime() + 5,      -- Optional but recommended
		bProvidesVision = false,                           -- Optional
	}
	ProjectileManager:CreateTrackingProjectile(info)
}

if(IsClient() ) { require("wrappers/abilities") }
Abilities.Castpoint(nevermore_basic_attack)