axe_ultimate = class({})
LinkLuaModifier( "modifier_axe_ultimate", "abilities/heroes/axe/axe_ultimate/modifier_axe_ultimate", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function axe_ultimate:OnSpellStart()
	self:PlayEffects_b()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
	self.radius = self:GetSpecialValueFor("radius")
	
	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=0.6, activity=ACT_DOTA_CAST_ABILITY_4, rate=1.0})
	caster:AddNewModifier(caster, self , "modifier_cast_point", { 
		duration = cast_point,
		can_walk = 0,
        radius = self.radius,
        show_all = 1,
	})
end

--------------------------------------------------------------------------------
function axe_ultimate:OnCastPointEnd( pos )
    local caster = self:GetCaster()
	local damage = self:GetAbilityDamage()
	local treshold = self:GetSpecialValueFor("treshold")
	local speed_duration = self:GetSpecialValueFor("speed_duration")
	local mana_gain = self:GetSpecialValueFor("mana_gain")/100
    
    local enemies = FindUnitsInRadius( 
        caster:GetTeamNumber(), -- int, your team number
        pos, -- point, center point
        nil, -- handle, cacheUnit. (not known)
        self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
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

            -- Gives mana
            local mana_gain_final = caster:GetMaxMana() * mana_gain
            caster:GiveMana(mana_gain_final)

            self:PlayEffects( enemy, true )
            caster:AddNewModifier(
                caster,
                self,
                "modifier_axe_ultimate",
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
function axe_ultimate:PlayEffects( target, success )
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




function axe_ultimate:OnStopPseudoCastPoint()
	StopGlobalSound( "axe_axe_ability_cullingblade_01" )
end

function axe_ultimate:PlayEffects_b()
    EmitGlobalSound("axe_axe_ability_cullingblade_01")
end