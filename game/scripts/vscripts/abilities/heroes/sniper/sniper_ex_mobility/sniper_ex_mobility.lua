sniper_ex_mobility = class({})
LinkLuaModifier( "modifier_sniper_ex_mobility_thinker", "abilities/heroes/sniper/sniper_ex_mobility/modifier_sniper_ex_mobility_thinker", LUA_MODIFIER_MOTION_NONE )

function sniper_ex_mobility:HasPriority()
    return true
end

function sniper_ex_mobility:OnCastPointEnd()
    local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local min_range = self:GetSpecialValueFor("min_range")
	local point = CalcRange(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), min_range)

    local radius = self:GetSpecialValueFor("radius")
    local duration = self:GetSpecialValueFor("duration")

	local direction = (point - origin):Normalized()
	local distance = (point - origin):Length2D()

    CreateModifierThinker(
        caster, --hCaster
        self, --hAbility
        "modifier_sniper_ex_mobility_thinker", --modifierName
        { duration = duration }, --paramTable
		caster:GetOrigin(), --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
        false --bPhantomBlocker
    )

    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_generic_displacement", -- modifier name
        {
            x = direction.x,
            y = direction.y,
            r = distance,
            speed = (distance/0.5),
            peak = 400,
            i_frame = 1
        } -- kv
    )


    
    local enemies = caster:FindUnitsInRadius( 
        origin, 
        radius, 
        DOTA_UNIT_TARGET_TEAM_ENEMY, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER
    )

    for _,enemy in pairs(enemies) do

        local tinker_direction = (point - enemy:GetOrigin()):Normalized()

        enemy:AddNewModifier(
            caster, -- player source
            self, -- ability source
            "modifier_generic_knockback", -- modifier name
            { 
                duration = 0.2,
                distance = 100,
                z = 50,
                x = tinker_direction.x,
                y = tinker_direction.y,
                disable = 1,
                stun = 1,
            } -- kv
        )
    end

    self:PlayEffects()
end

--------------------------------------------------------------------------------
function sniper_ex_mobility:PlayEffects()
    EmitSoundOn( "Hero_Techies.LandMine.Detonate", self:GetCaster() )
    
    local particle_cast = "particles/econ/courier/courier_cluckles/courier_cluckles_ambient_rocket_explosion.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 3, self:GetCaster():GetOrigin())
    
    ParticleManager:ReleaseParticleIndex( effect_cast )    
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	sniper_ex_mobility,
	{ activity = ACT_DOTA_CAST_ABILITY_1, rate = 1.5 },
	{ movement_speed = 50 }
)