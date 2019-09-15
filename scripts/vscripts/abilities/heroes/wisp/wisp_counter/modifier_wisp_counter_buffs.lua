modifier_wisp_counter_buffs = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_wisp_counter_buffs:IsHidden()
	return false
end

function modifier_wisp_counter_buffs:IsDebuff()
	return false
end

function modifier_wisp_counter_buffs:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_wisp_counter_buffs:OnCreated( kv )
	self.speed_buff_pct = self:GetAbility():GetSpecialValueFor( "speed_buff_pct" )
	self.damage_reduction_pct = self:GetAbility():GetSpecialValueFor( "damage_reduction_pct" )
	local total_heal = self:GetAbility():GetSpecialValueFor( "total_heal" )
	local duration = self:GetDuration()
	local think_interval = 0.5
	local ticks = duration/think_interval
	self.heal_per_think = total_heal/ticks

	if IsServer() then 
		self:StartIntervalThink(0.5)
		self:PlayEffects()
	end
end

function modifier_wisp_counter_buffs:OnIntervalThink()
	self:GetParent():Heal(self.heal_per_think, self:GetParent())
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_wisp_counter_buffs:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}

	return funcs
end

function modifier_wisp_counter_buffs:GetModifierMoveSpeedBonus_Percentage()
    return self.speed_buff_pct
end

function modifier_wisp_counter_buffs:GetModifierIgnoreMovespeedLimit( params )
    return 1
end

function modifier_wisp_counter_buffs:GetModifierIncomingDamage_Percentage( params )
	return -self.damage_reduction_pct
end

--------------------------------------------------------------------------------
-- Graphics & Sounds
function modifier_wisp_counter_buffs:PlayEffects()
	local caster = self:GetCaster()

	-- Create Sound
	EmitSoundOn( "Hero_Wisp.Spirits.Destroy", caster )
	
	-- Create Particles
	local particle_cast = "particles/mod_units/heroes/hero_wisp/wisp_death.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end


-- Graphics & Animations
function modifier_wisp_counter_buffs:GetEffectName()
	return "particles/econ/courier/courier_polycount_01/courier_trail_polycount_01.vpcf"
end

function modifier_wisp_counter_buffs:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end