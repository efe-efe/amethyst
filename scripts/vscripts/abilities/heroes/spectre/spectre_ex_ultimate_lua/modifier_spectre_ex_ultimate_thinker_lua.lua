modifier_spectre_ex_ultimate_thinker_lua = class({})
LinkLuaModifier( "modifier_spectre_desolate_lua", "abilities/heroes/spectre/spectre_shared_modifiers/modifier_spectre_desolate_lua/modifier_spectre_desolate_lua", LUA_MODIFIER_MOTION_NONE )

function modifier_spectre_ex_ultimate_thinker_lua:OnCreated( kv )
    if IsServer() then
        local radius = self:GetAbility():GetSpecialValueFor( "radius" )
        local point = self:GetParent():GetOrigin()

        FindClearSpaceForUnit( self:GetCaster(), point , true )

        -- find enemies
        local enemies = FindUnitsInRadius( 
            self:GetCaster():GetTeamNumber(), -- int, your team number
            point, -- point, center point
            nil, -- handle, cacheUnit. (not known)
            radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
            DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
            0, -- int, flag filter
            0, -- int, order filter
            false -- bool, can grow cache
        )

        for _,enemy in pairs(enemies) do
            enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_spectre_desolate_lua", {})
        end
        
        self:PlayEffects()
        
	    self:Destroy()
    end
end


function modifier_spectre_ex_ultimate_thinker_lua:PlayEffects()
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
end


