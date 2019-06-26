phoenix_mobility= class({})
LinkLuaModifier( "modifier_phoenix_mobility_movement", "abilities/heroes/phoenix/phoenix_mobility/modifier_phoenix_mobility_movement", LUA_MODIFIER_MOTION_NONE )

function phoenix_mobility:OnSpellStart()
    local caster = self:GetCaster()
	local dashDuration	= 2.0

	local origin = caster:GetAbsOrigin()
	local angles = caster:GetAngles()
	local forwardDir = caster:GetForwardVector()
	local rightDir = caster:GetRightVector()

	local range	= self:GetSpecialValueFor("range")
	local dashWidth		= 500
	local ellipseCenter	= origin + forwardDir * ( range / 2 )

	local startTime = GameRules:GetGameTime()

    caster:AddNewModifier(
        caster,
        self,
        "modifier_phoenix_mobility_movement",
        { duration = dashDuration }
    )
    
	-- Swap abilities back to be able to stop
	caster:SwapAbilities( 
		"phoenix_mobility",
		"phoenix_mobility_stop",
		false,
		true
	)

	caster:SetContextThink( DoUniqueString("updateIcarusDive"), function ( )

		local elapsedTime = GameRules:GetGameTime() - startTime
		local progress = elapsedTime / dashDuration

		-- Interrupted
		if not caster:HasModifier( "modifier_phoenix_mobility_movement" ) then
			return nil
		end

		-- Calculate potision
		local theta = -2 * math.pi * progress
		local x =  math.sin( theta ) * dashWidth * 0.5
		local y = -math.cos( theta ) * range * 0.5

		local pos = ellipseCenter + rightDir * x + forwardDir * y
		local yaw = angles.y + 90 + progress * -360  

		pos = GetGroundPosition( pos, caster )
		caster:SetAbsOrigin( pos )
		caster:SetAngles( angles.x, yaw, angles.z )

		return 0.03
	end, 0 )

	self:PlayEffects()

end


function phoenix_mobility:PlayEffects()
	local sound_cast = "Hero_Phoenix.IcarusDive.Cast"
	EmitSoundOn( sound_cast, self:GetCaster() )
end