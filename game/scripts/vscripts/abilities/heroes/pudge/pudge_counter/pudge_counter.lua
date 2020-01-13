pudge_counter = class({})
LinkLuaModifier( "modifier_pudge_counter", "abilities/heroes/pudge/pudge_counter/modifier_pudge_counter", LUA_MODIFIER_MOTION_NONE )

function pudge_counter:OnCastPointEnd()
	local caster = self:GetCaster()
	self:ToggleAbility()	
end

function pudge_counter:OnToggle()
	if self:GetToggleState() then
		self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_pudge_counter", nil )
	else
		local hRotBuff = self:GetCaster():FindModifierByName( "modifier_pudge_counter" )
		if hRotBuff ~= nil then
			hRotBuff:Destroy()
		end
	end
end


if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	pudge_counter,
	{ activity = ACT_DOTA_CAST_ABILITY_ROT, rate = 1.0 },
	{ movement_speed = 100 }
)