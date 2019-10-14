function CDOTA_BaseNPC:IsMiddleOrb()
    return self:Attribute_GetIntValue("middle_orb", 0) == 1 and true or false
end

function CDOTA_BaseNPC:GiveManaPercent( percentage, source )
    if source ~= nil and source:IsMiddleOrb() then
        return
    end

    self:GiveMana(self:GetMaxMana() * percentage/100)
end

function CDOTA_BaseNPC:IsSilenced()
    return self:HasModifier("modifier_generic_silenced_lua")
end

function CDOTA_BaseNPC:IsStunned()
    return self:HasModifier("modifier_generic_stunned")
end

function CDOTA_BaseNPC:StrongPurge()
    self:Purge(false, true, false, true, false)
end

function CDOTA_BaseNPC:SetOneAbilityActive( spell )
	if IsServer() then
		for i = 0, 10 do
			local ability = self:GetAbilityByIndex(i)
			if ability then
                if ability ~= spell then
                    ability:SetActivated( false )
                end
			end
		end
	end
end

function CDOTA_BaseNPC:SetAllAbilitiesActivated( mode )
	if IsServer() then
		for i = 0, 10 do
			self:GetAbilityByIndex(i):SetActivated( mode )
		end
	end
end



