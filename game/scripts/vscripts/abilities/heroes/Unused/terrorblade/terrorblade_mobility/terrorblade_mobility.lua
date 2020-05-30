terrorblade_mobility = class({})
LinkLuaModifier( "modifier_terrorblade_mobility_illusion", "abilities/heroes/terrorblade/terrorblade_mobility/modifier_terrorblade_mobility_illusion", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_terrorblade_mobility_recast", "abilities/heroes/terrorblade/terrorblade_mobility/modifier_terrorblade_mobility_recast", LUA_MODIFIER_MOTION_NONE )

function terrorblade_mobility:OnCastPointEnd()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = Clamp(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)
	local name = caster:GetUnitName()
    local duration = self:GetSpecialValueFor("duration")

	local direction = (point - origin):Normalized()
	local distance = (point - origin):Length2D()

    local ability = caster:FindAbilityByName("terrorblade_mobility_recast")
    ability:SetIllusionIndex(self:IllusionLogic():GetEntityIndex())

    caster:AddNewModifier(caster, self, "modifier_terrorblade_mobility_recast", { duration = duration })
    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_generic_displacement", -- modifier name
        {
            x = direction.x,
            y = direction.y,
            r = distance,
            speed = 1800,
            peak = 50,
            colliding = 0,
            activity = ACT_DOTA_CAST_ABILITY_3,
            rate = 1.2,
        } -- kv
    )

    self:PlayEffectsOnCast()
end

function terrorblade_mobility:IllusionLogic()
    local caster = self:GetCaster()
    local illusion_duration = self:GetSpecialValueFor("duration")

    local illusion = CreateIllusions( caster, caster, {
        duration = illusion_duration,
        outgoing_damage = -100, 
        incoming_damage = 0,
    }, 1, 0, false, true )


    illusion[1]:AddNewModifier(caster, self, "modifier_terrorblade_mobility_illusion", {})

    return illusion[1]
end

function terrorblade_mobility:OnDisplacementEnd()
    self:StopEffects( origin )
end

function terrorblade_mobility:PlayEffectsOnCast()
    EmitSoundOn("Hero_Terrorblade.ConjureImage", self:GetCaster())

    local particle_cast = "particles/econ/events/ti7/force_staff_ti7.vpcf"
    self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, self:GetCaster())
end

function terrorblade_mobility:StopEffects()
    if self.effect_cast ~= nil then
        ParticleManager:DestroyParticle(self.effect_cast, false)
        ParticleManager:ReleaseParticleIndex(self.effect_cast)
    end
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	terrorblade_mobility,
	{ activity = ACT_DOTA_CAST_ABILITY_1, rate = 2.0 },
	{ movement_speed = 100 }
)