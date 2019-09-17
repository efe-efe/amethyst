treant_mobility = class({})
LinkLuaModifier( "modifier_treant_mobility", "abilities/heroes/treant/treant_mobility/modifier_treant_mobility", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_treant_mobility_movement", "abilities/heroes/treant/treant_mobility/modifier_treant_mobility_movement", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_treant_mobility_knockback", "abilities/heroes/treant/treant_mobility/modifier_treant_mobility_knockback", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function treant_mobility:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()

	-- Animation and pseudo cast point
	StartAnimation(caster, {duration = cast_point + 0.1, activity=ACT_DOTA_CAST_ABILITY_2, rate=1.1})
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point", { 
        duration = cast_point,
        can_walk = 0,
        is_fixed = 1
	})
end

function treant_mobility:OnEndPseudoCastPoint( point )
    --Initialize variables
    local caster = self:GetCaster()
    local direction = caster:GetForwardVector()
    local distance = self:GetSpecialValueFor( "range" )
    local heal = self:GetSpecialValueFor( "heal" )
    local knockback_duration = self:GetSpecialValueFor("knockback_duration")

	local damage = self:GetAbilityDamage()
    local speed = 1800

    local x = direction.x * distance
    local y = direction.y * distance

    caster:AddNewModifier(
        caster, 
        self, 
        "modifier_treant_mobility", 
        {}
    )

    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_treant_mobility_movement", -- modifier name
        {
            x = x,
            y = y,
            r = distance,
            speed = speed,
        } -- kv
    )

    -- Initialize variables
    local offset = 0
    
    -- load data
    local projectile_name = ""
	local projectile_start_radius = 0
	local projectile_end_radius = self.radius
	local projectile_distance = distance
	local projectile_speed = speed + 150
	
    -- Dinamyc data
    local origin = caster:GetOrigin()
    local initial_position = origin + Vector(direction.x * offset, direction.y * offset, 0)
    local projectile_direction = direction

    local projectile = {
        EffectName = projectile_name,
        vSpawnOrigin = initial_position + Vector(0,0,80),
        fDistance = projectile_distance,
        fStartRadius = projectile_start_radius,
        fEndRadius = projectile_end_radius,
        Source = caster,
        fExpireTime = 8.0,
        vVelocity = projectile_direction * projectile_speed,
        UnitBehavior = PROJECTILES_NOTHING,
        bMultipleHits = false,
        bIgnoreSource = true,
        TreeBehavior = PROJECTILES_NOTHING,
        bCutTrees = true,
        bTreeFullCollision = false,
        WallBehavior = PROJECTILES_DESTROY,
        GroundBehavior = PROJECTILES_NOTHING,
        fGroundOffset = 0,
        nChangeMax = 1,
        bRecreateOnChange = true,
        bZCheck = false,
        bGroundLock = true,
        bProvidesVision = true,
        bIsReflectable = false,
        bIsSlowable = false,
        iVisionRadius = 200,
        iVisionTeamNumber = caster:GetTeam(),
        bFlyingVision = false,
        fVisionTickTime = .1,
        fVisionLingerDuration = 1,
        draw = false,
        fRehitDelay = 1.0,
        UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" end,
        OnUnitHit = function(_self, unit) 
            -- ENEMIES
			if unit:GetTeamNumber() ~= _self.Source:GetTeamNumber() then
                local damage_table = {
                    victim = unit,
                    attacker = _self.Source,
                    damage = damage,
                    damage_type = DAMAGE_TYPE_PURE,
                }
    
                ApplyDamage( damage_table )

                -- Add modifier
                unit:AddNewModifier(
                    caster, -- player source
                    self, -- ability source
                    "modifier_generic_knockback_lua", -- modifier name
                    { 
                        duration = knockback_duration,
                        distance = 200,
                        z = 100,
                        x = x,
                        y = y,
                    } -- kv
                )

                unit:AddNewModifier(
                    caster, -- player source
                    self, -- ability source
                    "modifier_treant_mobility_knockback", -- modifier name
                    { 
                        duration = knockback_duration,
                    } -- kv
                )
                
                SafeDestroyModifier("modifier_treant_mobility_movement", caster, caster )
                
                _self.OnFinish()
                _self.Destroy()
			end
			-- ALLIES
			if unit:GetTeamNumber() == _self.Source:GetTeamNumber() then
				unit:Heal(heal, _self.Source )
            end
        end,
        OnFinish = function(_self, pos)
        end,
    }
    -- Cast projectile
    Projectiles:CreateProjectile(projectile)

end