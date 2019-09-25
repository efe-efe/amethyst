phoenix_special_attack= class({})
LinkLuaModifier( "modifier_phoenix_special_attack_thinker", "abilities/heroes/phoenix/phoenix_special_attack/modifier_phoenix_special_attack_thinker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phoenix_special_attack_movement", "abilities/heroes/phoenix/phoenix_special_attack/modifier_phoenix_special_attack_movement", LUA_MODIFIER_MOTION_NONE )

function phoenix_special_attack:OnSpellStart()
	local caster = self:GetCaster()
	local thinker_duration = self:GetSpecialValueFor("thinker_duration")
	local radius = self:GetSpecialValueFor("radius")
	local dashDuration	= 0.9

	local origin = caster:GetAbsOrigin()
	local angles = caster:GetAngles()
	local forwardDir = caster:GetForwardVector()
	local rightDir = caster:GetRightVector()

	local dashLength	= radius * 2
	local dashWidth		= radius * 2
	local ellipseCenter	= origin + forwardDir * radius

	local startTime = GameRules:GetGameTime()

    caster:AddNewModifier(
        caster,
        self,
        "modifier_phoenix_special_attack_movement",
        { duration = dashDuration }
    )
    
	caster:SetContextThink( DoUniqueString("updateIcarusDive"), function ( )

		local elapsedTime = GameRules:GetGameTime() - startTime
		local progress = elapsedTime / dashDuration

		-- Interrupted
		if not caster:HasModifier( "modifier_phoenix_special_attack_movement" ) then
			return nil
		end

		-- Calculate potision
		local theta = -2 * math.pi * progress
		local x =  math.sin( theta ) * dashWidth * 0.5
		local y = -math.cos( theta ) * dashLength * 0.5

		local pos = ellipseCenter + rightDir * x + forwardDir * y
		local yaw = angles.y + 90 + progress * -360  

		pos = GetGroundPosition( pos, caster )
		caster:SetAbsOrigin( pos )
		caster:SetAngles( angles.x, yaw, angles.z )

		return 0.03
	end, 0 )

	self:PlayEffects()

	CreateModifierThinker(
		caster, --hCaster
		self, --hAbility
		"modifier_phoenix_special_attack_thinker", --modifierName
		{ duration = thinker_duration }, --paramTable
		ellipseCenter, --vOrigin
		caster:GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)
	SafeDestroyModifier("modifier_phoenix_mobility_movement", caster, caster)

	-- Put CD on the alternate of the ability
	local alternate_version = caster:FindAbilityByName("phoenix_ex_special_attack")
	alternate_version:StartCooldown(self:GetCooldown(0))
end


function phoenix_special_attack:PlayEffects()
	local sound_cast = "Hero_Phoenix.IcarusDive.Cast"
	EmitSoundOn( sound_cast, self:GetCaster() )
end