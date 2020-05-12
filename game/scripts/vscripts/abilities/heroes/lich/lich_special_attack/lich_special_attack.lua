lich_special_attack = class({})
LinkLuaModifier( "modifier_lich_special_attack_thinker", "abilities/heroes/lich/lich_special_attack/modifier_lich_special_attack_thinker", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function lich_special_attack:OnCastPointEnd()
	-- unit identifier
	local caster = self:GetCaster()
	local point = CalcPoint(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)

    self:CreateShard(point, nil)
end

function lich_special_attack:CreateShard( origin, knockback )
    local caster = self:GetCaster()
    local radius = self:GetSpecialValueFor( "radius" )
    local delay_time = self:GetSpecialValueFor( "delay_time" )

    CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_thinker_indicator", --modifierName
		{ 
			thinker = "modifier_lich_special_attack_thinker",
			show_all = 1,
			radius = radius,
            delay_time = delay_time,
            extra_one = knockback
		}, --paramTable
		origin, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)
end

function lich_special_attack:ConsumeDebuffs( base_damage, origin, radius, knockback )
    local caster = self:GetCaster()
	local heal = self:GetSpecialValueFor( "heal" )
	local extra_damage = self:GetSpecialValueFor( "extra_damage" )
	local silence_duration = self:GetSpecialValueFor( "silence_duration" )
	local fading_slow_duration = self:GetSpecialValueFor( "fading_slow_duration" )
    local mana_gain_pct = self:GetSpecialValueFor( "mana_gain_pct" )/100
    local m_radius = radius or self:GetSpecialValueFor("radius")
	
    -- find enemies
    local enemies = FindUnitsInRadius( 
        caster:GetTeamNumber(), -- int, your team number
        origin, -- point, center point
        nil, -- handle, cacheUnit. (not known)
        m_radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
        DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
        0, -- int, flag filter
        0, -- int, order filter
        false -- bool, can grow cache
    )

    local damageTable = {
        attacker = caster,
        damage_type = DAMAGE_TYPE_PURE,
        ability = self, --Optional.
    }

    for _,enemy in pairs(enemies) do
        local final_damage = base_damage
        
        if enemy:HasModifier("modifier_lich_decay") then
            final_damage = final_damage + extra_damage
            enemy:AddNewModifier(caster, self, "modifier_generic_silence", { duration = silence_duration })
            SafeDestroyModifier("modifier_lich_decay", enemy, caster)
        end

        if enemy:HasModifier("modifier_lich_frost") then
            caster:Heal(heal, caster)
            enemy:AddNewModifier(caster, self, "modifier_generic_fading_slow", { duration = fading_slow_duration })
            SafeDestroyModifier("modifier_lich_frost", enemy, caster)
        end


        if knockback then
            local direction = (enemy:GetOrigin() - origin):Normalized()

            enemy:AddNewModifier(caster, self, "modifier_generic_knockback", {
                distance = self:GetSpecialValueFor("knockback_distance"),
                x = direction.x,
                y = direction.y,
                duration = 0.3,
            })

        end

        -- damage
        damageTable.victim = enemy
        damageTable.damage = final_damage
        ApplyDamage(damageTable)
    end
    
    -- if at least 1 enemy
    if #enemies > 0 then
        -- Give Mana
        local mana_gain_final = self:GetCaster():GetMaxMana() * mana_gain_pct
        self:GetCaster():GiveMana(mana_gain_final)    
    end
    
    if knockback then
        self:PlayEffectsKnockback( m_radius, origin )
    end
	self:PlayEffectsOnConsumeDebuffs(m_radius, origin)
end

function lich_special_attack:PlayEffectsOnConsumeDebuffs( radius, origin )
    local caster = self:GetCaster()
    EmitSoundOn( "Ability.FrostNova" , caster )

    -- Create particles
    local particle_cast = "particles/econ/items/lich/frozen_chains_ti6/lich_frozenchains_frostnova.vpcf"
    
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, origin )
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( 1, 1, radius ) )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

function lich_special_attack:PlayEffectsKnockback(radius, origin)
    -- Create particles
    local particle_cast = "particles/econ/items/death_prophet/death_prophet_ti9/death_prophet_silence_ti9.vpcf"

    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, origin )
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, 0, 0 ) )
    ParticleManager:SetParticleControl( effect_cast, 5, origin )
    ParticleManager:SetParticleControl( effect_cast, 6, origin )
    ParticleManager:ReleaseParticleIndex( effect_cast )
    
end


if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	lich_special_attack,
	{ activity = ACT_DOTA_CAST_ABILITY_2, rate = 1.0 },
	{ movement_speed = 10 }
)