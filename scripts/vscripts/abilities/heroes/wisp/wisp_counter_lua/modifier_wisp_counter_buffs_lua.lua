modifier_wisp_counter_buffs_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_wisp_counter_buffs_lua:IsHidden()
	return false
end

function modifier_wisp_counter_buffs_lua:IsDebuff()
	return false
end

function modifier_wisp_counter_buffs_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_wisp_counter_buffs_lua:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}

	return funcs
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_wisp_counter_buffs_lua:OnCreated( kv )
    if IsServer() then
        self.movement_speed = self:GetAbility():GetSpecialValueFor( "movement_speed" )
        self.heal_regen = self:GetAbility():GetSpecialValueFor( "heal_regen" )

		-- Strong Dispel
		local RemovePositiveBuffs = false
		local RemoveDebuffs = true
		local BuffsCreatedThisFrameOnly = false
		local RemoveStuns = true
		local RemoveExceptions = false

		-- Apply dispell after debuffs and stuns are applied
		Timers:CreateTimer(0.001, function()
			self:GetCaster():Purge( RemovePositiveBuffs, RemoveDebuffs, BuffsCreatedThisFrameOnly, RemoveStuns, RemoveExceptions)
			self:PlayEffects()
		end)
		
    end
end

function modifier_wisp_counter_buffs_lua:GetModifierMoveSpeed_Absolute()
    return self.movement_speed
end

function modifier_wisp_counter_buffs_lua:GetModifierConstantHealthRegen()
    return self.heal_regen
end

function modifier_wisp_counter_buffs_lua:PlayEffects()
	-- Get Resources
	local sound_cast = "Hero_Wisp.Spirits.Destroy"
	local particle_cast = "particles/mod_units/heroes/hero_wisp/wisp_death.vpcf"
    local origin = self:GetCaster():GetOrigin()

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster()  )

	-- Create Particles
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end


-- Graphics & Animations
function modifier_wisp_counter_buffs_lua:GetEffectName()
	return "particles/econ/courier/courier_polycount_01/courier_trail_polycount_01.vpcf"
end

function modifier_wisp_counter_buffs_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end