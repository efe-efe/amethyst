treant_ultimate = class({})
LinkLuaModifier( "modifier_treant_ultimate_movement", "abilities/heroes/treant/treant_ultimate/modifier_treant_ultimate_movement", LUA_MODIFIER_MOTION_HORIZONTAL )

--------------------------------------------------------------------------------
-- Ability Start
function treant_ultimate:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
    local cast_point = self:GetCastPoint()
    self.radius = self:GetSpecialValueFor("radius")
	
	-- Animation and pseudo cast point
	StartAnimation(caster, { 
		duration= cast_point + 0.1,
		translate = "odachi",
		activity = ACT_DOTA_CAST_ABILITY_5,
		rate = 1.0
	})
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point", { 
		duration = cast_point,
		can_walk = 0,
        no_target = 1,
        radius = self.radius,
        show_all = 1
    })
    
end

--------------------------------------------------------------------------------
-- Ability Start
function treant_ultimate:OnEndPseudoCastPoint( )
	-- unit identifier
	local caster = self:GetCaster()
    local delay_time = self:GetSpecialValueFor( "delay_time" )
    local root_duration = self:GetSpecialValueFor("root_duration")
    local damage = self:GetAbilityDamage()

    -- Find enemies
    local enemies = FindUnitsInRadius( 
        caster:GetTeamNumber(), -- int, your team number
        caster:GetOrigin(), -- point, center point
        nil, -- handle, cacheUnit. (not known)
        self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
        DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
        0, -- int, flag filter
        0, -- int, order filter
        false -- bool, can grow cache
    )


    for _,enemy in pairs(enemies) do
        local direction = (caster:GetOrigin() - enemy:GetOrigin()):Normalized()
        local r = (caster:GetOrigin() - enemy:GetOrigin()):Length2D()

        enemy:AddNewModifier(
            caster, 
            self, 
            "modifier_generic_rooted_lua", 
            { duration = root_duration }
        )
        enemy:AddNewModifier(
            caster, -- player source
            self, -- ability source
            "modifier_treant_ultimate_movement", -- modifier name
            { 
                x = direction.x,
                y = direction.y,
                r = r,
                speed = 100,
                duration = root_duration 
            } -- kv
        )

        local damage_table = {
            victim = enemy,
            attacker = caster,
            damage = damage,
            damage_type = DAMAGE_TYPE_PURE,
        }
        ApplyDamage( damage_table )

    end

    CreateRadiusMarker(caster, caster:GetOrigin(), { 
        show_all = 1,
        radius = self.radius,
    })

    self:PlayEffectsOnTrigger()
end


function treant_ultimate:PlayEffectsOnTrigger()
	EmitSoundOn("Hero_Treant.Overgrowth.Cast", self:GetCaster())


    local particle_cast_b = "particles/units/heroes/hero_treant/treant_overgrowth_cast.vpcf"
    local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:ReleaseParticleIndex( effect_cast_b )

    local particle_cast_c = "particles/units/heroes/hero_witchdoctor/witchdoctor_maledict.vpcf"
    local effect_cast_b = ParticleManager:CreateParticle( particle_cast_c, PATTACH_ABSORIGIN_FOLLOW, thinker )
    ParticleManager:ReleaseParticleIndex( effect_cast_b )
end