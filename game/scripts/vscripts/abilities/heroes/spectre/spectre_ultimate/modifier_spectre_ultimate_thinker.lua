modifier_spectre_ultimate_thinker = class({})
LinkLuaModifier( "modifier_spectre_ultimate", "abilities/heroes/spectre/spectre_ultimate/modifier_spectre_ultimate", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spectre_ultimate_recast", "abilities/heroes/spectre/spectre_ultimate/modifier_spectre_ultimate_recast", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spectre_ultimate_illusion", "abilities/heroes/spectre/spectre_ultimate/modifier_spectre_ultimate_illusion", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spectre_ultimate", "abilities/heroes/spectre/spectre_ultimate/modifier_spectre_ultimate", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spectre_ultimate_damage", "abilities/heroes/spectre/spectre_ultimate/modifier_spectre_ultimate_damage", LUA_MODIFIER_MOTION_NONE )


function modifier_spectre_ultimate_thinker:OnCreated( kv )
    self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
    self.delay_time = self:GetAbility():GetSpecialValueFor("delay_time")
    self.duration = self:GetAbility():GetSpecialValueFor("duration") 
    self.counter = 0
    self.initialized = false

    if IsServer() then
        self:StartIntervalThink( self.delay_time )
    end
end

function modifier_spectre_ultimate_thinker:OnDestroy()
    if IsServer() then
        self:GetCaster():RemoveModifierByName("modifier_spectre_ultimate_recast")
        self:StopEffects()
    end
end

function modifier_spectre_ultimate_thinker:OnIntervalThink()
    if self.initialized == false then
        self:Initialize()
        self.initialized = true
        self:StartIntervalThink(0.1)
        return
    elseif self.counter/10 == self.duration then
        self:Destroy()
        return
    else
        self.counter = self.counter + 1
    end
end

function modifier_spectre_ultimate_thinker:Initialize()
    local origin = self:GetParent():GetOrigin()
    local data_recast = {
        duration = self.duration
    }
    local data_distance = {
        duration = self.duration,
        x = origin.x,
        y = origin.y,
        radius = self.radius
    }
    local data_illusion = {
        duration = self.duration,
        x = origin.x,
        y = origin.y,
        radius = self.radius
    }

    local enemies = self:GetCaster():FindUnitsInRadius( 
        origin, 
        self.radius, 
        DOTA_UNIT_TARGET_TEAM_ENEMY, 
        DOTA_UNIT_TARGET_HERO, 
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER
    )

    local counter = 0
    for _,enemy in pairs(enemies) do
        if not enemy:IsWall() then
            local illusion = CreateIllusions( self:GetCaster(), self:GetCaster(), {
                duration = self.duration,
                outgoing_damage = -50, 
                incoming_damage = -100,
            }, 1, 0, false, true )[1]
            data_illusion["enemy"] = enemy:GetEntityIndex()
            illusion:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_spectre_ultimate_illusion", data_illusion )
            enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_spectre_ultimate", data_distance )

            FindClearSpaceForUnit(illusion, enemy:GetOrigin(), true)
            data_recast["illusion_" .. counter] = illusion:GetEntityIndex()  
            counter = counter +1
        end
    end

    self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_spectre_ultimate_damage", data_distance )

    if #enemies > 0 then
        self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_spectre_ultimate_recast", data_recast )
    end
    self:VisionLogic()    
    self:PlayEffects()
end

function modifier_spectre_ultimate_thinker:VisionLogic()
    local origin = self:GetParent():GetOrigin()
    AddFOWViewer( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), 1500, self.duration, false )

    for i = 0, 360 do
        if (i % 3 == 0) then
            local x = origin.x + self.radius * math.cos(i)
            local y = origin.y + self.radius * math.sin(i)
            local target_point = Vector(x,y, origin.z)

            local ent = SpawnEntityFromTableSynchronous("point_simple_obstruction", {
                origin = target_point, 
                block_fow = true
            })
            ent:SetContextThink( "fow_blocker_" .. i , function()
                UTIL_Remove(ent)
            end, self.duration)
        end
    end
end

-------------------------------------------------------------------
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