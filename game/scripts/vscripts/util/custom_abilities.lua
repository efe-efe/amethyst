CustomAbilities = class({})

function CustomAbilities:GetCursorPosition(hAbility)
	local caster = hAbility:GetCaster();
	local playerId = caster:GetPlayerOwnerID();

	if IsInToolsMode() then
		playerId = Entities:GetLocalPlayer():GetPlayerID();
	end

	if not playerId then
		return Vector(0, 0, 0)
	end

	local position = GameRules.GameMode.players[playerId].cursor_position
	return position
end

function CustomAbilities:IsNotTalentNorAttribute(hAbility)
	return (hAbility:GetAbilityType() ~= 2 and hAbility:GetName() ~= "special_bonus_attributes")
end