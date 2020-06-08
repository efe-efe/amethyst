modifier_nevermore_second_attack_thinker = class({})
LinkLuaModifier("modifier_nevermore_second_attack_cooldown", "abilities/heroes/nevermore/nevermore_second_attack/modifier_nevermore_second_attack_cooldown", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------
-- Initializer
function modifier_nevermore_second_attack_thinker:OnCreated(kv)
    if IsServer() then
        self.radius = self:GetAbility():GetSpecialValueFor("radius")
        self.delay_time = self:GetAbility():GetSpecialValueFor("delay_time")
        self.mana_gain = self:GetAbility():GetSpecialValueFor("mana_gain")/100
        self.duration = self:GetAbility():GetSpecialValueFor("duration")
        self.damage = self:GetAbility():GetAbilityDamage()
        self.damage_per_stack = self:GetAbility():GetSpecialValueFor("damage")
        self.stack_duration = self:GetAbility():GetSpecialValueFor("stack_duration")

        -- Start Interval
        self:StartIntervalThink(self.delay_time)
    end
end

--------------------------------------------------------------------------------
-- On Think
function modifier_nevermore_second_attack_thinker:OnIntervalThink()
    if IsServer() then
        -- unit identifier
        local thinker_origin = self:GetParent():GetOrigin()
        local caster = self:GetCaster()

        -- get affected enemies
        local enemies = FindUnitsInRadius(
            caster:GetTeamNumber(),
            thinker_origin,
            nil,
            self.radius,
            DOTA_UNIT_TARGET_TEAM_ENEMY,
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
            DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_ANY_ORDER,
            false
       )

        -- for each affected enemies
        for _,enemy in pairs(enemies) do
            -- Get Stack
            local modifier = enemy:FindModifierByNameAndCaster("modifier_nevermore_second_attack", caster)
            local stacks = 0
            if modifier~=nil then
                stacks = modifier:GetStackCount()
            end

            -- Apply damage
            local damageTable = {
                victim = enemy,
                attacker = caster,
                damage = self.damage + stacks * self.damage_per_stack,
                damage_type = DAMAGE_TYPE_MAGICAL,
                ability = this,
            }
            ApplyDamage(damageTable)
        end

        if #enemies > 0 then
            -- Give Mana
                    
            local mana_gain_final = caster:GetMaxMana() * self.mana_gain
            caster:GiveMana(mana_gain_final)   

            -- Refresh if posible
            local cooldownModifier = caster:AddNewModifier(
                caster,
                self:GetAbility(),
                "modifier_nevermore_second_attack_cooldown",
                { duration = self.stack_duration }
           )
            local cooldownStacks = cooldownModifier:GetStackCount()
            
            if cooldownStacks < 3 then
                self:GetAbility():EndCooldown()
            else
                SafeDestroyModifier("modifier_nevermore_second_attack_cooldown", caster, caster)
            end
    
        else
            SafeDestroyModifier("modifier_nevermore_second_attack_cooldown", caster, caster)
        end

        -- Effects
        self:PlayEffects(thinker_origin)
        

	    self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Graphics & Sounds
function modifier_nevermore_second_attack_thinker:PlayEffects(position)
    local caster = self:GetCaster()
    
    -- get resources
    local particle_cast = "particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf"
    local sound_cast = "Hero_Nevermore.Shadowraze"

    -- create particle
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect_cast, 0, position)
    ParticleManager:SetParticleControl(effect_cast, 1, Vector(self.radius, 1, 1))
    ParticleManager:ReleaseParticleIndex(effect_cast)
    
    -- create sound
    EmitSoundOnLocationWithCaster(position, sound_cast, caster)
end
    