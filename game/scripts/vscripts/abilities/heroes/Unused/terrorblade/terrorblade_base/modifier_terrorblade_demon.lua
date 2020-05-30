modifier_terrorblade_demon = class({})

function modifier_terrorblade_demon:OnCreated(params)
	if IsServer() then

		self:GetParent():SetModel("models/heroes/terrorblade/demon.vmdl")
		self:GetParent():SetOriginalModel("models/heroes/terrorblade/demon.vmdl")

		self:GetParent():SwapAbilities(
			"terrorblade_basic_attack", 
			"demon_basic_attack", 
			false, 
			true
		)
		self:GetParent():SwapAbilities(
			"terrorblade_second_attack", 
			"demon_second_attack", 
			false, 
			true
		)
		self:GetParent():SwapAbilities(
			"terrorblade_special_attack", 
			"demon_special_attack", 
			false, 
			true
		)
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_terrorblade_demon:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MODEL_SCALE,
	}

	return funcs
end

function modifier_terrorblade_demon:GetModifierModelScale()
	return -15
end

