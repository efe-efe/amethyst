modifier_pango_mobility = class({})

function modifier_pango_mobility:OnCreated()
    self.speed_buff_pct = self:GetAbility():GetSpecialValueFor("speed_buff_pct")
    if IsServer() then
        self.radius = self:GetAbility():GetSpecialValueFor("radius")
        self.parent = self:GetParent()
        self.distance = self.radius * 1.5
        local origin = self.parent:GetAbsOrigin()
        self.damage_table = {
            attacker = self.parent,
            damage = self:GetAbility():GetSpecialValueFor("ability_damage"),
            damage_type = DAMAGE_TYPE_PURE,
        }

		self.efx = EFX("particles/units/heroes/hero_pangolier/pangolier_gyroshell.vpcf", PATTACH_CUSTOMORIGIN, self.parent, {
            cp0 = {
                ent = self.parent,
                point = 'attach_hitloc'
            }
        })

        EFX("particles/storm/storm_ex_mobility_strike.vpcf", PATTACH_WORLDORIGIN, nil, {
            cp0 = origin,
            cp1 = origin + Vector(0, 0, 1000),
            cp2 = origin,
            release = true
        })

        EFX("particles/units/heroes/hero_lion/lion_spell_voodoo.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent, {
            release = true
        })

        self.parent:StartGestureWithPlaybackRate(ACT_DOTA_RUN, 1.0)
        EmitSoundOn("Hero_Pangolier.Gyroshell.Loop", self.parent)
        EmitSoundOn("Hero_Juggernaut.Attack", self.parent)

        self:StartIntervalThink(0.1)
        CustomEntitiesLegacy:DeactivateNonPriorityAbilities(self.parent)
    end
end

function modifier_pango_mobility:OnIntervalThink()
    CustomEntitiesLegacy:DeactivateNonPriorityAbilities(self.parent)
    local parent_origin = self.parent:GetAbsOrigin()

    ApplyCallbackForUnitsInArea(self.parent, parent_origin, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)
        local direction = (unit:GetAbsOrigin() - parent_origin):Normalized()

        if not unit:HasModifier("modifier_pango_mobility_displacement") and not unit:HasModifier("modifier_pango_mobility_marker") then
            unit:AddNewModifier(unit, self:GetAbility(), "modifier_pango_mobility_displacement", { 
                x = direction.x,
                y = direction.y,
                r = self.distance,
                speed = self.distance/0.3,
                peak = 150,
            })
            unit:AddNewModifier(unit, self:GetAbility(), "modifier_pango_mobility_marker", { duration = 1.0 })
            
            self.damage_table.victim = unit
            ApplyDamage(self.damage_table)
            EmitSoundOn("Hero_Pangolier.Gyroshell.Stun", unit)
        end
    end)
end

function modifier_pango_mobility:OnDestroy()
	if IsServer() then

        ParticleManager:DestroyParticle(self.efx, false)
		ParticleManager:ReleaseParticleIndex(self.efx)
        StopSoundOn("Hero_Pangolier.Gyroshell.Loop", self.parent)
        self.parent:RemoveGesture(ACT_DOTA_RUN)
        self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_pango_roll_end_animation", { duration = 0.3 })
        CustomEntitiesLegacy:SetAllAbilitiesActivated(self.parent, true)
	end
end

function modifier_pango_mobility:CheckState()
    return {
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }
end

function modifier_pango_mobility:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ORDER,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
        MODIFIER_PROPERTY_MODEL_CHANGE,
    }
end 


function modifier_pango_mobility:OnOrder(params)
	if params.unit == self.parent then
		if params.order_type == DOTA_UNIT_ORDER_STOP or params.order_type == DOTA_UNIT_ORDER_HOLD_POSITION then
			self:Destroy()
		end
	end
end

function modifier_pango_mobility:GetModifierModelChange()
	return "models/heroes/pangolier/pangolier_gyroshell2.vmdl"
end
function modifier_pango_mobility:GetOverrideAnimation()
	return ACT_DOTA_OVERRIDE_ABILITY_4
end

function modifier_pango_mobility:GetModifierMoveSpeedBonus_Percentage()
    return self.speed_buff_pct
end

function modifier_pango_mobility:GetStatusLabel() return "Rolling Thunder" end
function modifier_pango_mobility:GetStatusPriority() return 4 end
function modifier_pango_mobility:GetStatusStyle() return "RollingThunder" end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Animation(modifier_pango_mobility)
Modifiers.Status(modifier_pango_mobility)
Modifiers.MoveForced(modifier_pango_mobility)