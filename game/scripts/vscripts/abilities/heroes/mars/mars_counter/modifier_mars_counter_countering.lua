modifier_mars_counter_countering = class({})

function modifier_mars_counter_countering:OnCreated(params)
    if IsServer() then
        self:GetParent():StartGesture(ACT_DOTA_OVERRIDE_ABILITY_3)
        self.effect_cast = ParticleManager:CreateParticle("particles/units/heroes/hero_mars/mars_arena_of_blood_heal.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())

        self:StartIntervalThink(0.03)
    end
end

function modifier_mars_counter_countering:OnDestroy()
    if IsServer() then
        ParticleManager:DestroyParticle(self.effect_cast, false)
        ParticleManager:ReleaseParticleIndex(self.effect_cast)

        local effect_cast = ParticleManager:CreateParticle("particles/econ/items/ogre_magi/ogre_ti8_immortal_weapon/ogre_ti8_immortal_bloodlust_buff_circle_outer_pulse.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
        ParticleManager:ReleaseParticleIndex(effect_cast)
    end
end

function modifier_mars_counter_countering:OnIntervalThink()
    local mouse = self:GetAbility():GetCursorPosition()
	local direction = (mouse - self:GetParent():GetAbsOrigin()):Normalized()

	self:GetParent():FaceTowardsCustom(Vector(direction.x, direction.y, self:GetParent():GetForwardVector().z))
end

function modifier_mars_counter_countering:OnTrigger(params)   
    if IsServer() then
        self:PlayEffectsOnTrigger()
    end
end


function modifier_mars_counter_countering:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_ABILITY_EXECUTED,
        MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS
    }
end

function modifier_mars_counter_countering:GetActivityTranslationModifiers(params)
    return "bulwark"
end

function modifier_mars_counter_countering:OnAbilityExecuted(params)
    if IsServer() then
        if params.unit ~= self:GetParent() then
            return
        end

        if params.ability ~= self:GetParent():FindAbilityByName("spectre_counter_recast") then
            self:Destroy()
        end
    end
end

function modifier_mars_counter_countering:OnOrder(params)
    if params.unit == self:GetParent() then
        if  params.order_type == DOTA_UNIT_ORDER_STOP or 
            params.order_type == DOTA_UNIT_ORDER_HOLD_POSITION
        then
            self:Destroy()
        end
    end
end

function modifier_mars_counter_countering:PlayEffectsOnTrigger()
    EmitSoundOn("Hero_Mars.Shield.Block", self:GetParent())
    EmitSoundOn("Hero_Mars.Block_Projectile", self:GetParent())
    
	local effect_cast =  ParticleManager:CreateParticle("particles/units/heroes/hero_mars/mars_shield_of_mars.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControlForward(effect_cast, 0, self:GetParent():GetForwardVector())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function modifier_mars_counter_countering:GetStatusEffectName()
    return "particles/econ/items/effigies/status_fx_effigies/status_effect_effigy_gold_lvl2_dire.vpcf"
end

function modifier_mars_counter_countering:GetMovementSpeedPercentage() return 50 end
function modifier_mars_counter_countering:UseDefaultVisuals() return false end
function modifier_mars_counter_countering:GetTranslation() return "bulwark" end

function modifier_mars_counter_countering:OnProjectileHitCustom(params)
	if IsServer() then
		local projectile = params.projectile

		
        if projectile.bIsReflectable == true then
            local direction = projectile:GetVelocity():Normalized() 
            local projection = direction.x * self:GetParent():GetForwardVector().x + direction.y * self:GetParent():GetForwardVector().y

            if projection <= -0.9 then
                projectile:SetVelocity(projectile:GetVelocity() * -1, projectile:GetPosition())
                projectile:SetSource(self:GetParent())
                projectile:SetVisionTeam(self:GetParent():GetTeam())
                projectile:ResetDistanceTraveled()
                projectile:ResetRehit()
                self:OnTrigger({})
                
                return false
            end
		end

		return true
	end
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Counter(modifier_mars_counter_countering)
Modifiers.OnProjectileHit(modifier_mars_counter_countering)
--Modifiers.Translate(modifier_mars_counter_countering)