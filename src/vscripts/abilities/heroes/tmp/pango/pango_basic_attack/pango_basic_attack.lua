pango_basic_attack = class({})
LinkLuaModifier("modifier_pango_basic_attack_stacks", "abilities/heroes/pango/pango_basic_attack/modifier_pango_basic_attack_stacks", LUA_MODIFIER_MOTION_NONE)

GetCastPoint(){
	if(IsServer() ) {
		return this.caster.GetAttackAnimationPoint()
	}
}

GetCooldown(level: number){
	if(IsServer() ) {
        const attacks_per_second = this.caster.GetAttacksPerSecond()
        const attack_speed = (1 / attacks_per_second)
		
		return super.GetCooldown(level) + attack_speed
	}
}

GetAnimation(){
	if(RandomInt(0, 3) == 0 ) {
		return GameActivity.DOTA_SPAWN
	} else {
		return GameActivity.DOTA_CAST_ABILITY_4_END
	}
}
GetPlaybackRateOverride(){ 	
	return 1.2 
}
GetCastingCrawl(){ 		return this.GetSpecialValueFor('cast_point_speed_pct') }

OnSpellStart(){
	
	const origin = this.caster.GetAbsOrigin()
	const point = ClampPosition(origin, CustomAbilitiesLegacy:GetCursorPosition(this), this.GetCastRange(Vector(0,0,0), undefined), this.GetCastRange(Vector(0,0,0), undefined))
	const attack_damage = this.caster.GetAttackDamage()

	this.radius = this.GetSpecialValueFor("radius")
	const mana_gain_pct = this.GetSpecialValueFor("mana_gain_pct")
	const direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()
	
	CustomEntitiesLegacy:MeeleAttack(this.caster, {
		vDirection = direction,
		vOrigin = origin, 
		fRadius = this.radius,
		bIsBasicAttack = true,
		iMaxTargets = 1,
		Callback = function(target)
			CustomEntitiesLegacy:AttackWithBaseDamage(this.caster, {
				target = target,
				hAbility = this,
			})

			this.TryProc(target)
			this.PlayEffectsOnImpact(target)

			if(! CustomEntitiesLegacy:IsObstacle(target) ) {
				if(CustomEntitiesLegacy:ProvidesMana(target) ) {
					CustomEntitiesLegacy:GiveManaAndEnergyPercent(this.caster, mana_gain_pct, true)
				}

				this.caster.AddNewModifier(this.caster, this, "modifier_pango_basic_attack_stacks", {})
			}
	
			this.PlayEffectsOnImpact(target)
		}
	})

	this.PlayEffectsOnMiss(point)
	MeeleEFX(this.caster, direction, this.radius, undefined)
}

function pango_basic_attack:TryProc(target)
	
	const stacks = CustomEntitiesLegacy:SafeGetModifierStacks(this.caster, "modifier_pango_basic_attack_stacks")
	if(stacks == 4 ) {
		CustomEntitiesLegacy:SafeDestroyModifier(this.caster, "modifier_pango_basic_attack_stacks")
		target.AddNewModifier(this.caster, this, "modifier_generic_silence", { duration = 1.0 })
		target.AddNewModifier(this.caster, this, "modifier_generic_fading_slow", { 
			duration = 1.0,
			maxSlowPct = 100 
		})
		EmitSoundOn("Hero_Pangolier.LuckyShot.Proc", target)
		
		const damage_table = {
			victim = target,
			attacker = this.caster,
			damage = 8,
			damage_type = DamageTypes.PHYSICAL,
		}
		ApplyDamage(damage_table)
	}
}

function pango_basic_attack:PlayEffectsOnImpact(target)
	EFX('particles/juggernaut/juggernaut_basic_attack_impact.vpcf', ParticleAttachment.ABSORIGIN, target, {
		release = true
	})

	EmitSoundOn("Hero_Pangolier.Attack.Impact", target)
}

function pango_basic_attack:PlayEffectsOnMiss(position: Vector)
	EmitSoundOnLocationWithCaster(position, "Hero_Pangolier.PreAttack", this.caster)
}

if(IsClient() ) { require("wrappers/abilities") }
Abilities.Castpoint(pango_basic_attack)