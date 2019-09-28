modifier_axe_counter_buff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_axe_counter_buff:IsHidden()
	return false
end

function modifier_axe_counter_buff:IsDebuff()
	return false
end

function modifier_axe_counter_buff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_axe_counter_buff:OnCreated( kv )
	self.movement_speed = self:GetAbility():GetSpecialValueFor( "movement_speed" )
	self.damage_reduction_pct = self:GetAbility():GetSpecialValueFor( "damage_reduction_pct" )

    if IsServer() then
		self:PlayEffects()
		self:StartIntervalThink(0.05)
		
		ProgressBars:AddProgressBar(self:GetParent(), self:GetName(), {
			style = "Invulnerable",
			text = "invulnerable",
			progressBarType = "duration",
			priority = 1,
		})
    end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_axe_counter_buff:OnIntervalThink()
	-- Strong Dispel
	local RemovePositiveBuffs = false
	local RemoveDebuffs = true
	local BuffsCreatedThisFrameOnly = false
	local RemoveStuns = true
	local RemoveExceptions = false

	self:GetParent():Purge( RemovePositiveBuffs, RemoveDebuffs, BuffsCreatedThisFrameOnly, RemoveStuns, RemoveExceptions)
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_axe_counter_buff:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}

	return funcs
end


function modifier_axe_counter_buff:GetModifierMoveSpeed_Absolute()
    return self.movement_speed
end

function modifier_axe_counter_buff:GetModifierIncomingDamage_Percentage( params )
	return -self.damage_reduction_pct
end

function modifier_axe_counter_buff:PlayEffects()
	-- Get Resources
	local sound_cast = "axe_axe_anger_03"
	local particle_cast = "particles/econ/items/monkey_king/arcana/fire/mk_arcana_fire_spring_ring_radial.vpcf"
    local origin = self:GetCaster():GetOrigin()

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster()  )

	-- Create Particles
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

-- Graphics & Animations
function modifier_axe_counter_buff:GetStatusEffectName()
	return "particles/status_fx/status_effect_electrical.vpcf"
end
