spectre_extra_recast = class({})

--------------------------------------------------------------------------------
function spectre_extra_recast:OnSpellStart()
	--local modifier = self:GetCaster():FindModifierByName("modifier_spectre_extra_recast")
	--modifier:SetDuration( self:GetSpecialValueFor("cast_point") + 0.1, false)
end


--------------------------------------------------------------------------------
function spectre_extra_recast:OnCastPointEnd()
	self:GetCaster():RemoveModifierByName("modifier_spectre_extra_recast")	
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	spectre_extra_recast,
	{ activity = ACT_DOTA_ATTACK, rate = 1.0 },
	{ movement_speed = 10 }
)