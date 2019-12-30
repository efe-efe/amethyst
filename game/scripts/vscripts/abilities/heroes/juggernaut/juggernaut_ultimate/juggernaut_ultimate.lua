juggernaut_ultimate = class({})
LinkLuaModifier( "modifier_juggernaut_ultimate_movement", "abilities/heroes/juggernaut/juggernaut_ultimate/modifier_juggernaut_ultimate_movement", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_juggernaut_ultimate_slashing", "abilities/heroes/juggernaut/juggernaut_ultimate/modifier_juggernaut_ultimate_slashing", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_fading_slow", "abilities/generic/modifier_generic_fading_slow", LUA_MODIFIER_MOTION_NONE )

function juggernaut_ultimate:OnSpellStart()
    self:PlayEffectsOnPhase()
end

function juggernaut_ultimate:OnStopPseudoCastPoint()
	StopGlobalSound( "juggernaut_jug_ability_omnislash_01" )
end

function juggernaut_ultimate:OnCastPointEnd()
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()
    local projectile_distance = self:GetCastRange(Vector(0,0,0), nil)
    local omni_duration = self:GetSpecialValueFor( "duration" )
    local aspd_per_stack = self:GetSpecialValueFor( "aspd_per_stack" )
    local stacks = SafeGetModifierStacks("modifier_juggernaut_basic_attack_stacks", caster, caster)

    local direction = caster:GetForwardVector()

    local speed = 3000
    local x = direction.x * projectile_distance
    local y = direction.y * projectile_distance

    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_juggernaut_ultimate_movement", -- modifier name
        {
            x = x,
            y = y,
            r = projectile_distance,
            speed = speed,
        } -- kv
    )

    -- Initialize variables
	local offset = 100
	local projectile_speed = speed - 200
	
    local projectile = {
		vSpawnOrigin = origin + Vector(0,0,80),
        fDistance = projectile_distance,
        fUniqueRadius = self:GetSpecialValueFor( "hitbox" ),
        Source = caster,
        vVelocity = direction * projectile_speed,
        UnitBehavior = PROJECTILES_DESTROY,
        TreeBehavior = PROJECTILES_NOTHING,
        WallBehavior = PROJECTILES_DESTROY,
        GroundBehavior = PROJECTILES_NOTHING,
        fGroundOffset = 0,
        UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) and unit:Attribute_GetIntValue("dummy", 0) ~= 1 and not unit:IsObstacle() end,
        OnUnitHit = function(_self, unit) 
            if _self.Source == caster then
                if caster:HasModifier("modifier_juggernaut_ultimate_movement") then
                    SafeDestroyModifier("modifier_juggernaut_ultimate_movement", caster, caster)
                end
            end

            -- Add modifier
            caster:AddNewModifier(
                caster, -- player source
                self, -- ability source
                "modifier_juggernaut_ultimate_slashing", -- modifier name
                {
                    duration = omni_duration,
                    aspd_buff =  aspd_per_stack * stacks
                } -- kv
            )

            self:PlayEffectsOnImpact(unit)

            if stacks == 4 then
                caster:GiveManaPercent(25, nil)
            end
        end,
    }
    Projectiles:CreateProjectile(projectile)
    SafeDestroyModifier("modifier_juggernaut_basic_attack_stacks", caster, caster)
    self:PlayEffectsOnCast()
end

--------------------------------------------------------------------------------
-- Graphics & sounds

-- On Spell start
function juggernaut_ultimate:PlayEffectsOnPhase()
    local caster = self:GetCaster()
    EmitGlobalSound("juggernaut_jug_ability_omnislash_01")

    local particle_cast = "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_death_model.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )
    ParticleManager:ReleaseParticleIndex( effect_cast )

    particle_cast = "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_omni_end.vpcf"
	effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )
    ParticleManager:SetParticleControl( effect_cast, 2, caster:GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 3, caster:GetOrigin() )

    ParticleManager:ReleaseParticleIndex( effect_cast )
end

function juggernaut_ultimate:PlayEffectsOnCast()
    EmitSoundOn("Hero_PhantomAssassin.Strike.End", self:GetCaster())
end

function juggernaut_ultimate:PlayEffectsOnImpact( hTarget )
    EmitSoundOn("Hero_PhantomAssassin.Attack", hTarget)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	juggernaut_ultimate,
	{ activity = ACT_DOTA_GENERIC_CHANNEL_1, translate = "sharp_blade", rate = 2.0 },
	{ movement_speed = 0, fixed_range = 1 }
)