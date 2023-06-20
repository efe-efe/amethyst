modifier_mars_ultimate_thinker = class({})

IsAura(){
	return this.IsInitialized()
}
GetModifierAura(){
	return "modifier_mars_ultimate_area_check"
}
GetAuraRadius(){
	return this.radius
}
GetAuraDuration(){
	return 0.0
}
GetAuraSearchTeam(){
	return DOTA_UNIT_TARGET_TEAM_BOTH
}
GetAuraSearchType(){
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
}

OnCreated(params){
    this.radius = this.ability.GetSpecialValueFor("radius")

    EmitSoundOn("Hero_Mars.ArenaOfBlood", this.parent)
}
    
OnDestroy(){
    if(IsServer() ) {
        EmitSoundOn("Hero_Mars.ArenaOfBlood.End", this.parent)
        this.StopEffects()
    }
}

function modifier_mars_ultimate_thinker:OnDelayEnds()
    if(IsServer() ) {
        this.PlayEffectsOnCreated()
        EmitSoundOn("Hero_Mars.ArenaOfBlood.Start", this.parent)

        
        const origin = this.parent.GetAbsOrigin()
        const vector = origin + Vector(this.radius, 0, 0)
        const soldierRadius = this.ability.GetSpecialValueFor('soldier_radius')
        const count = 32

        const angle_diff = 360/count

        for i = 0, count - 1 do
            const location = RotatePosition(origin, QAngle(0, angle_diff * i, 0), vector)
            const direction = RotatePosition(Vector(0,0,0), QAngle(0, 200 + angle_diff * i, 0), Vector(1,0,0))

            -- callback after creation
            const callback = function(unit)
                unit:SetForwardVector(direction)
                unit:SetNeverMoveToClearSpace(true)

                -- add modifier
                unit:AddNewModifier(
                    this.caster, -- player source
                    this.ability, -- ability source
                    "modifier_mars_soldier", -- modifier name
                    {
                        duration = this.GetDuration(),
                        model = i % 2 == 0,
                        fade = 1,
                        marker = 0,
                        x = direction.x,
                        y = direction.y,
                        radius = soldierRadius,
                    } -- kv
                )
            }

            -- create unit async (to avoid high think time)
            const unit = CreateUnitByNameAsync(
                "npc_dota_mars_ultimate_soldier",
                location,
                false,
                this.caster,
                undefined,
                this.caster.GetTeamNumber(),
                callback
            )
        }
    }
}

function modifier_mars_ultimate_thinker:PlayEffectsOnCreated()
    const particle_cast = "particles/units/heroes/hero_mars/mars_arena_of_blood.vpcf"
	this.particleId = ParticleManager.CreateParticle(particle_cast, ParticleAttachment.ABSORIGIN, this.parent)	
	ParticleManager.SetParticleControl(this.particleId, 2, this.parent.GetAbsOrigin())
	ParticleManager.SetParticleControl(this.particleId, 1, Vector(this.radius, 1, 1))
}

function modifier_mars_ultimate_thinker:StopEffects()
	ParticleManager.DestroyParticle(this.particleId, false)
	ParticleManager.ReleaseParticleIndex(this.particleId)
}
    
function modifier_mars_ultimate_thinker:GetDelayTime()
    return this.ability.GetCastPoint()
}

function modifier_mars_ultimate_thinker:GetAOERadius()
    return this.ability.GetSpecialValueFor("radius")
}

if(IsClient() ) { require("wrappers/modifiers") }
Modifiers.Thinker(modifier_mars_ultimate_thinker)