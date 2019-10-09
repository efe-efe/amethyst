nevermore_mobility = class({})
LinkLuaModifier( "modifier_nevermore_mobility_movement", "abilities/heroes/nevermore/nevermore_mobility/modifier_nevermore_mobility_movement", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_generic_fading_slow", "abilities/generic/modifier_generic_fading_slow", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nevermore_souls", "abilities/heroes/nevermore/nevermore_shared_modifiers/modifier_nevermore_souls", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_fading_slow", "abilities/generic/modifier_generic_fading_slow", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function nevermore_mobility:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()

	-- Animation and pseudo cast point
	StartAnimation(caster, {duration= cast_point + 0.1, activity=ACT_DOTA_RAZE_1, rate=1.1})
	caster:AddNewModifier(caster, self , "modifier_cast_point", { 
		duration = cast_point, 
		can_walk = 0,
	})
end

function nevermore_mobility:OnCastPointEnd( pos )
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()
	local damage = self:GetAbilityDamage()
    local max_range = self:GetSpecialValueFor("max_range")
    local min_range = max_range/3
    local slow_duration = self:GetSpecialValueFor("slow_duration")
    local mana_gain = self:GetSpecialValueFor("mana_gain")/100
    
    local speed = 1800
    local direction = (pos - origin):Normalized()
	local basic_attack = caster:FindAbilityByName("nevermore_basic_attack")

    -- determine target position
    local difference = (pos - origin):Length2D()

    if difference > max_range then
        difference = tonumber(max_range)
    else
        if difference < min_range then
            difference = min_range
        end
    end

    local x = pos.x - origin.x
    local y = pos.y - origin.y

    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_nevermore_mobility_movement", -- modifier name
        {
            x = x,
            y = y,
            r = difference,
            speed = speed,
        } -- kv
    )

    -- Initialize variables
	local offset = 100
	local damage = 10--self:GetSpecialValueFor("damage")

	-- load data
    local projectile_name = ""
	local projectile_start_radius = 150
	local projectile_end_radius = 150
	local projectile_distance = difference
	local projectile_speed = speed
    local projectile_direction = direction
	
    local projectile = {
        EffectName = projectile_name,
        vSpawnOrigin = origin,
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
        fRehitDelay = 0.2,
        UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and unit:GetTeamNumber() ~= _self.Source:GetTeamNumber() end,
        OnUnitHit = function(_self, unit) 
            -- Count targets
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

            if unit:IsRealHero() then 
                _self.Source:AddNewModifier(
                    _self.Source,
                    basic_attack,
                    "modifier_nevermore_souls",
                    { duration = basic_attack:GetSpecialValueFor("duration") }
                )
                
                _self.Source:AddNewModifier(
                    _self.Source,
                    basic_attack,
                    "modifier_nevermore_souls",
                    { duration = basic_attack:GetSpecialValueFor("duration") }
                )
            end

            -- Add modifier
            unit:AddNewModifier(
                _self.Source, -- player source
                self, -- ability source
                "modifier_generic_fading_slow", -- modifier name
                { duration = slow_duration } -- kv
            )

            -- Give Mana
			if counter == 1 then
				local mana_gain_final = _self.Source:GetMaxMana() * mana_gain
				_self.Source:GiveMana(mana_gain_final)
            end
            
            self:PlayEffects_c(unit)
        end,
        OnFinish = function(_self, pos)
            self:PlayEffects_b(pos)
        end,
    }
    -- Cast projectile
    self:PlayEffects_a()
    Projectiles:CreateProjectile(projectile)
end

--------------------------------------------------------------------------------
-- Graphics & sounds

-- On Spell start
function nevermore_mobility:PlayEffects_a()
    local caster = self:GetCaster()
    -- Cast Sound
    local sound_cast = "Hero_Nevermore.Death"
    EmitSoundOn(sound_cast, caster)
end

-- On Projectile Finish
function nevermore_mobility:PlayEffects_b( pos )
end

-- On Projectile Hit enemy
function nevermore_mobility:PlayEffects_c( hTarget )
    -- Cast Sound
    local sound_cast = "Hero_Nevermore.ProjectileImpact"
    EmitSoundOn(sound_cast, hTarget)

	-- Get Resources
	local projectile_name = "particles/units/heroes/hero_nevermore/nevermore_necro_souls.vpcf"

	-- CreateProjectile
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
