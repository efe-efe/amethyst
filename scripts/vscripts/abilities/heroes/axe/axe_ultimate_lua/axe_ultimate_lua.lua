axe_ultimate_lua = class({})
LinkLuaModifier( "modifier_axe_ultimate_lua", "abilities/heroes/axe/axe_ultimate_lua/modifier_axe_ultimate_lua", LUA_MODIFIER_MOTION_NONE )

function axe_ultimate_lua:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

function axe_ultimate_lua:OnAbilityPhaseStart()
	-- play effects
	self:PlayEffects_b()

	return true -- if success
end

function axe_ultimate_lua:OnSpellStart()
    local caster = self:GetCaster()
    local point = self:GetCursorPosition()
	local radius = self:GetSpecialValueFor("radius")
	local damage = self:GetSpecialValueFor("damage")
	local treshold = self:GetSpecialValueFor("treshold")
	local speed_duration = self:GetSpecialValueFor("speed_duration")
    
    local enemies = FindUnitsInRadius( 
        caster:GetTeamNumber(), -- int, your team number
        point, -- point, center point
        nil, -- handle, cacheUnit. (not known)
        radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
        DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
        0, -- int, flag filter
        FIND_CLOSEST, -- int, order filter
        false -- bool, can grow cache
    )

    -- Print units
    for _,enemy in pairs(enemies) do
        if _ > 1 then return end

        local currentHealth = enemy:GetHealth()
        
        if currentHealth <= treshold then
            enemy:Kill(self, caster)	

            		-- Resets cooldown
            caster:GiveMana(50)
            self:PlayEffects( enemy, true )
            caster:AddNewModifier(
                caster,
                self,
                "modifier_axe_ultimate_lua",
                {duration = speed_duration}
            )
        else

            local damage = {
                victim = enemy,
                attacker = caster,
                damage = damage,
                damage_type = DAMAGE_TYPE_PURE,
            }

            ApplyDamage(damage)
            self:PlayEffects( enemy, false )
        end
    end
end

--------------------------------------------------------------------------------
function axe_ultimate_lua:PlayEffects( target, success )
	-- Get Resources
	local particle_cast = ""
	local sound_cast = ""
	if success then
		particle_cast = "particles/units/heroes/hero_axe/axe_culling_blade_kill.vpcf"
		sound_cast = "Hero_Axe.Culling_Blade_Success"
	else
		particle_cast = "particles/units/heroes/hero_axe/axe_culling_blade.vpcf"
		sound_cast = "Hero_Axe.Culling_Blade_Fail"
    end
	-- load data
	local direction = (target:GetOrigin()-self:GetCaster():GetOrigin()):Normalized()

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControl( effect_cast, 4, target:GetOrigin() )
	ParticleManager:SetParticleControlForward( effect_cast, 3, direction )
	ParticleManager:SetParticleControlForward( effect_cast, 4, direction )
	-- assert(loadfile("lua_abilities/rubick_spell_steal_lua/rubick_spell_steal_lua_color"))(self,effect_target)
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, target )
end




function axe_ultimate_lua:OnAbilityPhaseInterrupted()	
	StopGlobalSound( "axe_axe_ability_cullingblade_01" )
	return true -- if success
end

function axe_ultimate_lua:PlayEffects_b()
    EmitGlobalSound("axe_axe_ability_cullingblade_01")
end