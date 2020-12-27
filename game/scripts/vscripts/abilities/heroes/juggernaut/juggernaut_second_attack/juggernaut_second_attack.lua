juggernaut_second_attack = class({})
juggernaut_ex_second_attack = class({})
LinkLuaModifier("modifier_juggernaut_spin_animation", "abilities/heroes/juggernaut/modifier_juggernaut_spin_animation", LUA_MODIFIER_MOTION_HORIZONTAL)
LinkLuaModifier("modifier_juggernaut_second_attack_recast", "abilities/heroes/juggernaut/modifier_juggernaut_second_attack_recast", LUA_MODIFIER_MOTION_HORIZONTAL)
LinkLuaModifier("modifier_juggernaut_swiftness", "abilities/heroes/juggernaut/modifier_juggernaut_swiftness", LUA_MODIFIER_MOTION_NONE)

function juggernaut_second_attack:OnAbilityPhaseStart()
	local caster = self:GetCaster()

	self.efx = EFX('particles/econ/items/windrunner/windranger_arcana/windranger_arcana_javelin_tgt_v2.vpcf', PATTACH_ABSORIGIN_FOLLOW, caster, {})
	return true
end


function juggernaut_second_attack:OnAbilityPhaseInterrupted()
	DEFX(self.efx, true)
end

function juggernaut_second_attack:GetCastAnimationCustom() 
	if self:GetCaster():HasModifier("modifier_juggernaut_basic_attack_stacks") and self:GetCaster():FindModifierByName("modifier_juggernaut_basic_attack_stacks"):GetStackCount() >= 4 then 
		return ACT_DOTA_ATTACK
	else
		return ACT_DOTA_ATTACK_EVENT
	end
end
function juggernaut_second_attack:GetPlaybackRateOverride() 	return 1.5 end
function juggernaut_second_attack:GetCastPointSpeed() 			return 40 end
function juggernaut_second_attack:GetAnimationTranslate()		return "ti8" end

function juggernaut_second_attack:OnSpellStart()
	local random_number = RandomInt(0, 4)
	if random_number > 0 then
		EmitSoundOn("juggernaut_jug_attack_0" .. random_number, self:GetCaster())
	end

	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = ClampPosition(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), self:GetCastRange(Vector(0,0,0), nil))
	
	local damage = self:GetSpecialValueFor("ability_damage")
	local damage_per_stack = self:GetSpecialValueFor("damage_per_stack")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local radius = self:GetSpecialValueFor("radius")
	local duration = self:GetSpecialValueFor("duration")
	local shield_per_stack = self:GetSpecialValueFor("shield_per_stack")
	local juggernaut_ex_second_attack = caster:FindAbilityByName('juggernaut_ex_second_attack')
	
	local direction = (Vector(point.x - origin.x, point.y - origin.y, 0)):Normalized()
	local stacks = SafeGetModifierStacks("modifier_juggernaut_basic_attack_stacks", caster, caster)
	local final_damage = damage + (stacks * damage_per_stack)
	local shield_providers = 0

	local give_mana = false
	local enemies = {}
	local damage_table = {
		attacker = caster,
		damage = final_damage,
	}

	if stacks <= 3 then
		enemies = caster:FindUnitsInCone(
			direction, 
			0, 
			origin, 
			radius, 
			DOTA_UNIT_TARGET_TEAM_ENEMY, 
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
			DOTA_UNIT_TARGET_FLAG_NONE, 
			FIND_CLOSEST
		)
		damage_table.damage_type = DAMAGE_TYPE_PHYSICAL
		self:PlayEffectsOnFinish(direction, radius)
	else
		local radius = 275 
		enemies = caster:FindUnitsInRadius(
			caster:GetOrigin(), 
			radius, 
			DOTA_UNIT_TARGET_TEAM_ENEMY, 
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
			FIND_ANY_ORDER
		)
		damage_table.damage_type = DAMAGE_TYPE_PURE
		caster:AddNewModifier(caster, self, "modifier_juggernaut_spin_animation", { duration = 0.3 })
		self:PlayEffectsAoe(radius)
	end

	for _,enemy in pairs(enemies) do
		if enemy:ProvidesMana() then
			give_mana = true
		end

		if not enemy:IsObstacle() then
			shield_providers = shield_providers + 1
		end

		damage_table.victim = enemy
		damage_table.damage = final_damage

		ApplyDamage(damage_table)
		self:PlayEffectsOnImpact(enemy)
	end

	if give_mana then
		caster:GiveManaPercent(mana_gain_pct, nil)
	end
	
	if #enemies > 0 then
		ScreenShake(point, 100, 300, 0.7, 1000, 0, true)
	end

	if self:GetLevel() >= 2 and stacks > 0 and shield_providers > 0 then
		local final_shield = stacks * shield_per_stack * shield_providers
		caster:AddNewModifier(caster, self, 'modifier_shield', { damage_block = final_shield, duration = duration })
	end

	SafeDestroyModifier("modifier_juggernaut_basic_attack_stacks", caster, caster)
	LinkAbilityCooldowns(caster, 'juggernaut_ex_second_attack')
end

function juggernaut_second_attack:PlayEffectsOnImpact(hTarget)
	EFX('particles/units/heroes/hero_bounty_hunter/bounty_hunter_jinda_slow.vpcf', PATTACH_ABSORIGIN, hTarget, {
		release = true
	})

	EmitSoundOn("Hero_Juggernaut.BladeDance.Arcana", hTarget)
	EmitSoundOn("Hero_Juggernaut.BladeDance.Layer", hTarget)
	EmitSoundOn("Hero_Juggernaut.Attack", hTarget)
end

function juggernaut_second_attack:PlayEffectsOnFinish(vDirection, iRadius)
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()

	EmitSoundOnLocationWithCaster(origin, "Hero_Juggernaut.BladeDance", caster)
	EFX('particles/juggernaut/juggernaut_second_attack_parent.vpcf', PATTACH_WORLDORIGIN, nil, {
		cp0 = origin,
		cp0f = vDirection,
		cp3 = Vector(iRadius, 0, 0),
		release = true,
	})
end

function juggernaut_second_attack:PlayEffectsAoe(radius)
	local caster = self:GetCaster()
	EmitSoundOn("juggernaut_jugsc_arc_ability_bladefury_12", caster)

	local particle_cast = "particles/econ/items/axe/axe_helm_shoutmask/axe_beserkers_call_owner_shoutmask.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster)
    ParticleManager:SetParticleControl(effect_cast, 2, Vector(radius, 1, 1))
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function juggernaut_ex_second_attack:GetCastAnimationCustom()		return ACT_DOTA_OVERRIDE_ABILITY_1 end
function juggernaut_ex_second_attack:GetPlaybackRateOverride() 		return 0.5 end
function juggernaut_ex_second_attack:GetAnimationTranslate()		return "odachi" end
function juggernaut_ex_second_attack:GetCastPointSpeed() 			return 10 end

function juggernaut_ex_second_attack:OnAbilityPhaseStart()
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_juggernaut_spin_animation", { duration = 0.3 })
	EmitSoundOn("juggernaut_jugg_ability_bladefury_12", self:GetCaster())
	
	EFX('particles/juggernaut/juggernaut_ex_second_attack_casting_owner.vpcf', PATTACH_ABSORIGIN_FOLLOW, self:GetCaster(), {
		release = true
	})
	self.efx = EFX('particles/juggernaut/juggernaut_ex_second_attack_casting.vpcf', PATTACH_ABSORIGIN_FOLLOW, self:GetCaster(), {})
	return true
end

function juggernaut_ex_second_attack:OnAbilityPhaseInterrupted()
	DEFX(self.efx, true)
end

function juggernaut_ex_second_attack:OnSpellStart()
	DEFX(self.efx, true)
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = ClampPosition(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), self:GetCastRange(Vector(0,0,0), nil))
	local ability_damage = self:GetSpecialValueFor("ability_damage")
	local duration = self:GetSpecialValueFor("duration")
	local duration_per_stack = self:GetSpecialValueFor("duration_per_stack")
	self.radius = self:GetSpecialValueFor("radius")
	local give_mana = false
	local swiftness_duration = self:GetSpecialValueFor("swiftness_duration")
	local swiftness_pct = self:GetSpecialValueFor("swiftness_pct")
	local juggernaut_basic_attack = caster:FindAbilityByName("juggernaut_basic_attack")
	local direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()
	
	local stacks = SafeGetModifierStacks("modifier_juggernaut_basic_attack_stacks", caster, caster)
	local final_debuff_duration = duration + (stacks * duration_per_stack)
	local enemies = caster:FindUnitsInCone(
		direction, 
		0, 
		origin, 
		self.radius, 
		DOTA_UNIT_TARGET_TEAM_ENEMY, 
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
		DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_CLOSEST
	)

	for _,enemy in pairs(enemies) do
		local damage_table = {
			victim = enemy,
			attacker = caster,
			damage = ability_damage,
			damage_type = DAMAGE_TYPE_PHYSICAL,
		}
		ApplyDamage(damage_table)

		enemy:AddNewModifier(caster, self, "modifier_generic_sleep", { duration = final_debuff_duration })

		if not enemy:IsObstacle() then
			give_mana = true
		end
		self:PlayEffectsOnImpact(enemy)
	end

	SafeDestroyModifier("modifier_juggernaut_basic_attack_stacks", caster, caster)

	if self:GetLevel() >= 2 then
		if give_mana then
			caster:GiveManaCustom(self:GetManaCost(self:GetLevel()))

			for i = 0, 3 do
				caster:AddNewModifier(caster, juggernaut_basic_attack, "modifier_juggernaut_basic_attack_stacks", {})
			end

			caster:AddNewModifier(caster, self, 'modifier_juggernaut_swiftness', { 
			   duration = swiftness_duration,
			   swiftness_pct =  swiftness_pct
			})
		end
	end

	self:PlayEffectsOnFinish(point)
	self:PlayEffectsOnCast()
	LinkAbilityCooldowns(caster, 'juggernaut_second_attack')
end

function juggernaut_ex_second_attack:PlayEffectsOnCast()
	EmitSoundOn("DOTA_Item.SkullBasher", self:GetCaster())
	
end

function juggernaut_ex_second_attack:PlayEffectsOnFinish(pos)
	local caster = self:GetCaster()
	local offset = 40
	local origin = caster:GetOrigin()
	local direction = (pos - origin):Normalized()
	local final_position = origin + Vector(direction.x * offset, direction.y * offset, 0)

	local particle_cast = "particles/juggernaut/juggernaut_ex_second_attack.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, self:GetCaster())
	ParticleManager:SetParticleControl(effect_cast, 0, self:GetCaster():GetOrigin())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(self.radius, self.radius, self.radius))
	ParticleManager:SetParticleControlForward(effect_cast, 0, direction)
	ParticleManager:ReleaseParticleIndex(effect_cast)

    particle_cast = "particles/units/heroes/hero_spirit_breaker/spirit_breaker_greater_bash.vpcf"
	effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_POINT, caster)
	ParticleManager:SetParticleControl(effect_cast, 0, final_position)
	ParticleManager:SetParticleControlForward(effect_cast, 0, direction)	
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function juggernaut_ex_second_attack:PlayEffectsOnImpact(hTarget)
	local particle_cast = "particles/econ/items/troll_warlord/troll_warlord_ti7_axe/troll_ti7_axe_bash_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget)
	ParticleManager:SetParticleControl(effect_cast, 1, hTarget:GetOrigin())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function juggernaut_ex_second_attack:PlayEffectsOnMiss(pos)
	EmitSoundOnLocationWithCaster(pos, "Hero_Juggernaut.PreAttack", self:GetCaster())
end


if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(juggernaut_second_attack)
Abilities.Castpoint(juggernaut_ex_second_attack)