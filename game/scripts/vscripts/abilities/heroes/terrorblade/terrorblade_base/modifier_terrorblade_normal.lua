modifier_terrorblade_normal = class({})

function modifier_terrorblade_normal:OnCreated(params)
	if IsServer() then
		if params.first_time ~= 1 then
			self:GetParent():SwapAbilities(
				"terrorblade_basic_attack",
				"demon_basic_attack",
				true,
				false
			)
			self:GetParent():SwapAbilities(
				"terrorblade_second_attack",
				"demon_second_attack",
				true,
				false
			)
			self:GetParent():SwapAbilities(
				"terrorblade_special_attack",
				"demon_special_attack",
				true,
				false
			)
		end
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_terrorblade_normal:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MODEL_CHANGE,
	}

	return funcs
end

function modifier_terrorblade_normal:GetModifierModelChange()
	return "models/heroes/terrorblade/terrorblade.vmdl"
end
