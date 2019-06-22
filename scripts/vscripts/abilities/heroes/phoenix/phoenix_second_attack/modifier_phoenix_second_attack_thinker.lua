modifier_phoenix_second_attack_thinker = class({})
LinkLuaModifier( "modifier_phoenix_second_attack_buff", "abilities/heroes/phoenix/phoenix_second_attack/modifier_phoenix_second_attack_buff", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phoenix_second_attack_debuff", "abilities/heroes/phoenix/phoenix_second_attack/modifier_phoenix_second_attack_debuff", LUA_MODIFIER_MOTION_NONE )

--Clasifications
--------------------------------------------------------------------------------
function modifier_phoenix_second_attack_thinker:IsHidden()
	return true
end

-- Initializer
--------------------------------------------------------------------------------
function modifier_phoenix_second_attack_thinker:OnCreated( kv )
    if IsServer() then
        self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
        self.duration = self:GetAbility():GetSpecialValueFor("duration")
        self.mana_gain = self:GetAbility():GetSpecialValueFor("mana_gain")
        
        local caster = self:GetCaster()

        -- Start Interval
        self:StartIntervalThink( 0.1 )
    end
end

-- On Think
--------------------------------------------------------------------------------
function modifier_phoenix_second_attack_thinker:OnIntervalThink()
    local ability = self:GetAbility()
    if IsServer() then
        -- find enemies
        local units = FindUnitsInRadius( 
            self:GetParent():GetTeamNumber(), -- int, your team number
            self:GetParent():GetOrigin(), -- point, center point
            nil, -- handle, cacheUnit. (not known)
            self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
            DOTA_UNIT_TARGET_TEAM_BOTH, -- int, team filter
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
            0, -- int, flag filter
            0, -- int, order filter
            false -- bool, can grow cache
        )

        -- Heal allys
        for _,unit in pairs(units) do
            
            if unit:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
                unit:AddNewModifier(
                    self:GetCaster(),
                    self:GetAbility(),
                    "modifier_phoenix_second_attack_buff",
                    { duration = self.duration }
                )
            else
                unit:AddNewModifier(
                    self:GetCaster(),
                    self:GetAbility(),
                    "modifier_phoenix_second_attack_debuff",
                    { duration = self.duration }
                )
            end
        end

        -- if at least 1 ally
            if #units > 0 then
            -- Give Mana
            local mana_gain_final = self:GetCaster():GetMaxMana() * self.mana_gain
            self:GetCaster():GiveMana(mana_gain_final)
        end
        

		self:PlayEffects()
	    self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Graphics & Sounds

-- On arrival
function modifier_phoenix_second_attack_thinker:PlayEffects()
    -- Get Resources
    local sound_cast = "Hero_Omniknight.GuardianAngel"
	local particle_cast = "particles/mod_units/heroes/hero_phoenix/phoenix_fire_spirit_ground.vpcf"
    
    -- particles 1
    local effect_cast = ParticleManager:CreateParticle( 
            particle_cast, 
            PATTACH_WORLDORIGIN, 
            nil 
        )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 1, 1 ) )
    ParticleManager:ReleaseParticleIndex( effect_cast )

    EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), sound_cast, self:GetCaster() )
end
