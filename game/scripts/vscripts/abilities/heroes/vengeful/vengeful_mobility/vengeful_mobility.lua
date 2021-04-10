vengeful_mobility = class({})
vengeful_mobility_ultimate = class({})
vengeful_mobility_ultimate_recast = class({})
vengeful_mobility_recast = class({})
LinkLuaModifier("modifier_vengeful_mobility_displacement", "abilities/heroes/vengeful/vengeful_mobility/modifier_vengeful_mobility_displacement", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_vengeful_mobility_recast", "abilities/heroes/vengeful/vengeful_mobility/modifier_vengeful_mobility_recast", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_vengeful_mobility_illusion", "abilities/heroes/vengeful/vengeful_mobility/modifier_vengeful_mobility_illusion", LUA_MODIFIER_MOTION_NONE)

function vengeful_mobility:GetCastAnimationCustom()		    return ACT_DOTA_CAST_ABILITY_1 end
function vengeful_mobility:GetPlaybackRateOverride() 	    return 2.0 end
function vengeful_mobility:GetCastPoint() 	                return 0.1 end
function vengeful_mobility:GetBehavior()                    return DOTA_ABILITY_BEHAVIOR_POINT end
function vengeful_mobility:GetAbilityTextureName()          return self:GetName() end
function vengeful_mobility:GetCooldown(iLevel)              return 8 end
function vengeful_mobility:GetCastRange(vLocation, hTarget) return 800 end

function vengeful_mobility:IsMimicable()
    return true
end

function vengeful_mobility:BeforeRemoved()
    if self.recast_modifier ~= nil then
        if not self.recast_modifier:IsNull() then
            self.recast_modifier:Destroy()
        end
	end
end

function vengeful_mobility:GetAssociatedPrimaryAbilities()
    return self:GetName() .. "_recast"
end

function vengeful_mobility:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	local min_range = self:GetSpecialValueFor("min_range")
	local point = ClampPosition(origin, CustomAbilities:GetCursorPosition(self), self:GetCastRange(Vector(0,0,0), nil), min_range)

	local direction = (point - origin):Normalized()
    local distance = (point - origin):Length2D()
    local air_time = 0.35
    local illusion_duration = 5.0
    local recast_ability = caster:FindAbilityByName(self:GetName() .. "_recast")

    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_vengeful_mobility_displacement", -- modifier name
        {
            x = direction.x,
            y = direction.y,
            r = distance,
            speed = (distance/air_time),
			peak = 100,
        }
    )
    
    local projectile = {
		EffectName =			"particles/units/heroes/hero_vengeful/vengeful_wave_of_terror.vpcf",
		vSpawnOrigin = 			origin + Vector(0, 0, 96),
		fDistance = 			distance,
		Source = 				caster,
		vVelocity = 			direction * distance/air_time,
		UnitBehavior = 			PROJECTILES_NOTHING,
		WallBehavior = 			PROJECTILES_NOTHING,
		TreeBehavior = 			PROJECTILES_NOTHING,
		GroundBehavior = 		PROJECTILES_NOTHING,
		fGroundOffset = 		0,
    }

    self.recast_modifier = caster:AddNewModifier(caster, self, "modifier_vengeful_mobility_recast", { duration = illusion_duration })
    local illusion = CreateIllusions(caster, caster, {
        duration = illusion_duration
    }, 1, 0, false, false)[1]
    illusion:AddNewModifier(caster, self, 'modifier_vengeful_mobility_illusion', { duration = illusion_duration })

    recast_ability:SetIllusion(illusion)

    ProjectilesManagerInstance:CreateProjectile(projectile)
    EmitSoundOn("Hero_VengefulSpirit.WaveOfTerror", caster)
end

function vengeful_mobility_recast:OnSpellStart()
    if self.illusion then
        local caster = self:GetCaster()
        local origin = caster:GetAbsOrigin()
        local illusion_origin = self.illusion:GetAbsOrigin()

        -- Play caster particle
		local caster_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_vengeful/vengeful_nether_swap.vpcf", PATTACH_ABSORIGIN, caster)
		ParticleManager:SetParticleControlEnt(caster_pfx, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", origin, true)
		ParticleManager:SetParticleControlEnt(caster_pfx, 1, self.illusion, PATTACH_POINT_FOLLOW, "attach_hitloc", illusion_origin, true)

		-- Play target particle
		local target_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_vengeful/vengeful_nether_swap_target.vpcf", PATTACH_ABSORIGIN, self.illusion)
		ParticleManager:SetParticleControlEnt(target_pfx, 0, self.illusion, PATTACH_POINT_FOLLOW, "attach_hitloc", origin, true)
        ParticleManager:SetParticleControlEnt(target_pfx, 1, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", illusion_origin, true)
        
        FindClearSpaceForUnit(self:GetCaster(), illusion_origin, true)
        FindClearSpaceForUnit(self.illusion, origin, true)
        self.illusion:Kill(nil, self:GetCaster())

        EmitSoundOn("Hero_VengefulSpirit.NetherSwap", caster)
    end
end

function vengeful_mobility_recast:SetIllusion(hIllusion)
    self.illusion = hIllusion
end

function MimicSpell(hAbility, hAbilityOriginal, iEnergyCost)
    for key,value in pairs(hAbilityOriginal) do
        hAbility[key] = hAbilityOriginal[key]
    end

    hAbility.IsMimicable = function() return false end
    hAbility.GetManaCost = function() return 0 end
    hAbility.GetEnergyCost = function() return iEnergyCost end
end

MimicSpell(vengeful_mobility_ultimate, vengeful_mobility, 25)
MimicSpell(vengeful_mobility_ultimate_recast, vengeful_mobility_recast, 0)

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(vengeful_mobility)
Abilities.Castpoint(vengeful_mobility_ultimate)