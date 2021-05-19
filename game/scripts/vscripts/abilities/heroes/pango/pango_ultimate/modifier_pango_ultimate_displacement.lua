modifier_pango_ultimate_displacement = class({})

function modifier_pango_ultimate_displacement:OnCreated()
    if IsServer() then
        self.parent = self:GetParent()
        self.bounces = 5
        self.distance = 250
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

        EFX("particles/units/heroes/hero_lion/lion_spell_voodoo.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent, {
            release = true
        })

        self.parent:StartGestureWithPlaybackRate(ACT_DOTA_RUN, 1.0)
        EmitSoundOn("Hero_Pangolier.Gyroshell.Loop", self.parent)
    end
end

function modifier_pango_ultimate_displacement:OnDestroy()
	if IsServer() then
        ParticleManager:DestroyParticle(self.efx, false)
		ParticleManager:ReleaseParticleIndex(self.efx)
        StopSoundOn("Hero_Pangolier.Gyroshell.Loop", self.parent)
        self.parent:RemoveGesture(ACT_DOTA_RUN)
        self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_pango_roll_end_animation", { duration = 0.3 })
        self.parent:SetAllAbilitiesActivated(true)
	end
end


function modifier_pango_ultimate_displacement:OnCollide(params)
    if IsServer() then
        if params.type == UNIT_COLLISION then
            local parent_origin = self.parent:GetAbsOrigin()

            for _,unit in pairs(params.units) do
                local direction = (unit:GetAbsOrigin() - parent_origin):Normalized()

                if not unit:HasModifier("modifier_pango_mobility_displacement_enemy") then
                    unit:AddNewModifier(unit, self:GetAbility(), "modifier_pango_mobility_displacement_enemy", { 
                        x = direction.x,
                        y = direction.y,
                        r = self.distance,
                        speed = self.distance/0.4,
                        peak = 150,
                    })
                    
                    self.damage_table.victim = unit
                    ApplyDamage(self.damage_table)
                    EmitSoundOn("Hero_Pangolier.Gyroshell.Stun", unit)
                end
			end
        end

        if params.type == WALL_COLLISION then
            EmitSoundOn("Hero_Pangolier.Gyroshell.Carom", self.parent)
            if self.origin == self.prev_origin then
                self.parent:SetAbsOrigin(self.origin + self.direction * 200)
            end 
            self.distance =         self.distance
            self.speed =            self.speed * 0.75
            self.peak =             self.peak
            self.direction =        Vector(self.direction.x * (-1), self.direction.y * (-1), self.direction.z)
            
            self.origin =           self.parent:GetAbsOrigin()         
            self.prev_origin =      nil
    
            self.hVelocity =        self.speed
            self.vVelocity =        (-0.5) * self.gravity * self.duration
    
            self.elapsed_time =      0
            self.motion_tick =       {}
            self.motion_tick[0] =    0
            self.motion_tick[1] =    0
            self.motion_tick[2] =    0
            
            self.bounces = self.bounces - 1

            if self.bounces <= 0 then
                self:Destroy()
            end
		end
	end
end

function modifier_pango_ultimate_displacement:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
        MODIFIER_PROPERTY_MODEL_CHANGE,
	}
end

function modifier_pango_ultimate_displacement:GetOverrideAnimation() 		return ACT_DOTA_OVERRIDE_ABILITY_4 end
function modifier_pango_ultimate_displacement:GetOverrideAnimationRate() 	return 1.5 end

function modifier_pango_ultimate_displacement:CheckState()
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_pango_ultimate_displacement:GetModifierModelChange()
	return "models/heroes/pangolier/pangolier_gyroshell2.vmdl"
end

function modifier_pango_ultimate_displacement:GetCollisionTeamFilter()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Displacement(modifier_pango_ultimate_displacement)
Modifiers.Animation(modifier_pango_ultimate_displacement)