modifier_nevermore_mobility_displacement = class({})

function modifier_nevermore_mobility_displacement:OnCreated(params)
    self.mana_gain_pct = self:GetAbility():GetSpecialValueFor("mana_gain_pct")
    self.fading_slow_duration = self:GetAbility():GetSpecialValueFor("fading_slow_duration")
    self.fading_slow_pct = self:GetAbility():GetSpecialValueFor("fading_slow_pct")
    
    self.counter = 0
    self.damage_table = {
        attacker = self:GetParent(),
        damage = self:GetAbility():GetSpecialValueFor("ability_damage"),
        damage_type = DAMAGE_TYPE_PURE,
    }

    if IsServer() then
        local particle_cast = "particles/econ/items/shadow_fiend/sf_desolation/sf_desolation_scratch.vpcf"
        local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
        ParticleManager:SetParticleControl(effect_cast, 0, self:GetParent():GetAbsOrigin()) 
        ParticleManager:ReleaseParticleIndex(effect_cast)
    end
end

function modifier_nevermore_mobility_displacement:OnDestroy()
    if IsServer() then
        self:GetParent():StartGestureWithPlaybackRate(ACT_DOTA_TELEPORT_END, 2.0)
        self:PlayEffectsOnDestroy()


    end
end

function modifier_nevermore_mobility_displacement:OnCollide(params)
	if IsServer() then
		if params.type == UNIT_COLLISION then
            for _,unit in pairs(params.units) do
                if not unit:HasModifier("modifier_nevermore_mobility_hit") then
                    self.counter = self.counter + 1
                    self.damage_table.victim = unit
                    
                    ApplyDamage(self.damage_table)
    
                    if not unit:IsObstacle() then
                        local is_amethyst = false
                        if unit.GetParentEntity then
                            local entity = unit:GetParentEntity()
                    
                            if instanceof(entity, Amethyst) then 
                                is_amethyst = true
                            end
                        end

                        if not is_amethyst then
                            local modifier = self:GetParent():FindModifierByName('modifier_nevermore_souls')
                            for i = 0, 1 do
                                self:PlayEffectsOnImpact(unit)
                                modifier:IncrementStackCount()
                            end
                        end
                        if self.counter == 1 then
                            if unit:ProvidesMana() then
                                self:GetParent():GiveManaAndEnergyPercent(self.mana_gain_pct, true)
                            end
                        end
                    end
                    
                    unit:AddNewModifier(self:GetParent(), self, "modifier_nevermore_mobility_hit", { duration = 1.0 })
                    unit:AddNewModifier(self:GetParent(), self, "modifier_generic_fading_slow", { 
                        duration = self.fading_slow_duration,
                        max_slow_pct = self.fading_slow_pct
                    })
                end
            end
		end
	end
end

function modifier_nevermore_mobility_displacement:GetCollisionTeamFilter()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_nevermore_mobility_displacement:GetOnThinkCallback()
    self:PlayEffectsOnDestroy()
end

function modifier_nevermore_mobility_displacement:PlayEffectsOnDestroy()
    local particle_cast = "particles/nevermore/nevermore_mobility.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect_cast, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(effect_cast, 1, Vector(250, 1, 1))
    ParticleManager:ReleaseParticleIndex(effect_cast)
end

function modifier_nevermore_mobility_displacement:PlayEffectsOnImpact(hTarget)
    EmitSoundOn("Hero_Nevermore.ProjectileImpact", hTarget)

	local info = {
		Target = self:GetParent(),
		Source = hTarget,
		EffectName = "particles/units/heroes/hero_nevermore/nevermore_necro_souls.vpcf",
		iMoveSpeed = 400,
		vSourceLoc= hTarget:GetAbsOrigin(),                -- Optional
		bDodgeable = false,                                -- Optional
		bReplaceExisting = false,                         -- Optional
		flExpireTime = GameRules:GetGameTime() + 5,      -- Optional but recommended
		bProvidesVision = false,                           -- Optional
	}
	ProjectileManager:CreateTrackingProjectile(info)
end

function modifier_nevermore_mobility_displacement:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS
	}
end

function modifier_nevermore_mobility_displacement:GetOverrideAnimation() 		    return ACT_DOTA_FLAIL end
function modifier_nevermore_mobility_displacement:GetActivityTranslationModifiers() return "forcestaff_friendly" end

function modifier_nevermore_mobility_displacement:CheckState()
	return {
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Displacement(modifier_nevermore_mobility_displacement)
Modifiers.Animation(modifier_nevermore_mobility_displacement)