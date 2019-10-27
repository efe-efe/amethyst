phantom_extra_mobility = class({})
LinkLuaModifier( "modifier_phantom_extra_movement", "abilities/heroes/phantom/phantom_extra/modifier_phantom_extra_movement", LUA_MODIFIER_MOTION_HORIZONTAL )

function phantom_extra_mobility:GetCastRange( vLocation, hTarget )
    local stacks = SafeGetModifierStacks("modifier_phantom_extra", self:GetCaster(), self:GetCaster())
    local range_per_stack = 30

    return self.BaseClass.GetCastRange(self, vLocation, hTarget) + stacks * range_per_stack
end


function phantom_extra_mobility:OnCastPointEnd()
    local caster = self:GetCaster()
	local origin = caster:GetOrigin()
    local point =  self:GetCursorPosition()
    local ability = caster:FindAbilityByName("phantom_extra")
    local base_damage = ability:GetSpecialValueFor( "ability_damage" )
    local stacks = SafeGetModifierStacks("modifier_phantom_extra", caster, caster)
    local direction = (point - origin):Normalized()
	local distance = self:GetCastRange(Vector(0,0,0), nil)
    local damage = base_damage + stacks

    local speed = 1700
	local offset = 100
    local radius = self:GetSpecialValueFor( "radius" )
    local slow_duration = self:GetSpecialValueFor( "slow_duration" )

    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_phantom_extra_movement", -- modifier name
        {
            x = direction.x,
            y = direction.y,
            r = distance,
            speed = speed,
        } -- kv
    )

	local projectile_speed = speed + 200

    local projectile = {
        EffectName = projectile_name,
		vSpawnOrigin = origin + Vector(direction.x * offset, direction.y * offset, 0),
		fDistance = distance,
        fStartRadius = 0,
        fEndRadius = radius,
        Source = caster,
        vVelocity = direction * projectile_speed,
        UnitBehavior = PROJECTILES_NOTHING,
        TreeBehavior = PROJECTILES_NOTHING,
        WallBehavior = PROJECTILES_DESTROY,
        GroundBehavior = PROJECTILES_NOTHING,
        fGroundOffset = 0,
        UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and unit:GetTeamNumber() ~= _self.Source:GetTeamNumber() end,
        OnUnitHit = function(_self, unit) 
            local damage_table = {
                victim = unit,
                attacker = _self.Source,
                damage = damage,
                damage_type = DAMAGE_TYPE_PHYSICAL,
            }

            ApplyDamage( damage_table )

            -- Add modifier
            unit:AddNewModifier(
                caster, -- player source
                self, -- ability source
                "modifier_generic_fading_slow", -- modifier name
                { duration = slow_duration } -- kv
            )

            self:PlayEffectsOnImpact(unit)
        end,
        OnFinish = function(_self, pos)
            self:PlayEffectsOnFinish(pos)
        end,
    }
    -- Cast projectile
    self:PlayEffectsOnCast()
    Projectiles:CreateProjectile(projectile)
    SafeDestroyModifier("modifier_phantom_extra", caster, caster)
end

--------------------------------------------------------------------------------
-- Graphics & sounds

-- On Spell start
function phantom_extra_mobility:PlayEffectsOnCast()
    -- Cast Sound
    EmitSoundOn("Hero_PhantomAssassin.Strike.End", self:GetCaster())
end

-- On Projectile Finish
function phantom_extra_mobility:PlayEffectsOnFinish( pos )
	local caster = self:GetCaster()
	local offset = 120
	local origin = caster:GetOrigin()
	local direction_normal = (pos - origin):Normalized()
	local final_position = origin + Vector(direction_normal.x * offset, direction_normal.y * offset, 0)
	
	-- Create Particles
	local particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_attack_crit_blur.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT, caster )
    ParticleManager:SetParticleControl( effect_cast, 1, final_position )
    ParticleManager:SetParticleControlForward( effect_cast, 1, caster:GetForwardVector() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

-- On Projectile Hit enemy
function phantom_extra_mobility:PlayEffectsOnImpact( hTarget )
    -- Cast Sound
    EmitSoundOn("Hero_PhantomAssassin.Attack", hTarget)
end

if IsClient() then require("abilities") end
Abilities.Initialize( 
	phantom_extra_mobility,
	{ activity = ACT_DOTA_CAST_ABILITY_1, rate = 1.5 },
	{ movement_speed = 0, fixed_range = 1 }
)