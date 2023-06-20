mars_basic_attack = class({})
mars_ex_basic_attack = class({})

LinkLuaModifier("modifier_mars_basic_attack_stacks", "abilities/heroes/mars/mars_basic_attack/modifier_mars_basic_attack_stacks", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_mars_ex_basic_attack", "abilities/heroes/mars/mars_basic_attack/modifier_mars_ex_basic_attack", LUA_MODIFIER_MOTION_NONE)

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

GetAnimation(){	    return GameActivity.DOTA_ATTACK }
GetPlaybackRateOverride(){ 	return 2.0 }
GetCastingCrawl(){ 		    return this.GetSpecialValueFor('cast_point_speed_pct') }
function mars_basic_attack:GetAnimationTranslate() 		return "attack_close_range" }

OnSpellStart(){
	
	const origin = this.caster.GetAbsOrigin()
	const point = ClampPosition(origin, CustomAbilitiesLegacy:GetCursorPosition(this), this.GetCastRange(Vector(0,0,0), undefined), this.GetCastRange(Vector(0,0,0), undefined))
    const attack_damage = this.caster.GetAttackDamage()
    
	const radius = this.GetSpecialValueFor("radius")
	const mana_gain_pct = this.GetSpecialValueFor("mana_gain_pct")
	const direction = direction2D(origin, point)

	const enemies = CustomEntitiesLegacy:FindUnitsInCone(
		this.caster,
		direction, 
		0, 
		origin, 
		radius, 
		DOTA_UNIT_TARGET_TEAM_ENEMY, 
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
		DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_CLOSEST
	)

	for _,enemy in pairs(enemies) do 
		this.PlayEffectsOnImpact(enemy)

		const damage_table = {
			victim = enemy,
			attacker = this.caster,
			damage = attack_damage,
			damage_type = DamageTypes.PHYSICAL,
			activate_counters = 1,
		}
		ApplyDamage(damage_table)

		if(! CustomEntitiesLegacy:IsObstacle(enemy) ) {
			if(CustomEntitiesLegacy:ProvidesMana(enemy) ) {
				CustomEntitiesLegacy:GiveManaAndEnergyPercent(this.caster, mana_gain_pct, true)
			}

			this.caster.AddNewModifier(
				this.caster, -- player source
				this, -- ability source
				"modifier_mars_basic_attack_stacks", -- modifier name
				{} -- kv
			)
		}

		CustomEntitiesLegacy:OnBasicAttackImpact(this.caster, enemy)
		break
	}
    
    ExecuteOrderFromTable({ OrderType = DOTA_UNIT_ORDER_STOP, UnitIndex = this.caster.entindex() })
	this.PlayEffectsOnMiss(point)
	this.PlayEffectsOnFinish(point)
}

PlayEffectsOnFinish(position: Vector){
	
	const offset = 40
	const origin = this.caster.GetAbsOrigin()
	const direction = (position - origin):Normalized()
	const final_position = origin + Vector(direction.x * offset, direction.y * offset, 0)

	const particle_cast = "particles/meele_swing_red/pa_arcana_attack_blinkb_red.vpcf"
	const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.POINT, this.caster)
	ParticleManager.SetParticleControl(particleId, 0, final_position)
	ParticleManager.SetParticleControlForward(particleId, 0, direction)	
	ParticleManager.ReleaseParticleIndex(particleId)

	particle_cast = "particles/econ/items/juggernaut/jugg_ti8_sword/juggernaut_ti8_sword_crit_golden.vpcf"
	particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.POINT, this.caster)
	ParticleManager.ReleaseParticleIndex(particleId)
}

function mars_basic_attack:PlayEffectsOnImpact(target)
	EmitSoundOn("Hero_Juggernaut.Attack", target)
}

function mars_basic_attack:PlayEffectsOnMiss(position: Vector)
	EmitSoundOnLocationWithCaster(position, "Hero_Juggernaut.PreAttack", this.caster)
}


GetAnimation(){		return GameActivity.DOTA_TAUNT }
GetPlaybackRateOverride(){		return 1.0 }
GetCastingCrawl(){ 			return 10 }
function mars_ex_basic_attack:GetAnimationTranslate() 		return "ti10_taunt" }

OnSpellStart(){
	
	const heal = this.GetSpecialValueFor('heal')
	const duration = this.GetSpecialValueFor('duration')
	this.caster.Heal(heal, this.caster)
	this.caster.AddNewModifier(this.caster, this, 'modifier_mars_ex_basic_attack', { duration = duration })
	
	EmitSoundOn("DOTA_Item.Cheese.Activate", this.caster)
	EmitSoundOn("DOTA_Item.FaerieSpark.Activate", this.caster)
	EmitSoundOn("mars_mars_attack_20", this.caster)
	 
	EFX('particles/econ/taunts/bane/taunt_purple/bane_taunt_purple_food_end_left.vpcf', ParticleAttachment.ABSORIGIN_FOLLOW, this.caster, {release = true})
}

if(IsClient() ) { require("wrappers/abilities") }
Abilities.Castpoint(mars_basic_attack)
Abilities.Castpoint(mars_ex_basic_attack)