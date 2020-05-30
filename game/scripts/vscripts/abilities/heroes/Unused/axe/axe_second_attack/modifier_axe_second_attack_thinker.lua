modifier_axe_second_attack_thinker = class({})
LinkLuaModifier( "modifier_axe_second_attack_debuff", "abilities/heroes/axe/axe_second_attack/modifier_axe_second_attack_debuff", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_axe_second_attack_buff", "abilities/heroes/axe/axe_second_attack/modifier_axe_second_attack_buff", LUA_MODIFIER_MOTION_HORIZONTAL )

--------------------------------------------------------------------------------
-- Initializer
function modifier_axe_second_attack_thinker:OnCreated( kv )
    if IsServer() then
        self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
        self.delay_time = self:GetAbility():GetSpecialValueFor( "delay_time" )
        self.mana_gain = self:GetAbility():GetSpecialValueFor("mana_gain")/100
        self.duration = self:GetAbility():GetSpecialValueFor("duration")

        -- Start Interval
        self:StartIntervalThink( self.delay_time )
    end
end

--------------------------------------------------------------------------------
-- On Think
function modifier_axe_second_attack_thinker:OnIntervalThink()
    if IsServer() then
        local thinker_origin = self:GetParent():GetOrigin()
        local caster = self:GetCaster()
        
        local enemies = FindUnitsInRadius( 
            caster:GetTeamNumber(), -- int, your team number
            thinker_origin, -- point, center point
            nil, -- handle, cacheUnit. (not known)
            self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
            DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
            0, -- int, flag filter
            0, -- int, order filter
            false -- bool, can grow cache
        )

        -- Print units
        for _,enemy in pairs(enemies) do
            enemy:AddNewModifier(
                caster,
                self:GetAbility(),
                "modifier_axe_second_attack_debuff",
                { duration = self.duration }
            )
            enemy:AddNewModifier(
                caster,
                self:GetAbility(),
                "modifier_generic_fading_slow",
                { duration = self.duration }
            )

            caster:AddNewModifier(
                caster, -- player source
                self:GetAbility(), -- ability source
                "modifier_axe_second_attack_buff", -- modifier name
                { duration = self.duration } -- kv
            )
        end
                    
        -- if at least 1 enemy
        if #enemies > 0 then
            -- Give Mana
            local mana_gain_final = caster:GetMaxMana() * self.mana_gain
            caster:GiveMana(mana_gain_final)    
        end


        self:PlayEffects(thinker_origin)

	    self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Graphics & Sounds
-- On casted
function modifier_axe_second_attack_thinker:PlayEffects(pos)
    -- Create sound
    local sound_cast = "Hero_EarthShaker.Totem"
    EmitSoundOn(sound_cast, self:GetCaster())

	-- Create Particles
	local particle_cast_a = "particles/econ/items/axe/axe_cinder/axe_cinder_battle_hunger_cast.vpcf"
	local particle_cast_b = "particles/econ/items/axe/axe_helm_shoutmask/axe_beserkers_call_owner_shoutmask.vpcf"
	
	local effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_WORLDORIGIN, self:GetCaster() )
	local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	local effect_cast_c = ParticleManager:CreateParticle( particle_cast_b, PATTACH_WORLDORIGIN, self:GetCaster() )
	
	ParticleManager:SetParticleControl( effect_cast_a, 0, Vector(pos.x, pos.y, pos.z + 128) )
	
	ParticleManager:SetParticleControl( effect_cast_b, 0, self:GetCaster():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast_b, 2, Vector(50,0,0))
	
	ParticleManager:SetParticleControl( effect_cast_c, 0, pos )
	ParticleManager:SetParticleControl( effect_cast_c, 2, Vector( self.radius, 1, 1 ) )

	ParticleManager:ReleaseParticleIndex( effect_cast_a )
	ParticleManager:ReleaseParticleIndex( effect_cast_b )
	ParticleManager:ReleaseParticleIndex( effect_cast_c )
end