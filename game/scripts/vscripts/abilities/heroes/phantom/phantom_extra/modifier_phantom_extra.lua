modifier_phantom_extra = class({})
LinkLuaModifier( "modifier_phantom_extra_visuals", "abilities/heroes/phantom/phantom_extra/modifier_phantom_extra_visuals", LUA_MODIFIER_MOTION_HORIZONTAL )

function modifier_phantom_extra:OnCreated(params)
    self.movement_speed_pct = self:GetAbility():GetSpecialValueFor("movement_speed_pct")
    
    if IsServer() then
        self.ability = self:GetParent():FindAbilityByName("phantom_extra_mobility")
        self.max_stacks = self:GetAbility():GetSpecialValueFor("max_stacks")
        self.effects_cast = {}
        self.casting = false
        self.counter = 0
        self.counter_b = 0

        self:StartIntervalThink(0.2)
        self:OnIntervalThink()

        self:SetStackCount(0)

        self:GetParent():AddStatusBar({
            label = "Charging", 
            modifier = self, 
            priority = 3, 
            type = "stack",
            maxStacks = self.max_stacks
        }) 
        self:GetParent():AddRecastVisual({
            key = "R",
            modifier = self,
            abilityName = self:GetAbility():GetName(),
            maxStacks = self.max_stacks,
            type = "stack"
        })
        self:PlayEffectsWeapon()
        self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_phantom_extra_visuals", { duration = 0.2 })
    end
end

function modifier_phantom_extra:OnDestroy()
    if IsServer() then
        self:GetAbility():StartCooldown(self:GetAbility():GetCooldown(0))
        self:GetParent():SwapAbilities( 
            "phantom_extra",
            "phantom_extra_mobility",
            true,
            false
        )
        self:StopEffects()
    end
end

function modifier_phantom_extra:OnIntervalThink()
    self:PlayEffects(self.counter)
    self.counter = self.counter + 1 

    if self:GetStackCount() < self.max_stacks then
        self:IncrementStackCount()
    elseif self:GetStackCount() == self.max_stacks and self.casting == false then
        if not self:GetParent():HasModifier("modifier_phantom_banish") then
            self:GetParent():CastAbilityImmediately(self.ability, self:GetParent():GetEntityIndex())
            self.casting = true
        else
            self:Destroy()
        end
    end
    
    if self.counter_b == 4 then 
        self:PlayEffectsWeapon() 
        self.counter_b = 0
        self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_phantom_extra_visuals", { duration = 0.2 })
    else 
        self.counter_b = self.counter_b + 1
    end


    self:PlayEffectsAoe()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_phantom_extra:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_EVENT_ON_ORDER,
	}

	return funcs
end

function modifier_phantom_extra:OnOrder(params)
	if params.unit == self:GetParent() then
		if 	params.order_type == DOTA_UNIT_ORDER_HOLD_POSITION then
			self:Destroy()
		end
	end
end

function modifier_phantom_extra:GetModifierMoveSpeedBonus_Percentage()
    return - (100 - self.movement_speed_pct)
end

--------------------------------------------------------------------------------
-- Graphics & sounds
function modifier_phantom_extra:PlayEffects(index)
    local particle_cast = "particles/mod_units/heroes/hero_phantom_assassin/phantom_assassin_active_blur_smoke_light.vpcf"
    self.effects_cast[index] = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
end

function modifier_phantom_extra:PlayEffectsWeapon()
    EmitSoundOn("Hero_Rubick.Telekinesis.Cast", self:GetParent())

    local particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_death_lines.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_CUSTOMORIGIN, self:GetParent() )
    ParticleManager:SetParticleControlEnt( 
        effect_cast, 
        0, 
        self:GetParent(), 
        PATTACH_POINT_FOLLOW, 
        "attach_attack1", 
        self:GetParent():GetOrigin(), 
        true 
    )
    ParticleManager:SetParticleControlEnt( 
        effect_cast, 
        3, 
        self:GetParent(), 
        PATTACH_POINT_FOLLOW, 
        "attach_attack1", 
        self:GetParent():GetOrigin(), 
        true 
    )
end

function modifier_phantom_extra:PlayEffectsAoe()
    local particle_cast = "particles/aoe_marker.vpcf"

    local effect_cast = ParticleManager:CreateParticleForPlayer( particle_cast, PATTACH_WORLDORIGIN, nil, self:GetParent():GetPlayerOwner() )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin())
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.ability:GetCastRange(Vector(0,0,0), nil), 1, 1 ) )
    ParticleManager:SetParticleControl( effect_cast, 2, Vector( 255, 1, 1 ) )
    ParticleManager:SetParticleControl( effect_cast, 3, Vector(0.1, 0, 0) )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_phantom_extra:StopEffects()
    for _,effect in pairs(self.effects_cast) do
        ParticleManager:DestroyParticle(effect, false)
        ParticleManager:ReleaseParticleIndex(effect)
    end
end