lich_counter_mobility = class({})
LinkLuaModifier( "modifier_lich_special_attack_thinker", "abilities/heroes/lich/lich_special_attack/modifier_lich_special_attack_thinker", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function lich_counter_mobility:OnCastPointEnd()
    local caster = self:GetCaster()
    local radius = self:GetSpecialValueFor("radius")
    local knockback_distance = self:GetSpecialValueFor("knockback_distance")
	local point = CalcRange(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)
    local special_attack = caster:FindAbilityByName("lich_special_attack")

    SafeDestroyModifier("modifier_lich_banish", caster, caster)
    FindClearSpaceForUnit( caster, point , true )
    special_attack:ConsumeDebuffs( 0, caster:GetOrigin(), radius, true )

    -- find enemies
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
        local direction = (enemy:GetOrigin() - caster:GetOrigin()):Normalized()

        enemy:AddNewModifier(caster, self, "modifier_generic_knockback_lua", {
            distance = knockback_distance,
            x = direction.x,
            y = direction.y,
            duration = 0.3,
        })
    end

    CreateRadiusMarker(caster, caster:GetOrigin(), { 
        show_all = 1,
        radius = self.radius,
    })
    self:PlayEffectsOnTrigger()
end

--------------------------------------------------------------------------------
-- Graphics & Sounds
function lich_counter_mobility:PlayEffectsOnTrigger()
    local caster = self:GetCaster()
    -- Create sound
    EmitSoundOn( "Hero_Lich.IceAge", thinker )
    
    -- Create particles
	local particle_cast = "particles/units/heroes/hero_ancient_apparition/ancient_apparition_chilling_touch.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )
    ParticleManager:SetParticleControl( effect_cast, 1, Vector(1, self.radius, 1) )
    ParticleManager:ReleaseParticleIndex( effect_cast )

    
    ParticleManager:CreateParticle( "particles/econ/events/nexon_hero_compendium_2014/blink_dagger_end_nexon_hero_cp_2014.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster )
end

if IsClient() then require("abilities") end
Abilities.Initialize( 
    lich_counter_mobility,
    nil, 
	{ movement_speed = 0, hide_indicator = 1 }
)