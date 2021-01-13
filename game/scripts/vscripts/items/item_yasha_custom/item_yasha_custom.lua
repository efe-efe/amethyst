item_yasha_custom = class({})
LinkLuaModifier("modifier_item_yasha_custom", "items/item_yasha_custom/modifier_item_yasha_custom", LUA_MODIFIER_MOTION_NONE)

function item_yasha_custom:OnAbilityPhaseStart()
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_casting", { 
		duration = self:GetCastPoint(), 
		movement_speed = 0,
	})
	self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_GENERIC_CHANNEL_1, 1.0)
    return true
end

function item_yasha_custom:OnAbilityPhaseInterrupted()
	self:GetCaster():FadeGesture(ACT_DOTA_GENERIC_CHANNEL_1)
	self:GetCaster():RemoveModifierByName("modifier_casting")
end

function item_yasha_custom:OnSpellStart()
	self:GetCaster():FadeGesture(ACT_DOTA_GENERIC_CHANNEL_1)
    local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = ClampPosition(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)
	local damage = self:GetSpecialValueFor("ability_damage")
	local duration = self:GetSpecialValueFor("duration")
	
	FindClearSpaceForUnit(caster, point , true)

	local new_origin = caster:GetOrigin()

	local enemies = CustomEntities:FindUnitsInLine(
		caster,
		new_origin, 
		origin, 
		100, 
		DOTA_UNIT_TARGET_TEAM_ENEMY, 
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
		DOTA_UNIT_TARGET_FLAG_NONE
	)
	
	for _,enemy in pairs(enemies) do
		local damage_table = {
			victim = enemy,
			attacker = caster,
			damage = damage,
			damage_type = DAMAGE_TYPE_PHYSICAL,
		}
		ApplyDamage(damage_table)
		self:PlayEffectsOnTarget(enemy)
	end

	if #enemies <= 0 then
		self:PlayEffectsOnMiss()
    else
		caster:AddNewModifier(caster, self, "modifier_item_yasha_custom", { duration = duration })
		self:PlayEffectsOnHit()
    end

	self:PlayEffectsOnCast(origin, new_origin)
end

function item_yasha_custom:PlayEffectsOnCast(origin, final)
    local particle_cast = "particles/yasha_effect/void_spirit_astral_step.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect_cast, 0, origin)
	ParticleManager:SetParticleControl(effect_cast, 1, final)
	ParticleManager:ReleaseParticleIndex(effect_cast)    
end

function item_yasha_custom:PlayEffectsOnTarget(hTarget)
	EmitSoundOn("Hero_Juggernaut.BladeDance.Arcana", hTarget)
	EmitSoundOn("Hero_Juggernaut.BladeDance.Layer", hTarget)
	EmitSoundOn("Hero_Juggernaut.Attack", hTarget)
end

function item_yasha_custom:PlayEffectsOnMiss()
	EmitSoundOn("Hero_Juggernaut.Attack", self:GetCaster())
end

function item_yasha_custom:PlayEffectsOnHit()
    EmitSoundOn("DOTA_Item.PhaseBoots.Activate", self:GetCaster())

	local particle_cast = "particles/econ/events/ti8/phase_boots_ti8.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:ReleaseParticleIndex(effect_cast)
end