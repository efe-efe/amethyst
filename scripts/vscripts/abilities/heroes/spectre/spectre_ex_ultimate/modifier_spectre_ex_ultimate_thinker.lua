modifier_spectre_ex_ultimate_thinker = class({})
LinkLuaModifier( "modifier_spectre_desolate_lua", "abilities/heroes/spectre/spectre_shared_modifiers/modifier_spectre_desolate_lua/modifier_spectre_desolate_lua", LUA_MODIFIER_MOTION_NONE )

function modifier_spectre_ex_ultimate_thinker:OnCreated( kv )
    self.radius = self:GetAbility():GetSpecialValueFor( "radius" )

    if IsServer() then
        local point = self:GetParent():GetOrigin()
        local desolate_duration = self:GetAbility():GetSpecialValueFor("desolate_duration")

        FindClearSpaceForUnit( self:GetCaster(), point , true )

        -- find enemies
        local enemies = FindUnitsInRadius( 
            self:GetCaster():GetTeamNumber(), -- int, your team number
            point, -- point, center point
            nil, -- handle, cacheUnit. (not known)
            self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
            DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
            0, -- int, flag filter
            0, -- int, order filter
            false -- bool, can grow cache
        )

        for _,enemy in pairs(enemies) do
            enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_spectre_desolate_lua", { duration = desolate_duration })
        end
        
        self:PlayEffects()
        
	    self:Destroy()
    end
end


function modifier_spectre_ex_ultimate_thinker:PlayEffects()
    -- Get Resources
    local sound_cast = "Hero_Spectre.Reality"

    local particle_cast = "particles/econ/items/outworld_devourer/od_shards_exile_gold/od_shards_exile_prison_end_gold.vpcf"
    local effect_cast = ParticleManager:CreateParticle( 
            particle_cast, 
            PATTACH_WORLDORIGIN, 
            nil 
        )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )

    EmitSoundOn( sound_cast, self:GetParent() )

    local particle_cast_c = "particles/econ/items/dark_willow/dark_willow_ti8_immortal_head/dw_ti8_immortal_cursed_crown_marker.vpcf"
	local effect_cast_c = ParticleManager:CreateParticle( particle_cast_c, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControl( effect_cast_c, 2, Vector(self.radius, 1, 1))
	ParticleManager:ReleaseParticleIndex( effect_cast_c )
end


