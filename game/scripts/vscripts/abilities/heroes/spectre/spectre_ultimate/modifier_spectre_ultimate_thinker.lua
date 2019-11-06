modifier_spectre_ultimate_thinker = class({})
LinkLuaModifier( "modifier_spectre_ultimate", "abilities/heroes/spectre/spectre_ultimate/modifier_spectre_ultimate", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spectre_ultimate_swap_recast", "abilities/heroes/spectre/spectre_ultimate/modifier_spectre_ultimate_swap_recast", LUA_MODIFIER_MOTION_NONE )

function modifier_spectre_ultimate_thinker:OnCreated( kv )
    self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
    self.delay_time = self:GetAbility():GetSpecialValueFor("delay_time")
    self.recast_time = self:GetAbility():GetSpecialValueFor("recast_time")
    self.duration = self:GetAbility():GetSpecialValueFor("duration") 
    self.swaped = false -- To tell if the spells have swapped position
    self.initialized = false

    if IsServer() then
        self.ability = self:GetCaster():FindAbilityByName("spectre_ultimate_swap")
        self:StartIntervalThink( self.delay_time )
    end
end

function modifier_spectre_ultimate_thinker:OnDestroy()
    if IsServer() then
        if self.swaped then
            self:GetCaster():SwapAbilities( 
                "spectre_ultimate",
                "spectre_ultimate_swap",
                true,
                false
            )
        end
        self.ability:CleanIllusions()
        self:StopEffects()
    end
end

function modifier_spectre_ultimate_thinker:OnIntervalThink()
    local thinker_origin = self:GetParent():GetOrigin()

    if self.initialized == false then
        -- find enemies
        local enemies = FindUnitsInRadius(
            self:GetCaster():GetTeamNumber(), -- int, your team number
            thinker_origin, -- point, center point
            nil, -- handle, cacheUnit. (not known)
            self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
            DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
            0, -- int, flag filter
            0, -- int, order filter
            false -- bool, can grow cache
        )
        
        for _,enemy in pairs(enemies) do
            if not enemy:IsWall() then

                if swapped
                self:GetCaster():SwapAbilities( 
                    "spectre_ultimate",
                    "spectre_ultimate_swap",
                    false,
                    true
                )

                local illusion = CreateIllusions( self:GetCaster(), self:GetCaster(), {
                    duration = self.duration,
                    outgoing_damage = -50, 
                    incoming_damage = -100,
                }, 1, 0, false, true )[1]
                FindClearSpaceForUnit(illusion, enemy:GetOrigin(), true)
                self.ability:AddIllusion(illusion:GetEntityIndex()) 

                enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_spectre_ultimate", { duration = self.duration })
            end
        end

        if #enemies > 0 then
            self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_spectre_ultimate_swap_recast", { self.duration })
        end
        
        for i = 0, 360 do
            local x = thinker_origin.x + self.radius * math.cos(i)
            local y = thinker_origin.y + self.radius * math.sin(i)
            local target_point = Vector(x,y, thinker_origin.z)

            local ent = SpawnEntityFromTableSynchronous("point_simple_obstruction", {
                origin = target_point, 
                block_fow = true
            })

            ent:SetContextThink( "fow_blocker_" .. i , function()
                UTIL_Remove(ent)
            end, self.duration)
        end

        self:PlayEffects()
        self:StartIntervalThink(self.duration)
        self.initialized = true
    else
        self:Destroy()
    end
end

function modifier_spectre_ultimate_thinker:PlayEffects()
    local particle_cast = "particles/fv_chronosphere_aeons.vpcf"

    self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( self.effect_cast, 0, self:GetParent():GetOrigin())
    ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( self.radius, self.radius, 1 ) )
end


function modifier_spectre_ultimate_thinker:StopEffects()
    ParticleManager:DestroyParticle( self.effect_cast , false )
    ParticleManager:ReleaseParticleIndex( self.effect_cast )
end