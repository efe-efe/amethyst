modifier_treant_ex_second_attack_thinker = class({})

--------------------------------------------------------------------------------
-- Initializer
function modifier_treant_ex_second_attack_thinker:OnCreated(kv)
    if IsServer() then
        self.radius = self:GetAbility():GetSpecialValueFor("radius")
        self.damage = self:GetAbility():GetAbilityDamage()
        self.disable_duration = self:GetAbility():GetSpecialValueFor("disable_duration")
        self.delay_time = self:GetAbility():GetSpecialValueFor("delay_time")
        self.mana_gain = self:GetAbility():GetSpecialValueFor("mana_gain")/100
        self.stun_per_stack = self:GetAbility():GetSpecialValueFor("stun_per_stack")

        -- Start Interval
        self:StartIntervalThink(self.delay_time)
        self:PlayEffectsOnCreated()
    end
end

--------------------------------------------------------------------------------
-- On think
function modifier_treant_ex_second_attack_thinker:OnIntervalThink()
    if IsServer() then
        -- find enemies
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

        local damageTable = {
		    -- victim = target,
            attacker = self:GetCaster(),
            --damage = self.damage,
            damage_type = DAMAGE_TYPE_PURE,
            ability = self:GetAbility(), --Optional.
        }

        for _,enemy in pairs(enemies) do
            local stacks = SafeGetModifierStacks("modifier_treant_natures_punishment", enemy, self:GetCaster())
            local final_stun = self.disable_duration + self.stun_per_stack * stacks

            -- damage
            damageTable.victim = enemy
            damageTable.damage = final_damage
            ApplyDamage(damageTable)

            enemy:AddNewModifier(self:GetCaster(), self , "modifier_generic_stunned", { duration = final_stun })
            
            SafeDestroyModifier("modifier_treant_natures_punishment", enemy, self:GetCaster())
        end
        
       	-- if at least 1 enemy
        if #enemies > 0 then
            -- Give Mana
            local mana_gain_final = self:GetCaster():GetMaxMana() * self.mana_gain
            self:GetCaster():GiveMana(mana_gain_final)    
        end
        
		self:PlayEffectsOnImpact()

	    self:Destroy()
	end
end

--------------------------------------------------------------------------------

function modifier_treant_ex_second_attack_thinker:PlayEffectsOnCreated()
    local thinker = self:GetParent()
    -- Create sound
    EmitSoundOn("Hero_Treant.LeechSeed.Cast", thinker)
    
    -- Create particles
	local particle_cast = "particles/units/heroes/hero_treant/treant_eyesintheforest.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, thinker)
    ParticleManager:SetParticleControl(effect_cast, 1, Vector(self.radius, 1, 1))
    ParticleManager:ReleaseParticleIndex(effect_cast)


    local particle_cast_b = "particles/econ/items/treant_protector/ti7_shoulder/treant_ti7_crimson_livingarmor_seedlings_parent.vpcf"
    local effect_cast_b = ParticleManager:CreateParticle(particle_cast_b, PATTACH_ABSORIGIN_FOLLOW, thinker)
    ParticleManager:SetParticleControl(effect_cast_b, 1, thinker:GetOrigin())
    ParticleManager:ReleaseParticleIndex(effect_cast_b)


    local particle_cast_c = "particles/units/heroes/hero_witchdoctor/witchdoctor_maledict.vpcf"
    local effect_cast_b = ParticleManager:CreateParticle(particle_cast_c, PATTACH_ABSORIGIN_FOLLOW, thinker)
    ParticleManager:ReleaseParticleIndex(effect_cast_b)
end

function modifier_treant_ex_second_attack_thinker:PlayEffectsOnImpact()
    local thinker = self:GetParent()
    -- Create sound
    EmitSoundOn("Hero_Treant.Attack" , thinker)

    -- Create particles
	local particle_cast = "particles/units/heroes/hero_treant/treant_overgrowth_hero_glow.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, thinker)
    ParticleManager:SetParticleControl(effect_cast, 1, Vector(self.radius, 1, 1))
    ParticleManager:ReleaseParticleIndex(effect_cast)

    local particle_cast_b = "particles/units/heroes/hero_arc_warden/arc_warden_tempest_cast.vpcf"
    local effect_cast_b = ParticleManager:CreateParticle(particle_cast_b, PATTACH_ABSORIGIN_FOLLOW, thinker)
    ParticleManager:ReleaseParticleIndex(effect_cast_b)
end
