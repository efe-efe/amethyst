healthBuffer = class ({})

LinkLuaModifier( "healthBufferModifier", "modifiers/general/healthBufferModifier.lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function healthBuffer:GetIntrinsicModifierName()
	return "healthBufferModifier"
end
