axe_ex_second_attack = class({})
LinkLuaModifier( "modifier_axe_ex_second_attack_movement", "abilities/heroes/axe/axe_ex_second_attack/modifier_axe_ex_second_attack_movement", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_generic_stunned_lua", "abilities/generic/modifier_generic_stunned_lua", LUA_MODIFIER_MOTION_NONE )


function axe_ex_second_attack:IsHidden()
    return true
end

function axe_ex_second_attack:IsHiddenAbilityCastable()
    return true
end

function axe_ex_second_attack:GetAlternateVersion()
    return self:GetCaster():FindAbilityByName("axe_second_attack")
end

--------------------------------------------------------------------------------
-- Ability Start
function axe_ex_second_attack:OnSpellStart()
    if self:IsHiddenAbilityCastable()	then
        print("IsHiddenAbilityCastable")
    else
        print("NOT IsHiddenAbilityCastable")
    end

	-- Initialize bariables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
	
	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=0.4, activity=ACT_DOTA_TELEPORT_END, rate=1.3})
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point", { 
		duration = cast_point,
		can_walk = 0,
		no_target = 1
	})
end

--------------------------------------------------------------------------------
function axe_ex_second_attack:OnEndPseudoCastPoint( pos )
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()
    local radius = self:GetSpecialValueFor("radius")
    local knockback_distance = self:GetSpecialValueFor("knockback_distance")
    local damage = self:GetAbilityDamage()
    local stun_duration = self:GetSpecialValueFor("stun_duration")
    
    --Find enemies to damage
    local enemies = FindUnitsInRadius( 
        caster:GetTeamNumber(), -- int, your team number
        origin, -- point, center point
        nil, -- handle, cacheUnit. (not known)
        radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
        DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
        0, -- int, flag filter
        0, -- int, order filter
        false -- bool, can grow cache
    )

    for _,enemy in pairs(enemies) do
        --Knockback
        local x = enemy:GetOrigin().x - origin.x
        local y = enemy:GetOrigin().y - origin.y
        local difference = enemy:GetOrigin() - origin
        
        enemy:AddNewModifier(
            caster, -- player source
            self, -- ability source
            "modifier_axe_ex_second_attack_movement", -- modifier name
            {
                x = x,
                y = y,
                r = knockback_distance,
                speed = 2000,
            } -- kv
        )

        enemy:AddNewModifier(
            caster, -- player source
            self, -- ability source
            "modifier_generic_stunned_lua", -- modifier name
            { duration = stun_duration } -- kv
        )
        

        local damage = {
			victim = enemy,
			attacker = caster,
			damage = damage,
			damage_type = DAMAGE_TYPE_PURE,
		}

		ApplyDamage( damage )
    end

    self:PlayEffects()

    -- Put CD on the alternate version of the ability
	local alternate_version = caster:FindAbilityByName("axe_second_attack")
	alternate_version:StartCooldown(self:GetCooldown(0))

end

function axe_ex_second_attack:PlayEffects()
    local caster = self:GetCaster()
    -- Create sound
    local sound_cast = "Hero_EarthShaker.Totem"
    EmitSoundOn(sound_cast, caster)

    -- Create Particles
	local particle_cast = "particles/econ/items/earthshaker/earthshaker_arcana/earthshaker_arcana_echoslam_start_warp.vpcf"
    local particle_cast_b = "particles/econ/items/earthshaker/earthshaker_arcana/earthshaker_arcana_aftershock_v2_shockwave.vpcf"
    
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
    local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_ABSORIGIN, caster )

    ParticleManager:SetParticleControl( effect_cast, 0, caster:GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast_b, 0, caster:GetOrigin() )

    ParticleManager:ReleaseParticleIndex( effect_cast )
    ParticleManager:ReleaseParticleIndex( effect_cast_b )
end