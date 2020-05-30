modifier_tinker_ex_counter = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_tinker_ex_counter:IsHidden() return false
end

function modifier_tinker_ex_counter:IsDebuff()
	return true
end

function modifier_tinker_ex_counter:IsPurgable() return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_tinker_ex_counter:OnCreated( kv )
	-- references
	self.base_speed = 300--self:GetAbility():GetSpecialValueFor( "movespeed" )
	self.model = "models/items/hex/sheep_hex/sheep_hex_gold.vmdl"

	if IsServer() then
		-- play effects
		self:PlayEffects( true )

		-- instantly destroy illusions
		if self:GetParent():IsIllusion() then
			self:GetParent():Kill( self:GetAbility(), self:GetCaster() )
		end
	end
end

function modifier_tinker_ex_counter:OnRefresh( kv )
	-- references
	self.base_speed = self:GetAbility():GetSpecialValueFor( "movespeed" )
	if IsServer() then
		-- play effects
		self:PlayEffects( true )
	end
end

function modifier_tinker_ex_counter:OnDestroy( kv )
	if IsServer() then
		-- play effects
		self:PlayEffects( false )
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_tinker_ex_counter:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BASE_OVERRIDE,
		MODIFIER_PROPERTY_MODEL_CHANGE,
	}

	return funcs
end

function modifier_tinker_ex_counter:GetModifierMoveSpeedOverride()
	return self.base_speed
end

function modifier_tinker_ex_counter:GetModifierModelChange()
	return self.model
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_tinker_ex_counter:CheckState()
	local state = {
	[MODIFIER_STATE_HEXED] = true,
	[MODIFIER_STATE_DISARMED] = true,
	[MODIFIER_STATE_SILENCED] = true,
	[MODIFIER_STATE_MUTED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_tinker_ex_counter:PlayEffects( bStart )
	local sound_cast = "DOTA_Item.Sheepstick.Activate"
	local particle_cast = "particles/units/heroes/hero_lion/lion_spell_voodoo.vpcf"

	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	if bStart then
		EmitSoundOn( sound_cast, self:GetParent() )
	end
end