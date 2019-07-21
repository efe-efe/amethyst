modifier_spectre_mobility_thinker = class({})

--------------------------------------------------------------------------------

function modifier_spectre_mobility_thinker:IsHidden()
	return true
end

--------------------------------------------------------------------------------

function modifier_spectre_mobility_thinker:OnCreated( kv )
    if IsServer() then
        self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
        self.damage = self:GetAbility():GetAbilityDamage()
        self.disable_duration = self:GetAbility():GetSpecialValueFor( "disable_duration" )
        self.delay_time = self:GetAbility():GetSpecialValueFor( "delay_time" )
        self.mana_gain = self:GetAbility():GetSpecialValueFor("mana_gain")/100

        -- Start Interval
        self:StartIntervalThink( self.delay_time )

        self:PlayEffects()
    end
end

--------------------------------------------------------------------------------

function modifier_spectre_mobility_thinker:OnIntervalThink()
    if IsServer() then
        -- determine target position
        local point = self:GetParent():GetOrigin()
        local caster = self:GetCaster()
        local old_origin = caster:GetOrigin()

        -- teleport
        FindClearSpaceForUnit( caster, point , true )

        -- find enemies
        local enemies = FindUnitsInRadius( 
            self:GetParent():GetTeamNumber(), -- int, your team number
            point, -- point, center point
            nil, -- handle, cacheUnit. (not known)
            self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
            DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
            0, -- int, flag filter
            0, -- int, order filter
            false -- bool, can grow cache
        )

        local damageTable = {
            -- victim = target,
            attacker = self:GetCaster(),
            damage = self.damage,
            damage_type = DAMAGE_TYPE_PHYSICAL,
            ability = self:GetAbility() --Optional.
        }
        
        for _,enemy in pairs(enemies) do
            -- damage
            damageTable.victim = enemy
            ApplyDamage(damageTable)
            self:PlayEffects3(enemy)
        end
        
        -- if at least 1 enemy
        if #enemies > 0 then
            -- Give Mana
            local mana_gain_final = self:GetCaster():GetMaxMana() * self.mana_gain
            self:GetCaster():GiveMana(mana_gain_final)    
        end

		self:PlayEffects2()

	    self:Destroy()
	end
end

--------------------------------------------------------------------------------
--Cast
function modifier_spectre_mobility_thinker:PlayEffects()
	-- Get Resources
	local sound_cast = "Hero_Spectre.HauntCast"
    EmitSoundOn( sound_cast, self:GetCaster() )
end
--Arrive
function modifier_spectre_mobility_thinker:PlayEffects2()
    -- Get Resources
    local sound_cast = "Hero_Spectre.Haunt"
    
    -- particles 1
    local particle_cast = "particles/units/heroes/hero_spectre/spectre_death.vpcf"
    local effect_cast = ParticleManager:CreateParticle( 
            particle_cast, 
            PATTACH_WORLDORIGIN, 
            nil 
        )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 3, self:GetCaster():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )

    -- particles 2

    -- particles/mod_units/heroes/hero_sven/sven_spell_great_cleave.vpcf
    local particle_cast2 = "particles/sweep_generic/sweep_3.vpcf"
    local effect_cast2 = ParticleManager:CreateParticle( 
            particle_cast2, 
            PATTACH_ABSORIGIN_FOLLOW, 
            self:GetCaster()
        )
    --ParticleManager:SetParticleControl( effect_cast2, 0, self:GetCaster():GetOrigin() )
    --ParticleManager:SetParticleControl( effect_cast2, 3, self:GetCaster():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast2 )

    
	local particle_cast_c = "particles/econ/items/dark_willow/dark_willow_ti8_immortal_head/dw_crimson_ti8_immortal_cursed_crownmarker.vpcf"
	local effect_cast_c = ParticleManager:CreateParticle( particle_cast_c, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControl( effect_cast_c, 2, Vector(self.radius, 1, 1))
	ParticleManager:ReleaseParticleIndex( effect_cast_c )
    
end


function modifier_spectre_mobility_thinker:PlayEffects3( hTarget )
	-- Get Resources
	local sound_cast = "Hero_Spectre.Attack"

	-- Create Sound
    EmitSoundOn( sound_cast, hTarget )
end