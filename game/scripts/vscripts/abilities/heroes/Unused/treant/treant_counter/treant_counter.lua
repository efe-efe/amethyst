treant_counter = class({})
LinkLuaModifier( "modifier_treant_leeching_seed", "abilities/heroes/treant/treant_shared_modifiers/modifier_treant_leeching_seed", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function treant_counter:OnCastPointEnd()
    --load data
    local caster = self:GetCaster()
    local duration = self:GetDuration()
    
    caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_counter", -- modifier name
		{ 
            movement_speed = 0,
            duration = duration, 
            destroy_on_trigger = 1,
            activity = ACT_DOTA_CAST_ABILITY_4,
            rate = 0.4
        } -- kv
    )
end

--------------------------------------------------------------------------------
-- On Trigger
function treant_counter:OnTrigger( params )
    local caster = self:GetCaster()
    local radius = self:GetSpecialValueFor("radius")
    local root_duration = self:GetSpecialValueFor("root_duration")
    local leeching_duration =self:GetSpecialValueFor("leeching_duration")

    -- Find enemies
    local enemies = FindUnitsInRadius( 
        caster:GetTeamNumber(), -- int, your team number
        caster:GetOrigin(), -- point, center point
        nil, -- handle, cacheUnit. (not known)
        radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
        DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
        0, -- int, flag filter
        0, -- int, order filter
        false -- bool, can grow cache
    )

    for _,enemy in pairs(enemies) do
        enemy:AddNewModifier(
            caster, 
            self, 
            "modifier_generic_root", 
            { duration = root_duration }
        )
        enemy:AddNewModifier(
            caster, -- player source
            self, -- ability source
            "modifier_treant_leeching_seed", -- modifier name
            { duration = leeching_duration } -- kv
        )
    end

    CreateRadiusMarker(caster, caster:GetOrigin(), { 
        show_all = 1,
        radius = radius,
    })

    self:PlayEffectsOnTrigger()
end

--------------------------------------------------------------------------------
-- Graphics & Sounds
function treant_counter:PlayEffectsOnTrigger()
    local caster = self:GetCaster()
    -- Create Sound
    EmitSoundOn( "Hero_Treant.LeechSeed.Target" , self:GetCaster())

    -- Create Particles
    local effect_cast = ParticleManager:CreateParticle("particles/units/heroes/hero_treant/treant_overgrowth_cast_growing_wood.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster )
    ParticleManager:ReleaseParticleIndex( effect_cast )

    local effect_cast_b = ParticleManager:CreateParticle("particles/econ/items/monkey_king/arcana/death/mk_spring_arcana_death_souls.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster )
    ParticleManager:SetParticleControl( effect_cast_b, 0, caster:GetOrigin())
    ParticleManager:SetParticleControl( effect_cast_b, 1, caster:GetOrigin())
    ParticleManager:SetParticleControl( effect_cast_b, 3, caster:GetOrigin())    
    ParticleManager:ReleaseParticleIndex( effect_cast_b )
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
    treant_counter,
    nil, 
	{ movement_speed = 0 }
)