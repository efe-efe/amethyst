nevermore_ultimate = class({})
LinkLuaModifier("modifier_nevermore_ultimate", "abilities/heroes/nevermore/nevermore_ultimate/modifier_nevermore_ultimate", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_ultimate_thinker", "abilities/heroes/nevermore/nevermore_ultimate/modifier_nevermore_ultimate_thinker", LUA_MODIFIER_MOTION_NONE)

GetAnimation(){		return GameActivity.DOTA_CAST_ABILITY_6 }
GetPlaybackRateOverride(){ 	    return 1.0 }
GetCastingCrawl(){ 			return 0 }

OnAbilityPhaseStart(){
	this.thinker = CreateModifierThinker(
		this.caster, --hCaster
		this, --hAbility
		"modifier_nevermore_ultimate_thinker", --modifierName
		{ duration = this.GetCastPoint() },
		this.caster.GetAbsOrigin(), --vOrigin
		this.caster.GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)

	const particle_cast = "particles/units/heroes/hero_nevermore/nevermore_wings.vpcf"
	this.particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.ABSORIGIN_FOLLOW, this.caster)
	EmitGlobalSound("Hero_Nevermore.ROS.Arcana.Cast")
	return true
}

OnAbilityPhaseInterrupted(){
	this.thinker:Destroy()
	
	ParticleManager.DestroyParticle(this.particleId, true)
	ParticleManager.ReleaseParticleIndex(this.particleId)
	StopGlobalSound("Hero_Nevermore.ROS.Arcana.Cast")
}

OnSpellStart(){
	
	const origin = this.caster.GetAbsOrigin()
	const duration = this.GetSpecialValueFor("slow_duration")
	const damage = this.GetSpecialValueFor("damage_per_soul")
	const radius = this.GetSpecialValueFor("radius")
	const base_damage = this.GetSpecialValueFor("base_damage")
	const damage_per_soul = this.GetSpecialValueFor("damage_per_soul") 

	const damage_table = {
		attacker = this.caster,
		damage_type = DamageTypes.PURE,
	}

	const modifier = this.caster.FindModifierByName('modifier_nevermore_souls')
	const souls = modifier:GetStackCount()
	modifier:SetStackCount(0)

	const lines = 5 + (souls * 3)
	damage_table.damage = (base_damage + (souls * damage_per_soul))/2

	const initial_angle_deg = this.caster.GetAnglesAsVector().y
	const delta_angle = 360/lines

	for i = 0, lines - 1 do
		const facing_angle_deg = initial_angle_deg + delta_angle * i
		if(facing_angle_deg>360 ) { facing_angle_deg = facing_angle_deg - 360 }
		const facing_angle = math.rad(facing_angle_deg)
		const facing_vector = Vector(math.cos(facing_angle), math.sin(facing_angle), 0):Normalized()
		const velocity = facing_vector * 1800

        const projectile = {
            EffectName = "particles/nevermore/nevermore_basic_attack.vpcf",
            vSpawnOrigin = this.caster.GetAbsOrigin() + Vector(0, 0, 80),
            fDistance = radius,
            Source = this.caster,
            vVelocity = velocity,
            UnitBehavior = PROJECTILES_NOTHING,
            TreeBehavior = PROJECTILES_NOTHING,
            WallBehavior = PROJECTILES_NOTHING,
            GroundBehavior = PROJECTILES_NOTHING,
			fGroundOffset = 0,
            UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and ! CustomEntitiesLegacy:Allies(_self.Source, unit) },
            OnFinish = function(_self, position)
               this.PlayEffectsOnFinish(position: Vector)
            },
        }
        ProjectilesManagerInstance:CreateProjectile(projectile)
	}

	ApplyCallbackForUnitsInArea(this.caster, origin, radius/2, DOTA_UNIT_TARGET_TEAM_ENEMY, function(enemy)
		damage_table.victim = enemy
		ApplyDamage(damage_table)
		EmitSoundOn("Hero_Spectre.Attack", enemy)
	})

	ApplyCallbackForUnitsInArea(this.caster, origin, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(enemy)
		damage_table.victim = enemy
		ApplyDamage(damage_table)
		EmitSoundOn("Hero_Spectre.Attack", enemy)
	})

	CreateRadiusMarker(this.caster, origin, radius/2, RADIUS_SCOPE_PUBLIC, 0.1)
	CreateRadiusMarker(this.caster, origin, radius, RADIUS_SCOPE_PUBLIC, 0.1)
	ScreenShake(origin, 100, 300, 0.45, 1000, 0, true)

	ParticleManager.ReleaseParticleIndex(this.particleId)
	this.PlayEffectsLines(lines)
}

function nevermore_ultimate:PlayEffectsLines(lines)
	
	EmitSoundOn("Hero_Nevermore.ROS.Arcana", this.caster)

	const particle_cast = "particles/units/heroes/hero_nevermore/nevermore_requiemofsouls.vpcf"
	const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.ABSORIGIN_FOLLOW, this.caster)
	ParticleManager.SetParticleControl(particleId, 1, Vector(lines, 0, 0))	-- Lines
	ParticleManager.SetParticleControlForward(particleId, 2, this.caster.GetForwardVector())		-- initial direction
	ParticleManager.ReleaseParticleIndex(particleId)
}

PlayEffectsOnFinish(position: Vector){
	const particle_cast = "particles/econ/items/shadow_fiend/sf_desolation/sf_base_attack_desolation_explosion.vpcf"
	const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.ABSORIGIN, this.caster)
	ParticleManager.SetParticleControl(particleId, 3, position)
	ParticleManager.ReleaseParticleIndex(particleId)
}

if(IsClient() ) { require("wrappers/abilities") }
Abilities.Castpoint(nevermore_ultimate)