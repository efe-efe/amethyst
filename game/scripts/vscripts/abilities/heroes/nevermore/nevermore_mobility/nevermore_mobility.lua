nevermore_mobility = class({})
LinkLuaModifier( "modifier_nevermore_mobility_movement", "abilities/heroes/nevermore/nevermore_mobility/modifier_nevermore_mobility_movement", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_nevermore_souls", "abilities/heroes/nevermore/nevermore_shared_modifiers/modifier_nevermore_souls", LUA_MODIFIER_MOTION_NONE )

function nevermore_mobility:OnCastPointEnd()
    local caster = self:GetCaster()
    self.origin = caster:GetOrigin()

	local damage = self:GetSpecialValueFor("ability_damage")
    local min_range = self:GetSpecialValueFor("min_range")
    local fading_slow_duration = self:GetSpecialValueFor("fading_slow_duration")
    local fading_slow_pct = self:GetSpecialValueFor("fading_slow_pct")
    local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local point = CalcPoint(self.origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), min_range)

    local direction = (point - self.origin):Normalized()
    local distance = (point - self.origin):Length2D()
    local speed = (distance/0.5)
	local basic_attack = caster:FindAbilityByName("nevermore_basic_attack")

    caster:RemoveModifierByName("modifier_generic_displacement")
    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_generic_displacement", -- modifier name
        {
            x = direction.x,
            y = direction.y,
            r = distance,
            speed = speed,
            peak = 0,
            colliding = 0,
            activity = 2,
        } -- kv
    )

	local offset = 100
	local hitbox = 150
	
    local projectile = {
        vSpawnOrigin = self.origin,
        fDistance = distance,
        fUniqueRadius = hitbox,
        Source = caster,
        vVelocity = direction * speed,
        UnitBehavior = PROJECTILES_NOTHING,
        TreeBehavior = PROJECTILES_NOTHING,
        WallBehavior = PROJECTILES_DESTROY,
        GroundBehavior = PROJECTILES_NOTHING,
        fGroundOffset = 0,
        bIsReflectable = false,
        bIsSlowable = false,
        UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
        OnUnitHit = function(_self, unit) 
			local counter = 0
			for k, v in pairs(_self.rehit) do
				counter = counter + 1
            end
            
            local damage_table = {
                victim = unit,
                attacker = _self.Source,
                damage = damage,
                damage_type = DAMAGE_TYPE_PURE,
            }
            ApplyDamage( damage_table )

            if _self.Source == caster and not unit:IsObstacle() then
                for i = 0, 1 do
                    caster:AddNewModifier(
                        caster,
                        basic_attack,
                        "modifier_nevermore_souls",
                        {}
                    )
                end
                
                if counter == 1 then
                    caster:GiveManaPercent(mana_gain_pct, unit)
                end
            end

            unit:AddNewModifier(_self.Source, self, "modifier_generic_fading_slow_new", { 
				duration = fading_slow_duration,
				max_slow_pct = fading_slow_pct
			})

            self:PlayEffectsOnImpact(unit)
        end,
        OnThinkBegin = function(_self, pos)
            local particle_cast = "particles/mod_units/heroes/hero_nevermore/nevermore_shadowraze.vpcf"
            local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
            ParticleManager:SetParticleControl( effect_cast, 0, pos - direction * 80)
            ParticleManager:SetParticleControl( effect_cast, 1, Vector( 250, 1, 1 ) )
            ParticleManager:ReleaseParticleIndex( effect_cast )
        end,
    }

    Projectiles:CreateProjectile(projectile)
    self:PlayEffectsOnCast()
end


function nevermore_mobility:OnDisplacementEnd()
    self:PlayEffectsOnDisplacementEnd()
end

function nevermore_mobility:OnDisplacementHalf()
    self:PlayEffectsOnDisplacementHalf()
end

--------------------------------------------------------------------------------
-- Graphics & sounds
function nevermore_mobility:PlayEffectsOnCast()
    EmitSoundOn("Hero_Nevermore.Death", self:GetCaster())
end

function nevermore_mobility:PlayEffectsOnDisplacementHalf()
    local particle_cast = "particles/econ/items/shadow_fiend/sf_desolation/sf_desolation_scratch.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControl(effect_cast, 0, self:GetCaster():GetOrigin()) 
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function nevermore_mobility:PlayEffectsOnDisplacementEnd()
    local particle_cast = "particles/mod_units/heroes/hero_nevermore/nevermore_shadowraze.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin())
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( 250, 1, 1 ) )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

function nevermore_mobility:PlayEffectsOnImpact( hTarget )
	local projectile_name = "particles/units/heroes/hero_nevermore/nevermore_necro_souls.vpcf"
    EmitSoundOn("Hero_Nevermore.ProjectileImpact", hTarget)

	local info = {
		Target = self:GetCaster(),
		Source = hTarget,
		EffectName = projectile_name,
		iMoveSpeed = 400,
		vSourceLoc= hTarget:GetAbsOrigin(),                -- Optional
		bDodgeable = false,                                -- Optional
		bReplaceExisting = false,                         -- Optional
		flExpireTime = GameRules:GetGameTime() + 5,      -- Optional but recommended
		bProvidesVision = false,                           -- Optional
	}
	ProjectileManager:CreateTrackingProjectile(info)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	nevermore_mobility,
	{ activity = ACT_DOTA_RAZE_1, rate = 1.1 },
	{ movement_speed = 0 }
)