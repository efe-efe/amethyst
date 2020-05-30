modifier_terrorblade_normal = class({})

function modifier_terrorblade_normal:OnCreated(params)
	if IsServer() then
		
		self:GetParent():SetModel("models/heroes/terrorblade/terrorblade.vmdl")
		self:GetParent():SetOriginalModel("models/heroes/terrorblade/terrorblade.vmdl")
		
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
