treant_mobility = class({})
LinkLuaModifier( "modifier_treant_mobility", "abilities/heroes/treant/treant_mobility/modifier_treant_mobility", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_treant_mobility_movement", "abilities/heroes/treant/treant_mobility/modifier_treant_mobility_movement", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_treant_mobility_knockback", "abilities/heroes/treant/treant_mobility/modifier_treant_mobility_knockback", LUA_MODIFIER_MOTION_NONE )

function treant_mobility:OnCastPointEnd( )
    local caster = self:GetCaster()
	local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()
    local direction = ( point - origin ):Normalized()

    local distance = self:GetCastRange(Vector(0,0,0), nil)
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

    -- load data
	local projectile_speed = speed + 150
	
    local projectile = {
        vSpawnOrigin = origin + Vector(0,0,80),
		fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
        fUniqueRadius = 100,
        Source = caster,
        vVelocity = direction * projectile_speed,
        UnitBehavior = PROJECTILES_NOTHING,
        TreeBehavior = PROJECTILES_NOTHING,
        WallBehavior = PROJECTILES_DESTROY,
        GroundBehavior = PROJECTILES_NOTHING,
        fGroundOffset = 0,
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
                
                unit:AddNewModifier(
                    caster, -- player source
                    self, -- ability source
                    "modifier_treant_mobility_knockback", -- modifier name
                    { 
                        duration = knockback_duration,
                    } -- kv
                )

                -- Add modifier
                unit:AddNewModifier(
                    caster, -- player source
                    self, -- ability source
                    "modifier_generic_knockback", -- modifier name
                    { 
                        duration = knockback_duration,
                        distance = 200,
                        z = 100,
                        x = x,
                        y = y,
                        disable = 1,
                        invulnerable = 1
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

if IsClient() then require("abilities") end
Abilities.Initialize( 
	treant_mobility,
	{ activity = ACT_DOTA_CAST_ABILITY_2, rate = 1.1 },
	{ movement_speed = 0, fixed_range = 1 }
)