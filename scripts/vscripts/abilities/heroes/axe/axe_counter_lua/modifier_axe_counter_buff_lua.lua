modifier_axe_counter_buff_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_axe_counter_buff_lua:IsHidden()
	return false
end

function modifier_axe_counter_buff_lua:IsDebuff()
	return false
end

function modifier_axe_counter_buff_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_axe_counter_buff_lua:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_axe_counter_buff_lua:OnCreated( kv )
    if IsServer() then
        self.movement_speed = self:GetAbility():GetSpecialValueFor( "movement_speed" )

		-- Strong Dispel
		local RemovePositiveBuffs = false
		local RemoveDebuffs = true
		local BuffsCreatedThisFrameOnly = false
		local RemoveStuns = true
		local RemoveExceptions = false

		self:PlayEffects()
		self:StartIntervalThink(0.05)
    end
end


-----------------------------------
-- Interval Effects
function modifier_axe_counter_buff_lua:OnIntervalThink()
	-- Strong Dispel
	local RemovePositiveBuffs = false
	local RemoveDebuffs = true
	local BuffsCreatedThisFrameOnly = false
	local RemoveStuns = true
	local RemoveExceptions = false

	self:GetParent():Purge( RemovePositiveBuffs, RemoveDebuffs, BuffsCreatedThisFrameOnly, RemoveStuns, RemoveExceptions)
end


function modifier_axe_counter_buff_lua:GetModifierMoveSpeed_Absolute()
    return self.movement_speed
end

function modifier_axe_counter_buff_lua:GetModifierIncomingDamage_Percentage( params )
	return -90
end

function modifier_axe_counter_buff_lua:PlayEffects()
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
function modifier_axe_counter_buff_lua:GetStatusEffectName()
	return "particles/status_fx/status_effect_electrical.vpcf"
end
