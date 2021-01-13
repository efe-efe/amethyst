invoker_wall_custom = class({})
LinkLuaModifier("modifier_invoker_ice_wall_custom_thinker", "abilities/heroes/invoker/invoker_extra/modifier_invoker_ice_wall_custom_thinker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_invoker_ice_wall_custom", "abilities/heroes/invoker/invoker_extra/modifier_invoker_ice_wall_custom", LUA_MODIFIER_MOTION_NONE)

function invoker_wall_custom:OnSpellStart()
    local caster = self:GetCaster()
    local origin = caster:GetAbsOrigin()
    local direction = caster:GetForwardVector()
    local duration = 5.0

	CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_invoker_ice_wall_custom_thinker", --modifierName
		{
            duration = duration,
            x = direction.x,
            y = direction.y,
        },
		origin, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
    )
    EmitSoundOn("Hero_Invoker.IceWall.Cast", caster)
end
