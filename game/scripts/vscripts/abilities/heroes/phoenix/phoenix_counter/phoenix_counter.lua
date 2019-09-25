phoenix_counter = class({})
LinkLuaModifier( "modifier_generic_rooted_lua", "abilities/generic/modifier_generic_rooted_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function phoenix_counter:OnSpellStart()
    --load data
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
    self.radius = self:GetSpecialValueFor("radius")
    local extra_radius = self:GetSpecialValueFor("extra_radius")
    local damage = self:GetAbilityDamage()

    if caster:HasModifier( "modifier_phoenix_mobility_movement" ) then
        self.radius = self.radius + extra_radius
    end

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
        enemy:AddNewModifier(
            caster,
            self,
            "modifier_generic_rooted_lua",
            { duration = duration }
        )

        local damage_table = {
            victim = enemy,
            attacker = caster,
            damage = damage,
            damage_type = DAMAGE_TYPE_MAGICAL,
        }

        ApplyDamage( damage_table )
    end

    self:PlayEffects()

    -- Put CD on the alternate of the ability
	local alternate_version = caster:FindAbilityByName("phoenix_ex_counter")
	alternate_version:StartCooldown(self:GetCooldown(0))
end

function phoenix_counter:PlayEffects()
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()

    EmitSoundOn("Hero_Phoenix.Death", caster)
    
	local particle_cast_b = "particles/econ/items/axe/axe_helm_shoutmask/axe_beserkers_call_owner_shoutmask.vpcf"
    local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_ABSORIGIN_FOLLOW, caster )
    ParticleManager:SetParticleControl( effect_cast_b, 0, origin )
    ParticleManager:SetParticleControl( effect_cast_b, 2, Vector( self.radius, 1, 1 ) )
    ParticleManager:ReleaseParticleIndex( effect_cast_b )

	local particle_cast_c = "particles/econ/items/monkey_king/arcana/fire/monkey_king_spring_arcana_fire.vpcf"
    local effect_cast_c = ParticleManager:CreateParticle( particle_cast_c, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast_c, 0, origin )
	ParticleManager:SetParticleControl( effect_cast_c, 1, Vector( self.radius, 1, 1 ) )
    ParticleManager:ReleaseParticleIndex( effect_cast_c )
end