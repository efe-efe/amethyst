modifier_wisp_ultimate_thinker_lua = class({})

--------------------------------------------------------------------------------

function modifier_wisp_ultimate_thinker_lua:IsHidden()
	return true
end

--------------------------------------------------------------------------------

function modifier_wisp_ultimate_thinker_lua:OnCreated( kv )
    if IsServer() then
        self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
        self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
        self.disable_duration = self:GetAbility():GetSpecialValueFor( "disable_duration" )
        self.delay_time = self:GetAbility():GetSpecialValueFor( "delay_time" )
        self.damage_bonus =  self:GetAbility():GetSpecialValueFor("damage_bonus")

        -- Start Interval
        self:StartIntervalThink( self.delay_time )

        self:PlayEffects()
    end
end

--------------------------------------------------------------------------------

function modifier_wisp_ultimate_thinker_lua:OnIntervalThink()
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
            --damage = self.damage,
            damage_type = DAMAGE_TYPE_PURE,
            ability = self:GetAbility() --Optional.
        }
        
        for _,enemy in pairs(enemies) do
            local guardian_essence = enemy:FindModifierByNameAndCaster( "modifier_wisp_guardian_essence_lua", caster )
            local final_damage = self.damage

            -- If have the guardian essences, adds extra damage
            if guardian_essence ~= nil then
                final_damage = self.damage_bonus + final_damage
            end

            -- damage
            damageTable.victim = enemy
            damageTable.damage = final_damage
            ApplyDamage(damageTable)
		end

		self:PlayEffects2()

	    self:Destroy()
	end
end

--------------------------------------------------------------------------------

function modifier_wisp_ultimate_thinker_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/econ/items/earthshaker/earthshaker_totem_ti6/earthshaker_totem_ti6_cast_glyph.vpcf"
	local sound_cast = "Hero_Wisp.TeleportOut"

    local effect_cast = ParticleManager:CreateParticle( 
        particle_cast, 
        PATTACH_WORLDORIGIN, 
        self:GetCaster()
    )

    ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 1, 1 ) )
    ParticleManager:ReleaseParticleIndex( effect_cast )

    EmitSoundOn( 
        sound_cast, 
        self:GetCaster() 
    )
end

function modifier_wisp_ultimate_thinker_lua:PlayEffects2()
    -- Get Resources
    local sound_cast = "Ability.LightStrikeArray"
    
    -- particles 1
    local particle_cast = "particles/econ/items/ancient_apparition/aa_blast_ti_5/ancient_apparition_ice_blast_explode_ti5.vpcf"
    local effect_cast = ParticleManager:CreateParticle( 
            particle_cast, 
            PATTACH_WORLDORIGIN, 
            nil 
        )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 3, self:GetParent():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
 
    -- particles 2
    local particle_cast2 = "particles/econ/items/zeus/arcana_chariot/zeus_arcana_thundergods_wrath_start_bolt_parent.vpcf"
    local effect_cast2 = ParticleManager:CreateParticle( 
            particle_cast2, 
            PATTACH_WORLDORIGIN, 
            nil 
        )
    ParticleManager:SetParticleControl( effect_cast2, 0, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast2, 1, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast2, 2, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast2, 5, self:GetParent():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast2 )

    EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), sound_cast, self:GetCaster() )
end
