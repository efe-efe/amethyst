spectre_basic_attack = class({})
LinkLuaModifier("modifier_spectre_desolate_custom", "abilities/heroes/spectre/spectre_shared_modifiers/modifier_spectre_desolate_custom/modifier_spectre_desolate_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spectre_basic_attack_cooldown", "abilities/heroes/spectre/spectre_basic_attack/modifier_spectre_basic_attack_cooldown", LUA_MODIFIER_MOTION_NONE)

function spectre_basic_attack:GetIntrinsicModifierName()
	return "modifier_spectre_basic_attack_cooldown"
end

function spectre_basic_attack:GetCastPoint()
	if IsServer() then
		return self:GetCaster():GetAttackAnimationPoint()
	end
end

function spectre_basic_attack:GetCooldown(iLevel)
	if IsServer() then
        local attacks_per_second = self:GetCaster():GetAttacksPerSecond()
        local attack_speed = (1 / attacks_per_second)
		
		return self.BaseClass.GetCooldown(self, self:GetLevel()) + attack_speed
	end
end

function spectre_basic_attack:GetCastAnimationCustom()	return ACT_DOTA_ATTACK end
function spectre_basic_attack:GetPlaybackRateOverride()
	if IsServer() then 
		local slow = self:GetCaster():FindModifierByName("modifier_spectre_basic_attack_cooldown"):IsCooldownReady() and 0.3 or 0.0 

		return 1.1 - slow
	end
end
function spectre_basic_attack:GetCastPointSpeed() 		return self:GetSpecialValueFor('cast_point_speed_pct') end

function spectre_basic_attack:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = Clamp(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), self:GetCastRange(Vector(0,0,0), nil))
	local damage = caster:GetAverageTrueAttackDamage(caster)

	local radius = self:GetSpecialValueFor("radius")
	local desolate_duration = self:GetSpecialValueFor("desolate_duration")
	local silence_duration = self:GetSpecialValueFor("silence_duration")
    local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")

	local heal_charged = self:GetSpecialValueFor("heal_charged")
	local damage_bonus_charged = self:GetSpecialValueFor("damage_bonus_charged")
    local damage_bonus_desolate = self:GetSpecialValueFor("damage_bonus_desolate")
    local heal_desolate = self:GetSpecialValueFor("heal_desolate")

	local direction = (Vector(point.x - origin.x, point.y - origin.y, 0)):Normalized()

	local is_charged = caster:FindModifierByName("modifier_spectre_basic_attack_cooldown"):IsCooldownReady()
	
	local enemies = caster:FindUnitsInCone(
		direction, 
		0, 
		origin, 
		radius, 
		DOTA_UNIT_TARGET_TEAM_ENEMY, 
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
		DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_CLOSEST
	)

	for _,enemy in pairs(enemies) do 
		local final_damage = damage
		if enemy:HasModifier("modifier_spectre_desolate_custom") then
			final_damage = final_damage + damage_bonus_desolate

			if not enemy:IsObstacle() then
				caster:Heal(heal_desolate, caster)
				self:PlayEffectsLifeSteal()
			end
		end

		local damage_table = {
			victim = enemy,
			attacker = caster,
			damage = final_damage,
			damage_type = DAMAGE_TYPE_PHYSICAL,
			ability = self
		}
		ApplyDamage(damage_table)
	
		if is_charged then
			enemy:AddNewModifier(caster, self, "modifier_generic_silence", { duration = silence_duration })
			enemy:AddNewModifier(caster, self, "modifier_spectre_desolate_custom", { duration = desolate_duration })

			if not enemy:IsObstacle() then
				caster:Heal(heal_charged, caster)
			end
		end

		if not enemy:IsObstacle() then 
			caster:GiveManaPercent(mana_gain_pct, enemy)
		end

		self:PlayEffectsOnImpact(enemy, enemy:GetAbsOrigin(), is_charged)

		if caster.OnBasicAttackImpact then
			caster:OnBasicAttackImpact(enemy)
		end

		if not is_charged then
			break
		end
	end

	self:PlayEffectsOnFinish(direction, is_charged)
	self:PlayEffectsOnCast(is_charged)
end

function spectre_basic_attack:PlayEffectsOnFinish(direction, is_charged)
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()

	local particle_cast = "particles/units/heroes/hero_nyx_assassin/nyx_assassin_vendetta_swipe.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, origin)
	ParticleManager:SetParticleControlForward(effect_cast, 0, direction)
	ParticleManager:ReleaseParticleIndex(effect_cast)

	if is_charged then
		particle_cast = "particles/econ/items/juggernaut/jugg_ti8_sword/juggernaut_crimson_blade_fury_abyssal_start.vpcf"
		effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster)
		ParticleManager:SetParticleControl(effect_cast, 2, origin)
		ParticleManager:ReleaseParticleIndex(effect_cast)
		
		particle_cast = "particles/econ/items/dragon_knight/dk_immortal_dragon/dragon_knight_dragon_tail_dragonform_iron_dragon.vpcf"
		effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster)
		ParticleManager:SetParticleControl(effect_cast, 2, origin)
		ParticleManager:SetParticleControl(effect_cast, 4, origin)
		ParticleManager:ReleaseParticleIndex(effect_cast)
	end
end

function spectre_basic_attack:PlayEffectsOnCast(is_charged)
	EmitSoundOn("Hero_Spectre.PreAttack", self:GetCaster())

	if is_charged then
		EmitSoundOn('Hero_Sven.Layer.GodsStrength', self:GetCaster())
	end
end

function spectre_basic_attack:PlayEffectsOnImpact(hTarget, pos, is_charged)
	if is_charged then
		EmitSoundOn("Hero_BountyHunter.Jinada", hTarget)
		
		local particle_cast = "particles/econ/items/slark/slark_ti6_blade/slark_ti6_blade_essence_shift.vpcf"
		local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_POINT, hTarget)
		ParticleManager:ReleaseParticleIndex(effect_cast)
	else
		EmitSoundOn("Hero_Spectre.Attack", hTarget)

		local caster = self:GetCaster()
		local offset = 50
		local new_position = caster:GetOrigin() + (pos - caster:GetOrigin()):Normalized() * offset
	
		local particle_cast = "particles/units/heroes/hero_spectre/spectre_desolate.vpcf"
		local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_POINT, caster)
		ParticleManager:SetParticleControl(effect_cast, 0, pos)
		ParticleManager:SetParticleControlForward(effect_cast, 0, (pos - caster:GetOrigin()):Normalized())
		ParticleManager:ReleaseParticleIndex(effect_cast)
	
		local particle_cast_b = "particles/units/heroes/hero_nyx_assassin/nyx_assassin_vendetta_swipe.vpcf"
		local effect_cast_b = ParticleManager:CreateParticle(particle_cast_b, PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(effect_cast_b, 0, new_position)
		ParticleManager:SetParticleControlForward(effect_cast_b, 0, (pos - caster:GetOrigin()):Normalized())
		ParticleManager:ReleaseParticleIndex(effect_cast_b)
	end
end

function spectre_basic_attack:PlayEffectsLifeSteal()
	local particle_cast = "particles/econ/items/bloodseeker/bloodseeker_eztzhok_weapon/bloodseeker_bloodbath_heal_eztzhok.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(spectre_basic_attack)