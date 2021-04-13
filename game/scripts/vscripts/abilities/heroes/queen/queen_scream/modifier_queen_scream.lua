modifier_queen_scream = class({})

function modifier_queen_scream:OnCreated(params)
    if IsServer() then
        self.caster = self:GetCaster()
        self.origin = self.caster:GetAbsOrigin()
        self.count = 0
        self.screams = params.screams
        self:OnIntervalThink()
        self:StartIntervalThink(1.0)
        self.radius_marker_modifier = CreateTimedRadiusMarker(self:GetCaster(), self.origin, 250, 1.25* self.screams, 0.2, RADIUS_SCOPE_PUBLIC):FindModifierByName('radius_marker_thinker')   
    end
end

function modifier_queen_scream:OnDestroy()
    if IsServer() then
        if self.radius_marker_modifier ~= nil then
            if not self.radius_marker_modifier:IsNull() then
                self.radius_marker_modifier:Destroy()
            end
        end
    end
end

function modifier_queen_scream:OnIntervalThink()
    if self.count == self.screams then
        self:Destroy()
        return
    end

    local particle = "particles/queen/queen_scream_no_ground.vpcf"
    if self.count == 0 then
        particle = "particles/units/heroes/hero_dawnbreaker/dawnbreaker_elated_fury_landing.vpcf"
    end

    self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_3, 1.5)
    EmitSoundOn("Hero_QueenOfPain.ScreamOfPain", self.caster)
    EFX(particle, PATTACH_WORLDORIGIN, self.caster, {
        cp0 = self.origin,
        cp1 = self.origin,
        release = true
    })    
    local count = 12 + self.count * 5
    local angle_diff = 360/count
    local vector = self.origin + Vector(1, 0, 0)
    
    for i = 0, count - 1 do
        local location = RotatePosition(self.origin, QAngle(0, angle_diff * i, 0), vector)
        self:LaunchProjectile(location)
    end
    
    self.count = self.count + 1
end

function modifier_queen_scream:LaunchProjectile(vPoint)
    local projectile_direction = Direction2D(self.origin, vPoint)
    local projectile_speed = 800
    local damage = 12
    local fear_duration = 1.0

    CustomEntities:ProjectileAttack(self.caster, {
        tProjectile = {
            EffectName = "particles/queen/queen_scream.vpcf",
            vSpawnOrigin = self.origin + Vector(0, 0, 96),
            fDistance = 2000,
            fStartRadius = 70,
            Source = self.caster,
            vVelocity = projectile_direction * projectile_speed,
            UnitBehavior = PROJECTILES_DESTROY,
            TreeBehavior = PROJECTILES_NOTHING,
            WallBehavior = PROJECTILES_DESTROY,
            GroundBehavior = PROJECTILES_NOTHING,
            fGroundOffset = 0,
            UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntities:Allies(_self.Source, unit) end,
            OnUnitHit = function(_self, unit) 
                local damage_table = {
                    victim = unit,
                    attacker = _self.Source,
                    damage = damage,
                    damage_type = DAMAGE_TYPE_PHYSICAL,
                    ability = self
                }
                ApplyDamage(damage_table)

                unit:AddNewModifier(_self.Source, self, "modifier_generic_fear", { duration = fear_duration })
            end,
            OnFinish = function(_self, pos)
                EFX("particles/units/heroes/hero_queenofpain/queen_shadow_strike_explosion.vpcf", PATTACH_WORLDORIGIN, nil, {
                    cp0 = pos,
                    cp3 = pos,
                })
                EmitSoundOn('Hero_QueenOfPain.ShadowStrike.Target', self.caster)
            end,
        }
    })
end

function modifier_queen_scream:CheckState()
	return {
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_STUNNED] = true,
	}
end