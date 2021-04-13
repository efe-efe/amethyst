modifier_invoker_meteor_custom_impact_thinker = class({})

function modifier_invoker_meteor_custom_impact_thinker:OnCreated(params)
    self.caster = self:GetCaster()
    self.origin = self:GetParent():GetAbsOrigin()
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    self.projectile_speed = self:GetAbility():GetSpecialValueFor("projectile_speed")

    if IsServer() then
        local caster_origin = Vector(params.x, params.y)
        self.direction = Direction2D(caster_origin, self.origin)
        self.damage_table = {
            attacker = self.caster,
            damage = self:GetAbility():GetSpecialValueFor("ability_damage"),
            damage_type = DAMAGE_TYPE_PURE,
        }

        local delay_time = 0.5--self:GetAbility():GetSpecialValueFor('delay_time')
        CreateTimedRadiusMarker(self.caster, self.origin, self.radius, delay_time, 0.2, RADIUS_SCOPE_PUBLIC)
        AddFOWViewer(self.caster:GetTeamNumber(), self.origin, self.radius, delay_time +  0.2, true)
        self:StartIntervalThink(delay_time)

        local end_point = (self.origin + self.direction * self.projectile_speed) - Vector(0, 0, 1000)
        local efx = ParticleManager:CreateParticle("particles/units/heroes/hero_invoker/invoker_chaos_meteor_fly.vpcf", PATTACH_ABSORIGIN, self.caster)
        ParticleManager:SetParticleControl(efx, 0, caster_origin + Vector(0, 0, 1000))
        ParticleManager:SetParticleControl(efx, 1, end_point)
        ParticleManager:SetParticleControl(efx, 2, Vector(1.0, 0, 0))

	    EmitSoundOn("Hero_Invoker.ChaosMeteor.Loop", self:GetCaster())
    end
end

function modifier_invoker_meteor_custom_impact_thinker:OnIntervalThink()
    self:CreateMeteor()
    self:Destroy()
end

function modifier_invoker_meteor_custom_impact_thinker:CreateMeteor()
    local projectile_distance = 1200
    local counter = 0

    CustomEntities:ProjectileAttack(self.caster, {
        bTriggerCounters = false,
        tProjectile = {
            EffectName =			"particles/units/heroes/hero_invoker/invoker_chaos_meteor.vpcf",
            vSpawnOrigin = 			self.origin + Vector(self.direction.x * 45, self.direction.y * 45, 0),
            fDistance = 			projectile_distance,
            fStartRadius =			self:GetAbility():GetSpecialValueFor("hitbox"),
            Source = 				self.caster,
            vVelocity = 			self.direction * self.projectile_speed,
            UnitBehavior = 			PROJECTILES_NOTHING,
            WallBehavior = 			PROJECTILES_NOTHING,
            TreeBehavior = 			PROJECTILES_NOTHING,
            GroundBehavior = 		PROJECTILES_NOTHING,
            bIsReflectable =        false,
            bIsDestructible =		false,
            fGroundOffset = 		0,
            UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntities:Allies(_self.Source, unit) end,
            OnUnitHit = function(_self, unit) 
                local damage_table = {
                    victim = unit,
                    attacker = _self.Source,
                    damage = damage,
                    damage_type = DAMAGE_TYPE_PURE,
                }
                ApplyDamage(damage_table)
            end,
            OnIntervalThink = function(_self, pos)
                counter = counter + 1
                if counter == 5 then
                    CreateModifierThinker(
                        self.caster, -- player source
                        self, -- ability source
                        "modifier_invoker_meteor_custom_thinker", -- modifier name
                        { duration = 3.0 }, -- kv
                        pos,
                        self.caster:GetTeamNumber(),
                        false --bPhantomBlocker
                    )
                    counter = 0
                end
            end,
            OnFinish = function(_self, pos)
                EFX("particles/units/heroes/hero_invoker/invoker_chaos_meteor_crumble.vpcf", PATTACH_WORLDORIGIN, nil, {
                    cp0 = pos,
                    cp3 = pos + Vector(0, 0, 32),
                    release = true
                })
                EmitSoundOn("Hero_Invoker.ChaosMeteor.Impact", self.caster)
                StopSoundOn("Hero_Invoker.ChaosMeteor.Loop", self.caster)
            end,
        }
    })
    EmitSoundOn("Hero_Invoker.ChaosMeteor.Impact", self.caster)

    EFX("particles/econ/items/centaur/centaur_ti6/centaur_ti6_warstomp.vpcf", PATTACH_WORLDORIGIN, nil, {
        cp0 = self.origin,
        cp1 = Vector(self.radius, 0, 0), 
        release = true
    })
end

function modifier_invoker_meteor_custom_impact_thinker:PlayEffectsOnFinish(pos)
	EFX('particles/units/heroes/hero_arc_warden/arc_warden_wraith_cast.vpcf', PATTACH_ABSORIGIN, self:GetCaster(), {
		cp0 = pos,
		cp1 = pos,
		cp2 = pos,
		release = true,
	})
end