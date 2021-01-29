modifier_passive_shoot = class({})

function modifier_passive_shoot:OnCreated(params)
    if IsServer() then
        local interval = 1.0
        self.radius = 700
        self.damage_table = {
			attacker = self:GetParent(),
			damage = self:GetAbility():GetAbilityDamage(),
            damage_type = DAMAGE_TYPE_PHYSICAL
		}
        self:StartIntervalThink(interval); 
    end
end

function modifier_passive_shoot:OnIntervalThink()
    local parent = self:GetParent();
    local origin = parent:GetAbsOrigin();

    if not parent:IsAlive() then
        return
    end

    local shooted = false
    CreateRadiusMarker(self:GetParent(), origin, self.radius, RADIUS_SCOPE_PUBLIC, 0.1)
    ApplyCallbackForUnitsInArea(self:GetParent(), origin, self.radius, DOTA_UNIT_TARGET_TEAM_BOTH, function(unit)
        if unit == parent or shooted then
            return
        end

        shooted = true;
        local point = unit:GetAbsOrigin()

        local projectile_direction = Direction2D(origin, point)
        local projectile_speed = 1200

        local projectile = {
            EffectName = "particles/phantom/phantom_special_attack.vpcf",
            vSpawnOrigin = origin + Vector(projectile_direction.x * 30, projectile_direction.y * 30, 96),
            fDistance =	self.radius,
            fStartRadius = 100,
            Source = parent,
            vVelocity = projectile_direction * projectile_speed,
            UnitBehavior = PROJECTILES_DESTROY,
            TreeBehavior = PROJECTILES_NOTHING,
            WallBehavior = PROJECTILES_DESTROY,
            GroundBehavior = PROJECTILES_NOTHING,
            fGroundOffset = 0,
            UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" end,
            OnUnitHit = function(_self, unit) 
                self.damage_table.victim = unit
                ApplyDamage(self.damage_table)
            end,
            OnFinish = function(_self, pos)
            end,
        }

        CustomEntities:FullyFaceTowards(parent, Vector(projectile_direction.x, projectile_direction.y, parent:GetForwardVector().z))
        ProjectilesManagerInstance:CreateProjectile(projectile)
	end)
end