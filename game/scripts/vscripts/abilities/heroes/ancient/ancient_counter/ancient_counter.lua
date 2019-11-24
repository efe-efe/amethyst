ancient_counter = class({})
LinkLuaModifier( "modifier_ancient_counter_recast", "abilities/heroes/ancient/ancient_counter/modifier_ancient_counter_recast", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ancient_basic_attack", "abilities/heroes/ancient/ancient_basic_attack/modifier_ancient_basic_attack", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function ancient_counter:OnCastPointEnd()
    local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")

    caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
        "modifier_counter", 
		{ 
            activity = ACT_DOTA_CAST_ABILITY_3,
            rate = 0.4,
            movement_speed = 0,
            duration = duration, 
            destroy_on_trigger = 1,
        }
    )
end

function ancient_counter:OnTrigger()
	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor("radius")
	local recast_duration = self:GetSpecialValueFor("recast_duration")
    local ability = caster:FindAbilityByName("ancient_basic_attack")

    local enemies = caster:FindUnitsInRadius(
        caster:GetOrigin(), 
        radius, 
        DOTA_UNIT_TARGET_TEAM_ENEMY, 
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER
    )
    
    for _,enemy in pairs(enemies) do
        local direction = (enemy:GetOrigin() - caster:GetOrigin()):Normalized()
        local distance = radius - (enemy:GetOrigin() - caster:GetOrigin()):Length2D()

        enemy:AddNewModifier(
            caster, -- player source
            self, -- ability source
            "modifier_generic_displacement", -- modifier name
            {
                x = direction.x,
                y = direction.y,
                r = distance,
                speed = 1200,
                peak = 50,
                restricted = 1,
            } -- kv
        )
    end

    caster:AddNewModifier(caster, self, "modifier_ancient_counter_recast", { duration = recast_duration })
    caster:AddNewModifier(caster, ability, "modifier_ancient_basic_attack", {})

	ScreenShake(caster:GetOrigin(), 100, 300, 0.45, 1000, 0, true)
    self:PlayEffectsOnTrigger( radius )
end

function ancient_counter:PlayEffectsOnTrigger( radius )
    EmitSoundOn("Hero_Ancient_Apparition.ChillingTouch.Target", self:GetCaster())

	local particle_cast = "particles/techies_blast_off_ringmodel.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )

	particle_cast = "particles/econ/items/ancient_apparition/aa_blast_ti_5/ancient_apparition_ice_blast_initial_explode_ti5.vpcf"
    effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 3, self:GetCaster():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
    
	particle_cast = "particles/units/heroes/hero_ogre_magi/ogre_magi_unr_fireblast.vpcf"
    effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 1, self:GetCaster():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
    ancient_counter,
    nil, 
	{ movement_speed = 100 }
)