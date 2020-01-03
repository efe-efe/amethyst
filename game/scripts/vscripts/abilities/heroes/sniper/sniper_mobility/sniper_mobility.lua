sniper_mobility = class({})
LinkLuaModifier( "modifier_sniper_mobility_thinker", "abilities/heroes/sniper/sniper_mobility/modifier_sniper_mobility_thinker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_shrapnel_thinker_lua", "abilities/heroes/sniper/sniper_shared_modifiers/modifier_sniper_shrapnel_thinker_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function sniper_mobility:OnCastPointEnd()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local min_range = self:GetSpecialValueFor("min_range")
	local point = CalcRange(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), min_range)
    local shrapnel = caster:FindAbilityByName("sniper_special_attack")

	local direction = (point - origin):Normalized()
	local distance = (point - origin):Length2D()
	local radius = self:GetSpecialValueFor("radius")

    --Knockback
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
        } -- kv
	)

	CreateModifierThinker(
		caster, --hCaster
		shrapnel, --hAbility
		"modifier_thinker_indicator", --modifierName
		{ 
			thinker = "modifier_sniper_shrapnel_thinker_lua",
			show_all = 1,
			radius = radius,
			delay_time = shrapnel:GetSpecialValueFor( "delay_time" ),
			thinker_duration = shrapnel:GetSpecialValueFor( "duration" ),
		}, --paramTable
		caster:GetOrigin(), --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)

    self:PlayEffectsOnCast()
end

function sniper_mobility:PlayEffectsOnCast()
	EmitSoundOn( "Hero_Techies.LandMine.Detonate", self:GetCaster() )	
    -- Cast particle
    local particle_cast = "particles/econ/courier/courier_cluckles/courier_cluckles_ambient_rocket_explosion.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 3, self:GetCaster():GetOrigin())
    ParticleManager:ReleaseParticleIndex( effect_cast )  
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	sniper_mobility,
	{ activity = ACT_DOTA_CAST_ABILITY_1, rate = 2.0 },
	{ movement_speed = 10 }
)