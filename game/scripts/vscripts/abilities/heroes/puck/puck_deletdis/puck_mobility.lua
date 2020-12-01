puck_deletedis = class({})
LinkLuaModifier("modifier_puck_deletedis_debuff", "abilities/heroes/puck/puck_deletedis/modifier_puck_deletedis_debuff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_puck_deletedis_displacement", "abilities/heroes/puck/puck_deletedis/modifier_puck_deletedis_displacement", LUA_MODIFIER_MOTION_BOTH)

function puck_deletedis:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	local min_range = self:GetSpecialValueFor("min_range")
	local point = ClampPosition(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), min_range)

	local direction = (point - origin):Normalized()
	local distance = (point - origin):Length2D()

    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_puck_deletedis_displacement", -- modifier name
        {
            x = direction.x,
            y = direction.y,
            r = distance,
            speed = (distance/1.0),
			peak = 250,
        }
   )

    local particle_cast = "particles/econ/items/mirana/mirana_ti8_immortal_mount/mirana_ti8_immortal_leap_start_embers.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster)
    ParticleManager:ReleaseParticleIndex(effect_cast)

    EmitSoundOn("puck_puck_laugh_01", caster)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(puck_deletedis)