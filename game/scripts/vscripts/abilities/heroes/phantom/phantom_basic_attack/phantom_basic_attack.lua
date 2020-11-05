phantom_basic_attack = class({})
phantom_ex_basic_attack = class({})
LinkLuaModifier("modifier_phantom_strike_stack", "abilities/heroes/phantom/phantom_shared_modifiers/modifier_phantom_strike_stack", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phantom_ex_basic_attack", "abilities/heroes/phantom/phantom_basic_attack/modifier_phantom_ex_basic_attack", LUA_MODIFIER_MOTION_NONE)

function phantom_basic_attack:GetCastPoint()
	if IsServer() then
		return self:GetCaster():GetAttackAnimationPoint()
	end
end

function phantom_basic_attack:GetCooldown(iLevel)
	if IsServer() then
        local attacks_per_second = self:GetCaster():GetAttacksPerSecond()
        local attack_speed = (1 / attacks_per_second)
		
		return self.BaseClass.GetCooldown(self, self:GetLevel()) + attack_speed
	end
end

function phantom_basic_attack:GetCastAnimationCustom()		return ACT_DOTA_SPAWN end
function phantom_basic_attack:GetPlaybackRateOverride() 	return 1.5 end
function phantom_basic_attack:GetCastPointSpeed() 			return self:GetSpecialValueFor('cast_point_speed_pct') end
function phantom_basic_attack:GetFadeGestureOnCast()		return false end

function phantom_basic_attack:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = Clamp(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), self:GetCastRange(Vector(0,0,0), nil))
	local damage = caster:GetAverageTrueAttackDamage(caster)

	local radius = self:GetSpecialValueFor("radius")
	local cooldown_reduction = self:GetSpecialValueFor("cooldown_reduction")
    local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")

	local direction = (Vector(point.x - origin.x, point.y - origin.y, 0)):Normalized()

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
		local damage_table = {
			victim = enemy,
			attacker = caster,
			damage = damage,
			damage_type = DAMAGE_TYPE_PHYSICAL,
			ability = self
		}
		ApplyDamage(damage_table)

		
		caster:GiveManaPercent(mana_gain_pct, enemy)

		if not enemy:IsObstacle() then
			caster:AddNewModifier(
				caster, -- player source
				self, -- ability source
				"modifier_phantom_strike_stack", -- modifier name
				{} -- kv
			)
		end

		-- Reduce the cd of the second attack by 1
		local second_attack = caster:FindAbilityByName("phantom_second_attack")
		local second_attack_cd = second_attack:GetCooldownTimeRemaining()
		local new_cd = second_attack_cd - cooldown_reduction

		if (new_cd) < 0 then 
			second_attack:EndCooldown()
		else
			second_attack:EndCooldown()
			second_attack:StartCooldown(new_cd)
		end

		if caster.OnBasicAttackImpact then
			caster:OnBasicAttackImpact(enemy)
		end
		self:PlayEffectsOnImpact(enemy)

		break
	end

	if #enemies > 0 then
		ScreenShake(point, 100, 100, 0.45, 1000, 0, true)
	end

	self:PlayEffectsOnFinish(point)
	self:PlayEffectsOnCast()
end

function phantom_basic_attack:PlayEffectsOnFinish(pos)
	local caster = self:GetCaster()
	local offset = 40
	local origin = caster:GetOrigin()
	local direction = (pos - origin):Normalized()
	local final_position = origin + Vector(direction.x * offset, direction.y * offset, 0)

	local particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_attack_blinkb.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_POINT, caster)
	ParticleManager:SetParticleControl(effect_cast, 0, final_position)
	ParticleManager:SetParticleControlForward(effect_cast, 0, direction)	
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function phantom_basic_attack:PlayEffectsOnImpact(hTarget)
	EFX('particles/phantom/phantom_basic_attack.vpcf', PATTACH_ABSORIGIN, hTarget, {
		release = true
	})

	EmitSoundOn("Hero_PhantomAssassin.Attack", hTarget)
end

function phantom_basic_attack:PlayEffectsOnCast()
	EmitSoundOn("Hero_PhantomAssassin.PreAttack", self:GetCaster())
end

function phantom_ex_basic_attack:OnSpellStart()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")

    caster:AddNewModifier(
        caster,
        self,
        "modifier_phantom_ex_basic_attack",
        { duration = duration }
   )

    self:PlayEffects()
end

function phantom_ex_basic_attack:PlayEffects()
    EmitSoundOn("Hero_PhantomAssassin.Blur", self:GetCaster())

    local particle_cast = "particles/econ/events/ti5/blink_dagger_end_sparkles_end_lvl2_ti5.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_POINT, self:GetCaster())
	ParticleManager:SetParticleControl(effect_cast, 3, self:GetCaster():GetOrigin())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(phantom_basic_attack)