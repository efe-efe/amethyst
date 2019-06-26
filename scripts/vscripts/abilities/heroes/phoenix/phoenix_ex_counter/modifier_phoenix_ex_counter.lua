modifier_phoenix_ex_counter = class({})
LinkLuaModifier( "modifier_phoenix_ex_counter_mark", "abilities/heroes/phoenix/phoenix_ex_counter/modifier_phoenix_ex_counter_mark", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_rooted_lua", "abilities/generic/modifier_generic_rooted_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Classifications
function modifier_phoenix_ex_counter:IsHidden()
	return false
end

function modifier_phoenix_ex_counter:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializer
function modifier_phoenix_ex_counter:OnCreated()
    self.max_radius = self:GetAbility():GetSpecialValueFor("max_radius")
    self.damage_per_think = self:GetAbility():GetSpecialValueFor("damage_per_think")
    self.root_duration_per_think = self:GetAbility():GetSpecialValueFor("damage_per_think")
    local think_interval = self:GetAbility():GetSpecialValueFor("think_interval")
    self.instances = self:GetAbility():GetSpecialValueFor("instances")
    
    local initial_radius = 200
    self.radius_interval = (self.max_radius - initial_radius)/self.instances
    self.radius = initial_radius
    self.counter = 0

    if IsServer() then
        self:PlayEffects()
        self:StartIntervalThink(think_interval)
    end
end


function modifier_phoenix_ex_counter:OnDestroy()
    if IsServer() then
    end
end

function modifier_phoenix_ex_counter:OnIntervalThink()
    self.radius = self.radius + self.radius_interval
    self.counter = self.counter + 1

    if self.counter == self.instances then 
        self:Destroy()
        return
    end

    self:PlayEffects()
    
    local enemies = FindUnitsInRadius( 
        self:GetParent():GetTeamNumber(), -- int, your team number
        self:GetParent():GetOrigin(), -- point, center point
        nil, -- handle, cacheUnit. (not known)
        self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
        DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
        0, -- int, flag filter
        0, -- int, order filter
        false -- bool, can grow cache
    )

    for _,enemy in pairs(enemies) do
        if not enemy:HasModifier("modifier_phoenix_ex_counter_mark") then
            enemy:AddNewModifier(
                self:GetParent(),
                self:GetAbility(),
                "modifier_phoenix_ex_counter_mark",
                { duration = self:GetDuration() }
            )

            enemy:AddNewModifier(
                self:GetParent(),
                self:GetAbility(),
                "modifier_generic_rooted_lua",
                { duration = self.root_duration_per_think * self.counter }
            )
    

            local damage = {
                victim = enemy,
                attacker = self:GetParent(),
                damage = self.damage_per_think * self.counter,
                damage_type = DAMAGE_TYPE_PURE,
            }

            ApplyDamage( damage )
        end
    end
end

function modifier_phoenix_ex_counter:PlayEffects()
    -- Create Sound
	local sound_cast = "Hero_Phoenix.FireSpirits.Launch"
    EmitSoundOn( sound_cast, self:GetCaster() )
    
    local particle_cast_b = "particles/econ/items/axe/axe_helm_shoutmask/axe_beserkers_call_owner_shoutmask.vpcf"
    local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    ParticleManager:SetParticleControl( effect_cast_b, 0, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast_b, 2, Vector( self.radius, 1, 1 ) )
    ParticleManager:ReleaseParticleIndex( effect_cast_b )
end



