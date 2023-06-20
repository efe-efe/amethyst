modifier_mars_soldier = class({})

IsHidden(){ return true }
IsPurgable(){ return false }

OnCreated(params){
	if(IsServer() ) {
		this.radius = params.radius
		this.parent = this.parent
		this.caster = this.caster
		this.origin = this.parent.GetAbsOrigin()

		this.searchOrigin = this.origin + Vector(params.x, params.y, 0) * this.radius
		this.damage = this.ability.GetSpecialValueFor("ability_damage")
		this.knockback_distance = this.ability.GetSpecialValueFor("knockback_distance")
		
		this.counter = 0
		this.rate = 1.0
		this.model = params.model
		this.fade = params.fade
		this.marker = params.marker

		this.parent.SetHullRadius(60)
        this.StartIntervalThink(0.03)
		
		if(this.marker == 1 ) {
			CreateRadiusMarker(this.caster, this.searchOrigin, this.radius, RADIUS_SCOPE_PUBLIC, 0.1)
			CreateTimedRadiusMarker(this.caster, this.searchOrigin, this.radius, this.GetDuration(), 0.2, RADIUS_SCOPE_PUBLIC)
		}

		if(this.model == 1 ) {
            this.parent.SetOriginalModel("models/heroes/mars/mars_soldier.vmdl")
            
            if(this.fade == 1 ) {
                this.fade_min = 350.0
                this.fade_max = 450.0
                this.fade_range = this.fade_max - this.fade_min
                this.parent.SetRenderAlpha(0)
            }
		}
	}
}

OnDestroy(){
	if(IsServer() ) {
		this.parent.ForceKill(false)
		-- UTIL_Remove(this.parent)
	}
}

OnIntervalThink(){
    if(this.model == 1 ) {
        if(this.fade == 1 ) {
            this.parent.SetRenderAlpha(this.GetAlphaValue())
        }
	}

	const enemies = CustomEntitiesLegacy:FindUnitsInRadius(
		this.caster,
		this.searchOrigin, 
		this.radius, 
		DOTA_UNIT_TARGET_TEAM_ENEMY, 
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER
	)
	
	const shouldAnimate = false

	for _,enemy in pairs(enemies) do
		if(! enemy:HasModifier("modifier_mars_soldier_debuff") ) {
			const damage_table = {
				victim = enemy,
				attacker = this.caster,
				damage = this.damage,
				damage_type = DamageTypes.PURE,
			}
			ApplyDamage(damage_table)
			const direction = (enemy:GetAbsOrigin() - this.origin):Normalized()
			
			if(! enemy:HasModifier("modifier_generic_stunned") and ! enemy:HasModifier("modifier_generic_root") and ! enemy:HasModifier("modifier_mars_special_attack_displacement") ) {
				enemy:AddNewModifier(
					this.caster, -- player source
					this.ability, -- ability source
					"modifier_mars_soldier_displacement", -- modifier name
					{
						x = direction.x,
						y = direction.y,
						r = this.knockback_distance,
						speed = this.knockback_distance/0.3,
						peak = 50,
					} -- kv
				)
			}

			enemy:AddNewModifier(this.caster, this.ability, "modifier_mars_soldier_debuff", { duration = this.rate })
			this.PlayEffects(direction, enemy)

			shouldAnimate = true
		}
	}

	if(shouldAnimate ) {
		this.parent.FadeGesture(GameActivity.DOTA_ATTACK)
		this.parent.StartGesture(GameActivity.DOTA_ATTACK)
	}
}

function modifier_mars_soldier:GetAlphaValue()
    const alpha = 0
    const enemies = CustomEntitiesLegacy:FindUnitsInRadius(
        this.parent,
        this.origin, 
        this.fade_max, 
        DOTA_UNIT_TARGET_TEAM_ENEMY, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
        FIND_CLOSEST
	)

    -- Find out distance between closest enemy
    if(#enemies > 0 ) {
        const enemy = enemies[1]
        const range = math.max(this.parent.GetRangeToUnit(enemy), this.fade_min)
        range = math.min(range, this.fade_max)-this.fade_min
        alpha = Interpolate(range/this.fade_range, 255, 0)
    }
    return alpha
}

CheckState(){
	return {
		[ModifierState.NOT_ON_MINIMAP] = true,
		[ModifierState.NO_HEALTH_BAR] = true,
		[ModifierState.NO_TEAM_MOVE_TO] = true,
		[ModifierState.NO_TEAM_SELECT] = true,
		[ModifierState.STUNNED] = true,
		[ModifierState.UNSELECTABLE] = true,
		[ModifierState.UNTARGETABLE] = true,
	}
}

function modifier_mars_soldier:PlayEffects(direction, target)
	const particle_cast = "particles/units/heroes/hero_mars/mars_arena_of_blood_spear.vpcf"

	const particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.WORLDORIGIN, target)
	ParticleManager.SetParticleControl(particleId, 0, target.GetAbsOrigin())
	ParticleManager.SetParticleControlForward(particleId, 0, direction)
	ParticleManager.ReleaseParticleIndex(particleId)

	EmitSoundOnLocationWithCaster(target.GetAbsOrigin(), "Hero_Mars.Phalanx.Attack", this.caster)
	EmitSoundOn("Hero_Mars.Phalanx.Target", target)
}

function modifier_mars_soldier:OnProjectileHitCustom(params)
	if(IsServer() ) {
		params.hProjectile:Destroy(false)
	}
}

Modifiers.OnProjectileHit(modifier_mars_soldier)