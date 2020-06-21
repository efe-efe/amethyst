modifier_mars_ultimate_thinker = class({})

function modifier_mars_ultimate_thinker:IsAura()
	return self:IsInitialized()
end
function modifier_mars_ultimate_thinker:GetModifierAura()
	return "modifier_mars_ultimate_area_check"
end
function modifier_mars_ultimate_thinker:GetAuraRadius()
	return self.radius
end
function modifier_mars_ultimate_thinker:GetAuraDuration()
	return 0.0
end
function modifier_mars_ultimate_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_BOTH
end
function modifier_mars_ultimate_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_mars_ultimate_thinker:OnCreated(params)
    self.radius = self:GetAbility():GetSpecialValueFor("radius")

    EmitSoundOn("Hero_Mars.ArenaOfBlood", self:GetParent())
end
    
function modifier_mars_ultimate_thinker:OnDestroy()
    if IsServer() then
        EmitSoundOn("Hero_Mars.ArenaOfBlood.End", self:GetParent())
        self:StopEffects()
    end
end

function modifier_mars_ultimate_thinker:OnDelayEnds()
    if IsServer() then
        self:PlayEffectsOnCreated()
        EmitSoundOn("Hero_Mars.ArenaOfBlood.Start", self:GetParent())

        local caster = self:GetCaster()
        local origin = self:GetParent():GetAbsOrigin()
        local vector = origin + Vector(self.radius, 0, 0)
        local count = 32

        local angle_diff = 360/count

        for i = 0, count - 1 do
            local location = RotatePosition(origin, QAngle(0, angle_diff * i, 0), vector)
            local direction = RotatePosition(Vector(0,0,0), QAngle(0, 200 + angle_diff * i, 0), Vector(1,0,0))

            -- callback after creation
            local callback = function(unit)
                unit:SetForwardVector(direction)
                unit:SetNeverMoveToClearSpace(true)

                -- add modifier
                unit:AddNewModifier(
                    caster, -- player source
                    self:GetAbility(), -- ability source
                    "modifier_mars_ultimate_soldier", -- modifier name
                    {
                        duration = self:GetDuration(),
                        model = i % 2 == 0,
                        x = origin.x,
                        y = origin.y
                    } -- kv
                )
            end

            -- create unit async (to avoid high think time)
            local unit = CreateUnitByNameAsync(
                "npc_dota_mars_ultimate_soldier",
                location,
                false,
                caster,
                nil,
                caster:GetTeamNumber(),
                callback
            )
        end
    end
end

function modifier_mars_ultimate_thinker:PlayEffectsOnCreated()
    local particle_cast = "particles/units/heroes/hero_mars/mars_arena_of_blood.vpcf"
	self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, self:GetParent())	
	ParticleManager:SetParticleControl(self.effect_cast, 2, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(self.radius, 1, 1))
end

function modifier_mars_ultimate_thinker:StopEffects()
	ParticleManager:DestroyParticle(self.effect_cast, false)
	ParticleManager:ReleaseParticleIndex(self.effect_cast)
end
    
function modifier_mars_ultimate_thinker:GetDelayTime()
    return self:GetAbility():GetCastPoint()
end

function modifier_mars_ultimate_thinker:GetAOERadius()
    return self:GetAbility():GetSpecialValueFor("radius")
end

if IsClient() then require("wrappers/modifiers") end
Modifiers.Thinker(modifier_mars_ultimate_thinker)