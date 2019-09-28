modifier_treant_leeching_seed = class({})

--------------------------------------------------------------------------------
-- Initializer
function modifier_treant_leeching_seed:OnCreated( kv )
    if IsServer() then
        local heal_damage = self:GetAbility():GetSpecialValueFor("heal_damage")
        local duration = self:GetDuration()
        
        self.heal_damage_per_tick = heal_damage/duration
        self.radius = self:GetAbility():GetSpecialValueFor("radius")

        self:StartIntervalThink( 1.0 )
        self:PlayEffectsOnCast()
        
        ProgressBars:AddProgressBar(self:GetParent(), self:GetName(), {
            style = "Seed",
            text = "seed",
            progressBarType = "duration",
            priority = 0,
        })
    end
end

--------------------------------------------------------------------------------
-- Destroyer
function modifier_treant_leeching_seed:OnDestroy()
end

--------------------------------------------------------------------------------
-- On Think
function modifier_treant_leeching_seed:OnIntervalThink()
    if IsServer() then
        local caster = self:GetCaster()
        local victim = self:GetParent()

        CreateRadiusMarker(caster, victim:GetOrigin(), {
            show_all = 1,
            radius = self.radius
        })
        
        --Damage
        local damageTable = {
            victim = victim,
            attacker = caster,
            damage = self.heal_damage_per_tick,
            damage_type = DAMAGE_TYPE_PURE,
            ability = self:GetAbility() --Optional.
        }
        
        ApplyDamage(damageTable)

        local allies = FindUnitsInRadius( 
            caster:GetTeamNumber(), -- int, your team number
            victim:GetOrigin(), -- point, center point
            nil, -- handle, cacheUnit. (not known)
            self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
            DOTA_UNIT_TARGET_TEAM_FRIENDLY, -- int, team filter
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
            0, -- int, flag filter
            0, -- int, order filter
            false -- bool, can grow cache
        )
    
        for _,ally in pairs(allies) do
            ally:Heal(self.heal_damage_per_tick, caster)

            self:PlayEffects(victim, ally)
        end

        self:PlayEffectsTick()
	end
end

function modifier_treant_leeching_seed:PlayEffects( enemy, ally )
	-- Get Resources
	local projectile_name = "particles/units/heroes/hero_treant/treant_leech_seed_projectile.vpcf"

	-- CreateProjectile
	local info = {
		Target = ally,
		Source = enemy,
		EffectName = projectile_name,
		iMoveSpeed = 400,
		vSourceLoc= enemy:GetAbsOrigin(),                -- Optional
		bDodgeable = false,                                -- Optional
		bReplaceExisting = false,                         -- Optional
		flExpireTime = GameRules:GetGameTime() + 5,      -- Optional but recommended
		bProvidesVision = false,                           -- Optional
	}
    ProjectileManager:CreateTrackingProjectile(info)
end

function modifier_treant_leeching_seed:PlayEffectsTick()
    EmitSoundOn("Hero_Treant.LeechSeed.Tick", self:GetParent())

    local effect_cast = ParticleManager:CreateParticle("particles/units/heroes/hero_treant/treant_leech_seed_damage_pulse.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent()) 
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_treant_leeching_seed:PlayEffectsOnCast()
    -- Create Particles
    local effect_cast = ParticleManager:CreateParticle("particles/units/heroes/hero_treant/treant_leech_seed.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    ParticleManager:SetParticleControl( effect_cast, 1, self:GetParent():GetOrigin())
    ParticleManager:SetParticleControl( effect_cast, 3, self:GetParent():GetOrigin())  
    ParticleManager:ReleaseParticleIndex( effect_cast )
end