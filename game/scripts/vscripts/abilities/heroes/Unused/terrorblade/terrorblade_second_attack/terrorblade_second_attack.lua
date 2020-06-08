terrorblade_second_attack = class({})

function terrorblade_second_attack:OnCastPointEnd()
    local caster = self:GetCaster()
	local origin = caster:GetOrigin()
    local point =  self:GetCursorPosition()
    local direction = (point - origin):Normalized()
	local distance = self:GetCastRange(Vector(0,0,0), nil)

    local speed = 1500
	local offset = 100
    local radius = self:GetSpecialValueFor("radius")
    local damage = self:GetSpecialValueFor("ability_damage")
    
    caster:SetForwardVector(direction)
    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_generic_displacement", -- modifier name
        {
            x = direction.x,
            y = direction.y,
            r = distance,
            speed = speed,
            peak = 80,
            colliding = 0,
            activity = ACT_DOTA_ATTACK,
            rate = 1.2,
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
        UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
        OnUnitHit = function(_self, unit) 
            local damage_table = {
                victim = unit,
                attacker = _self.Source,
                damage = damage,
                damage_type = DAMAGE_TYPE_PHYSICAL,
            }

            ApplyDamage(damage_table)
            self:PlayEffectsOnImpact(unit)
        end,
        OnFinish = function(_self, pos)
            self:PlayEffectsOnFinish(pos)
        end,
    }
    -- Cast projectile
    self:PlayEffectsOnCast()
    Projectiles:CreateProjectile(projectile)
end

function terrorblade_second_attack:OnDisplacementEnd()
    self:StopEffects()
end
--------------------------------------------------------------------------------
-- Graphics & sounds
function terrorblade_second_attack:PlayEffectsOnCast()
    -- Cast Sound
    EmitSoundOn("Hero_PhantomAssassin.Strike.End", self:GetCaster())

    local particle_cast = "particles/econ/events/ti9/force_staff_ti9.vpcf"
    self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, self:GetCaster())
end

-- On Projectile Finish
function terrorblade_second_attack:PlayEffectsOnFinish(pos)
	local caster = self:GetCaster()
	local offset = 120
	local origin = caster:GetOrigin()
	local direction_normal = (pos - origin):Normalized()
	local final_position = origin + Vector(direction_normal.x * offset, direction_normal.y * offset, 0)
	
	-- Create Particles
	local particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_attack_crit_blur.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_POINT, caster)
    ParticleManager:SetParticleControl(effect_cast, 1, final_position)
    ParticleManager:SetParticleControlForward(effect_cast, 1, caster:GetForwardVector())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

-- On Projectile Hit enemy
function terrorblade_second_attack:PlayEffectsOnImpact(hTarget)
    EmitSoundOn("Hero_PhantomAssassin.Attack", hTarget)
end

function terrorblade_second_attack:StopEffects()
    if self.effect_cast ~= nil then
        ParticleManager:DestroyParticle(self.effect_cast, false)
        ParticleManager:ReleaseParticleIndex(self.effect_cast)
    end
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize(
	terrorblade_second_attack,
	nil,
	{ movement_speed = 0, fixed_range = 1 }
)