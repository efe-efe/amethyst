axe_mobility_lua = class({})
LinkLuaModifier( "modifier_axe_mobility_movement_lua", "abilities/heroes/axe/axe_mobility_lua/modifier_axe_mobility_movement_lua", LUA_MODIFIER_MOTION_BOTH )


function axe_mobility_lua:OnSpellStart()
    local caster = self:GetCaster()    
    local origin = caster:GetOrigin()
    local point = self:GetCursorPosition()
    local max_range = self:GetSpecialValueFor("range")

    -- determine target position
    local difference = (point - origin):Length2D()

    if difference > max_range then
        difference = tonumber(max_range)
    end
    
    local x = point.x - caster:GetOrigin().x
    local y = point.y - caster:GetOrigin().y

    caster:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_axe_mobility_movement_lua", -- modifier name
        {
            x = x,
            y = y,
            r = difference,
            speed = 2300,
        } -- kv
    )

    self:PlayEffects()

    -- Put CD on the alternate of the ability
	local alternate_version = caster:FindAbilityByName("axe_ex_mobility_lua")
	alternate_version:StartCooldown(self:GetCooldown(0))
end

function axe_mobility_lua:PlayEffects()
    local sound_cast = "Hero_Axe.BerserkersCall.Start"
    EmitSoundOn(sound_cast, self:GetCaster())
end