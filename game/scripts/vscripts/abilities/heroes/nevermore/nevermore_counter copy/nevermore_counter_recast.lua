nevermore_counter_mobility = class({})
LinkLuaModifier( "modifier_nevermore_counter_movement", "abilities/heroes/nevermore/nevermore_counter/modifier_nevermore_counter_movement", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_generic_fading_slow", "abilities/generic/modifier_generic_fading_slow", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nevermore_souls", "abilities/heroes/nevermore/nevermore_shared_modifiers/modifier_nevermore_souls", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_fading_slow", "abilities/generic/modifier_generic_fading_slow", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nevermore_counter_banish", "abilities/heroes/nevermore/nevermore_counter/modifier_nevermore_counter_banish", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function nevermore_counter_mobility:OnSpellStart()
	-- Initialize variables
    local caster = self:GetCaster()
    
	self.counter_ability = caster:FindAbilityByName("nevermore_counter")
    local cast_point = self:GetCastPoint()
    
    caster:AddNewModifier(
        caster,
        self.counter_ability,
        "modifier_nevermore_counter_banish",
        { duration = cast_point }
    )

	-- Animation and pseudo cast point
	caster:AddNewModifier(caster, self , "modifier_cast_point_old", { 
		duration = cast_point, 
		can_walk = 0,
	})
end

function nevermore_counter_mobility:OnCastPointEnd( pos )
    
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()
    local damage = self.counter_ability:GetAbilityDamage()
    
    local max_range = self.counter_ability:GetSpecialValueFor("max_range")
    local min_range = max_range/3

    local slow_duration = self.counter_ability:GetSpecialValueFor("slow_duration")
    local mana_gain = self.counter_ability:GetSpecialValueFor("mana_gain")/100
    local souls = self.counter_ability:GetSpecialValueFor("souls")
    
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
        self.counter_ability, -- ability source
        "modifier_nevermore_counter_movement", -- modifier name
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
        UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
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

                if _self.Source == caster then
                    for i=0, souls - 1 do
                        caster:AddNewModifier(
                            caster,
                            basic_attack,
                            "modifier_nevermore_souls",
                            {}
                        )
                        self:PlayEffects_c(unit)
                    end
                end
            end

            -- Add modifier
            unit:AddNewModifier(
                _self.Source, -- player source
                self.counter_ability, -- ability source
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
        end,
    }
    -- Cast projectile
    caster:RemoveNoDraw()
    self:PlayEffects_a()
    Projectiles:CreateProjectile(projectile)
end

--------------------------------------------------------------------------------
-- Graphics & sounds

-- On Spell start
function nevermore_counter_mobility:PlayEffects_a()
    local caster = self:GetCaster()
    -- Cast Sound
    local sound_cast = "Hero_Nevermore.Death"
    EmitSoundOn(sound_cast, caster)
end

-- On Projectile Hit enemy
function nevermore_counter_mobility:PlayEffects_c( hTarget )
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
