axe_ex_mobility = class({})
LinkLuaModifier( "modifier_axe_ex_mobility_movement", "abilities/heroes/axe/axe_ex_mobility/modifier_axe_ex_mobility_movement", LUA_MODIFIER_MOTION_BOTH )

function axe_ex_mobility:IsHidden()
    return true
end

function axe_ex_mobility:IsHiddenAbilityCastable()
    return true
end

function axe_ex_mobility:GetAlternateVersion()
    return self:GetCaster():FindAbilityByName("axe_mobility")
end

--------------------------------------------------------------------------------
-- Ability Start
function axe_ex_mobility:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
    local radius = self:GetSpecialValueFor( "radius" )
    local max_range = self:GetSpecialValueFor("range")

	-- Animation and pseudo cast point
	StartAnimation(caster, {
        duration = cast_point + 0.1, 
        activity = ACT_DOTA_ATTACK, 
        rate = 1.1
    })
	caster:AddNewModifier(caster, self , "modifier_cast_point", { 
		duration = cast_point, 
		movement_speed = 10,
        radius = radius,
        min_range = max_range/2,
        show_all = 1,
	})
end

function axe_ex_mobility:OnCastPointEnd( point )
    local caster = self:GetCaster()    
    local origin = caster:GetOrigin()
    local difference = (point - origin):Length2D()

    local x = point.x - caster:GetOrigin().x
    local y = point.y - caster:GetOrigin().y

    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_axe_ex_mobility_movement", -- modifier name
        {
            x = x,
            y = y,
            r = difference,
            speed = 2000,
        } -- kv
    )

    self:PlayEffects()

    
	-- Put CD on the alternate of the ability
	local alternate_version = caster:FindAbilityByName("axe_mobility")
	alternate_version:StartCooldown(self:GetCooldown(0))
end

function axe_ex_mobility:PlayEffects()
    local sound_cast = "Hero_Axe.BerserkersCall.Start"
    EmitSoundOn(sound_cast, self:GetCaster())
end