nevermore_ex_special_attack = class({})
LinkLuaModifier("modifier_nevermore_ex_special_attack", "abilities/heroes/nevermore/nevermore_ex_special_attack/modifier_nevermore_ex_special_attack", LUA_MODIFIER_MOTION_NONE)

function nevermore_ex_special_attack:GetAlternateVersion()
    return self:GetCaster():FindAbilityByName("nevermore_special_attack")
end

--------------------------------------------------------------------------------
-- Ability Start
function nevermore_ex_special_attack:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()

	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=1.0, activity=ACT_DOTA_TELEPORT_END, rate=1.0})
	caster:AddNewModifier(caster, self , "modifier_cast_point", { 
		duration = cast_point,
		movement_speed = 10,
		no_target = 1
	})
end

--------------------------------------------------------------------------------
-- Ability Start
function nevermore_ex_special_attack:OnCastPointEnd()
    local caster = self:GetCaster()

    caster:AddNewModifier(
        caster,
        self,
        "modifier_nevermore_ex_special_attack",
        {}
    )

    self:PlayEffects()
    
    -- Put CD on the alternate of the ability
	local alternate_version = caster:FindAbilityByName("nevermore_special_attack")
	alternate_version:StartCooldown(self:GetCooldown(0))
end


function nevermore_ex_special_attack:PlayEffects()
    local caster = self:GetCaster()

    -- Create Particles
    local particle_cast = "particles/econ/items/doom/doom_ti8_immortal_arms/doom_ti8_immortal_devour_ring.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

