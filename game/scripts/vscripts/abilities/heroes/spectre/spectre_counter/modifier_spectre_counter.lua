modifier_spectre_counter = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_spectre_counter:IsHidden()
	return false
end

function modifier_spectre_counter:IsDebuff()
	return false
end

function modifier_spectre_counter:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_spectre_counter:OnCreated( kv )
	if IsServer() then 
		ProgressBars:AddProgressBar(self:GetParent(), self:GetName(), {
			style = "Generic",
			text = "invisible",
			progressBarType = "duration",
			priority = 2,
		})
	end
end

function modifier_spectre_counter:OnDestroy()
	if IsServer() then
		self:PlayEffects()
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_spectre_counter:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
        MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
	}

	return funcs
end

function modifier_spectre_counter:GetModifierInvisibilityLevel()
	return 1
end

function modifier_spectre_counter:OnAbilityFullyCast( params )
	if IsServer() then
		if params.unit ~= self:GetParent() then
			return
		end

		if 	params.ability:GetName() == "item_death_orb" or
			params.ability:GetName() == "item_mana_orb" or
			params.ability:GetName() == "item_health_orb"
		then
			return
		end
		self:Destroy()
	end
end


--------------------------------------------------------------------------------
-- Status Effects
function modifier_spectre_counter:CheckState()
	local state = {
        [MODIFIER_STATE_INVISIBLE] = true,
        [MODIFIER_STATE_TRUESIGHT_IMMUNE] = false,
	}

	return state
end


function modifier_spectre_counter:PlayEffects()
    EmitSoundOn( "Hero_Spectre.Reality", self:GetParent() )

    local particle_cast = "particles/econ/items/outworld_devourer/od_shards_exile_gold/od_shards_exile_prison_end_gold.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end