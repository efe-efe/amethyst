vengeful_mobility = class({})
vengeful_mobility_ultimate = class({})
vengeful_mobility_ultimate_recast = class({})
vengeful_mobility_recast = class({})
LinkLuaModifier("modifier_vengeful_mobility_displacement", "abilities/heroes/vengeful/vengeful_mobility/modifier_vengeful_mobility_displacement", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_vengeful_mobility_recast", "abilities/heroes/vengeful/vengeful_mobility/modifier_vengeful_mobility_recast", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_vengeful_mobility_illusion", "abilities/heroes/vengeful/vengeful_mobility/modifier_vengeful_mobility_illusion", LUA_MODIFIER_MOTION_NONE)

GetAnimation(){		    return GameActivity.DOTA_CAST_ABILITY_1 }
GetPlaybackRateOverride(){ 	    return 2.0 }
GetCastPoint(){ 	                return 0.1 }
function vengeful_mobility:GetBehavior()                    return DOTA_ABILITY_BEHAVIOR_POINT }
function vengeful_mobility:GetAbilityTextureName()          return this.GetName() }
GetCooldown(level: number){              return 8 }
function vengeful_mobility:GetCastRange(vLocation, target) return 800 }

function vengeful_mobility:IsMimicable()
    return true
}

function vengeful_mobility:BeforeRemoved()
    if(this.recast_modifier ~= undefined ) {
        if(! this.recast_modifier:IsNull() ) {
            this.recast_modifier:Destroy()
        }
	}
}

function vengeful_mobility:GetAssociatedPrimaryAbilities()
    return this.GetName() .. "_recast"
}

OnSpellStart(){
	
	const origin = this.caster.GetAbsOrigin()
	const min_range = this.GetSpecialValueFor("min_range")
	const point = ClampPosition(origin, CustomAbilitiesLegacy:GetCursorPosition(this), this.GetCastRange(Vector(0,0,0), undefined), min_range)

	const direction = (point - origin):Normalized()
    const distance = (point - origin):Length2D()
    const air_time = 0.35
    const illusion_duration = 5.0
    const recast_ability = this.caster.FindAbilityByName(this.GetName() .. "_recast")

    this.caster.AddNewModifier(
        this.caster, -- player source
        this, -- ability source
        "modifier_vengeful_mobility_displacement", -- modifier name
        {
            x = direction.x,
            y = direction.y,
            r = distance,
            speed = (distance/air_time),
			peak = 100,
        }
    )
    
    const projectile = {
		EffectName =			"particles/units/heroes/hero_vengeful/vengeful_wave_of_terror.vpcf",
		vSpawnOrigin = 			origin + Vector(0, 0, 96),
		fDistance = 			distance,
		Source = 				this.caster,
		vVelocity = 			direction * distance/air_time,
		UnitBehavior = 			PROJECTILES_NOTHING,
		WallBehavior = 			PROJECTILES_NOTHING,
		TreeBehavior = 			PROJECTILES_NOTHING,
		GroundBehavior = 		PROJECTILES_NOTHING,
		fGroundOffset = 		0,
    }

    this.recast_modifier = this.caster.AddNewModifier(this.caster, this, "modifier_vengeful_mobility_recast", { duration = illusion_duration })
    const illusion = CreateIllusions(this.caster, this.caster, {
        duration = illusion_duration
    }, 1, 0, false, false)[1]
    illusion:AddNewModifier(this.caster, this, 'modifier_vengeful_mobility_illusion', { duration = illusion_duration })

    recast_ability:SetIllusion(illusion)

    ProjectilesManagerInstance:CreateProjectile(projectile)
    EmitSoundOn("Hero_VengefulSpirit.WaveOfTerror", this.caster)
}

OnSpellStart(){
    if(this.illusion ) {
        
        const origin = this.caster.GetAbsOrigin()
        const illusion_origin = this.illusion:GetAbsOrigin()

        -- Play this.caster particle
		const caster_pfx = ParticleManager.CreateParticle("particles/units/heroes/hero_vengeful/vengeful_nether_swap.vpcf", ParticleAttachment.ABSORIGIN, this.caster)
		ParticleManager.SetParticleControlEnt(caster_pfx, 0, this.caster, ParticleAttachment.POINT_FOLLOW, "attach_hitloc", origin, true)
		ParticleManager.SetParticleControlEnt(caster_pfx, 1, this.illusion, ParticleAttachment.POINT_FOLLOW, "attach_hitloc", illusion_origin, true)

		-- Play target particle
		const target_pfx = ParticleManager.CreateParticle("particles/units/heroes/hero_vengeful/vengeful_nether_swap_target.vpcf", ParticleAttachment.ABSORIGIN, this.illusion)
		ParticleManager.SetParticleControlEnt(target_pfx, 0, this.illusion, ParticleAttachment.POINT_FOLLOW, "attach_hitloc", origin, true)
        ParticleManager.SetParticleControlEnt(target_pfx, 1, this.caster, ParticleAttachment.POINT_FOLLOW, "attach_hitloc", illusion_origin, true)
        
        FindClearSpaceForUnit(this.caster, illusion_origin, true)
        FindClearSpaceForUnit(this.illusion, origin, true)
        this.illusion:Kill(undefined, this.caster)

        EmitSoundOn("Hero_VengefulSpirit.NetherSwap", this.caster)
    }
}

function vengeful_mobility_recast:SetIllusion(hIllusion)
    this.illusion = hIllusion
}

function MimicSpell(hAbility, hAbilityOriginal, iEnergyCost)
    for key,value in pairs(hAbilityOriginal) do
        hAbility[key] = hAbilityOriginal[key]
    }

    hAbility.IsMimicable = function() return false }
    hAbility.GetManaCost = function() return 0 }
    hAbility.GetEnergyCost = function() return iEnergyCost }
}

MimicSpell(vengeful_mobility_ultimate, vengeful_mobility, 25)
MimicSpell(vengeful_mobility_ultimate_recast, vengeful_mobility_recast, 0)

if(IsClient() ) { require("wrappers/abilities") }
Abilities.Castpoint(vengeful_mobility)
Abilities.Castpoint(vengeful_mobility_ultimate)