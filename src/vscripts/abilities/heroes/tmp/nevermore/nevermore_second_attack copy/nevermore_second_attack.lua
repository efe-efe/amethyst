nevermore_second_attack = class({})
LinkLuaModifier("modifier_nevermore_second_attack_recast", "abilities/heroes/nevermore/nevermore_second_attack/modifier_nevermore_second_attack_recast", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_second_attack_recasts_counter", "abilities/heroes/nevermore/nevermore_second_attack/modifier_nevermore_second_attack_recasts_counter", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_second_attack_debuff", "abilities/heroes/nevermore/nevermore_second_attack/modifier_nevermore_second_attack_debuff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_second_attack_block_recast", "abilities/heroes/nevermore/nevermore_second_attack/modifier_nevermore_second_attack_block_recast", LUA_MODIFIER_MOTION_NONE)

GetAnimation(){		return GameActivity.DOTA_RAZE_2 }
GetPlaybackRateOverride(){ 		return 1.5 }
GetCastingCrawl(){ 			return 10 }

OnSpellStart(){
	
	const point = CustomAbilitiesLegacy:GetCursorPosition(this)
	const origin = this.caster.GetAbsOrigin()

	const projectile_speed = this.GetSpecialValueFor("projectile_speed")
	const projectile_direction = direction2D(origin, point)
    const mana_gain_pct = this.GetSpecialValueFor("mana_gain_pct")
	const radius = this.GetSpecialValueFor("radius")
	const damage = this.GetSpecialValueFor("ability_damage")
	const damage_per_stack = this.GetSpecialValueFor("damage_per_stack")
	const speed_per_stack = this.GetSpecialValueFor("speed_per_stack")
    const recast_duration = this.GetSpecialValueFor("recast_duration")


	const recasts_done = 0
	if(this.caster.HasModifier("modifier_nevermore_second_attack_recasts_counter") ) {
		recasts_done = this.GetSpecialValueFor("recasts") - this.caster.FindModifierByName("modifier_nevermore_second_attack_recasts_counter"):GetStackCount()
	}
	
	const projectile = {
		EffectName = "particles/nevermore/nevermore_second_attack.vpcf",
		vSpawnOrigin = origin + Vector(0, 0, 96),
		fDistance = this.GetSpecialValueFor("projectile_distance") ~= 0 and this.GetSpecialValueFor("projectile_distance") or this.GetCastRange(Vector(0,0,0), undefined),
		fStartRadius = this.GetSpecialValueFor("hitbox"),
		Source = this.caster,
		vVelocity = projectile_direction * (projectile_speed + (speed_per_stack * recasts_done)),
		UnitBehavior = PROJECTILES_DESTROY,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and ! CustomEntitiesLegacy:Allies(_self.Source, unit) },
		OnFinish = function(_self, position)
			const enemies = CustomEntitiesLegacy:FindUnitsInRadius(
				_self.Source,
				position, 
				radius, 
				DOTA_UNIT_TARGET_TEAM_ENEMY, 
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_ANY_ORDER
			)

			const damage_table = {
				attacker = _self.Source,
				damage_type = DamageTypes.PURE,
			}

			const should_recast = false
	
			for _,enemy in pairs(enemies) do
				if(! CustomEntitiesLegacy:IsObstacle(enemy) ) {
					should_recast = true
				}

				const debuff_stacks = 0
				if(enemy:HasModifier("modifier_nevermore_second_attack_debuff") ) {
					debuff_stacks = enemy:FindModifierByName("modifier_nevermore_second_attack_debuff"):GetStackCount()
				}

				damage_table.victim = enemy
				damage_table.damage = damage + debuff_stacks * damage_per_stack

				ApplyDamage(damage_table)

				enemy:AddNewModifier(_self.Source, this, "modifier_nevermore_second_attack_debuff", { duration = recast_duration })
			}
	
			if(_self.Source == this.caster ) {
				if(should_recast ) {
					if(! this.caster.HasModifier("modifier_nevermore_second_attack_block_recast") ) {
						const modifier = this.caster.FindModifierByName("modifier_nevermore_second_attack_recasts_counter")

						if(modifier == undefined ) {
							this.caster.AddNewModifier(this.caster, this, "modifier_nevermore_second_attack_recasts_counter", {})
						} else { 
							modifier:DecrementStackCount()
						}
						if(CustomEntitiesLegacy:ProvidesMana(unit) ) {
							CustomEntitiesLegacy:GiveManaAndEnergyPercent(this.caster, mana_gain_pct, true)
						}
					}
				} else {
					this.caster.RemoveModifierByName("modifier_nevermore_second_attack_recasts_counter")
				}
			}

			this.PlayEffectsRaze(position, radius)
		},
	}

	ProjectilesManagerInstance:CreateProjectile(projectile)
	this.PlayEffectsOnCast()
}

PlayEffectsOnCast(){
	EmitSoundOn("Hero_Nevermore.Attack", this.caster)
}

function nevermore_second_attack:PlayEffectsRaze(position, radius)
	
    EmitSoundOnLocationWithCaster(position, "Hero_Nevermore.Shadowraze", this.caster)
	
    const particle_cast = "particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf"
    const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.WORLDORIGIN, undefined)
    ParticleManager.SetParticleControl(particleId, 0, position)
    ParticleManager.SetParticleControl(particleId, 1, Vector(radius, 1, 1))
    ParticleManager.ReleaseParticleIndex(particleId)
}

if(IsClient() ) { require("wrappers/abilities") }
Abilities.Castpoint(nevermore_second_attack)