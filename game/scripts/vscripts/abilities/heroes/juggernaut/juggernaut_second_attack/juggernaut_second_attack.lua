juggernaut_second_attack = class({})
juggernaut_ex_second_attack = class({})
LinkLuaModifier("modifier_juggernaut_spin_animation", "abilities/heroes/juggernaut/modifier_juggernaut_spin_animation", LUA_MODIFIER_MOTION_HORIZONTAL)
LinkLuaModifier("modifier_juggernaut_second_attack_recast", "abilities/heroes/juggernaut/modifier_juggernaut_second_attack_recast", LUA_MODIFIER_MOTION_HORIZONTAL)

function juggernaut_second_attack:OnAbilityPhaseStart()
	local caster = self:GetCaster()
	local particle_cast = "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_crit_tgt.vpcf"

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster)
    ParticleManager:SetParticleControl(effect_cast, 1, caster:GetOrigin())
    ParticleManager:SetParticleControl(effect_cast, 3, caster:GetOrigin())
	ParticleManager:ReleaseParticleIndex(effect_cast)
	return true
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
function juggernaut_second_attack:GetAnimationTranslate()		return "odachi" end

function juggernaut_second_attack:OnSpellStart()
	local random_number = RandomInt(0, 4)
	if random_number > 0 then
		EmitSoundOn("juggernaut_jug_attack_0" .. random_number, self:GetCaster())
	end

	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = Clamp(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), self:GetCastRange(Vector(0,0,0), nil))
	
	local damage = self:GetSpecialValueFor("ability_damage")
	local damage_per_stack = self:GetSpecialValueFor("damage_per_stack")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local radius = self:GetSpecialValueFor("radius")
	
	local direction = (Vector(point.x - origin.x, point.y - origin.y, 0)):Normalized()
	local stacks = SafeGetModifierStacks("modifier_juggernaut_basic_attack_stacks", caster, caster)
	local final_damage = damage + (stacks * damage_per_stack)

	if stacks <= 3 then
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
				damage = final_damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
			}
			ApplyDamage(damage_table)
			caster:GiveManaPercent(mana_gain_pct, enemy)
			
			self:PlayEffectsOnImpact(enemy)
	
			break
		end
		self:PlayEffectsOnFinish(point)
	else
		local give_mana = false
		local radius = 275 

		local enemies = caster:FindUnitsInRadius(
			caster:GetOrigin(), 
			radius, 
			DOTA_UNIT_TARGET_TEAM_ENEMY, 
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
			FIND_ANY_ORDER
		)
		
		for _,enemy in pairs(enemies) do
			if not enemy:IsObstacle() then
				give_mana = true
			end

			local damage_table = {
				victim = enemy,
				attacker = caster,
				damage = final_damage,
				damage_type = DAMAGE_TYPE_PURE,
			}
			ApplyDamage(damage_table)
			self:PlayEffectsOnImpact(enemy)
		end

		if give_mana == true then
			caster:GiveManaPercent(mana_gain_pct, nil)
		end

		caster:AddNewModifier(caster, self, "modifier_juggernaut_spin_animation", { duration = 0.3 })
		self:PlayEffectsAoe(radius)
	end

	SafeDestroyModifier("modifier_juggernaut_basic_attack_stacks", caster, caster)
end

function juggernaut_second_attack:PlayEffectsOnImpact(hTarget)
	EmitSoundOn("Hero_Juggernaut.BladeDance.Arcana", hTarget)
	EmitSoundOn("Hero_Juggernaut.BladeDance.Layer", hTarget)
	EmitSoundOn("Hero_Juggernaut.Attack", hTarget)
end

function juggernaut_second_attack:PlayEffectsOnFinish(pos)
	local caster = self:GetCaster()
	local offset = 40
	local origin = caster:GetOrigin()
	local direction = (pos - origin):Normalized()
	local final_position = origin + Vector(direction.x * offset, direction.y * offset, 0)

	EmitSoundOnLocationWithCaster(pos, "Hero_Juggernaut.BladeDance", caster)

	local position_final = caster:GetOrigin() + (pos - caster:GetOrigin()):Normalized() * 20

	local particle_cast_a = "particles/econ/items/chaos_knight/chaos_knight_ti9_weapon/chaos_knight_ti9_weapon_blur_crit_arc.vpcf"
	local effect_cast_a = ParticleManager:CreateParticle(particle_cast_a, PATTACH_POINT, caster)
    ParticleManager:SetParticleControl(
		effect_cast_a, 
		0, 
		Vector(position_final.x, position_final.y, caster:GetOrigin().z - 100)
	)
	ParticleManager:ReleaseParticleIndex(effect_cast_a)

	particle_cast = "particles/meele_swing_red/pa_arcana_attack_blinkb_red.vpcf"
	effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_POINT, caster)
	ParticleManager:SetParticleControl(effect_cast, 0, final_position)
	ParticleManager:SetParticleControlForward(effect_cast, 0, direction)	
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function juggernaut_second_attack:PlayEffectsAoe(radius)
	local caster = self:GetCaster()
	EmitSoundOn("juggernaut_jugsc_arc_ability_bladefury_12", caster)

	local particle_cast = "particles/econ/items/axe/axe_helm_shoutmask/axe_beserkers_call_owner_shoutmask.vpcf"
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster)
    ParticleManager:SetParticleControl(effect_cast, 2, Vector(radius, 1, 1))
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function juggernaut_ex_second_attack:GetCastAnimationCustom()		return ACT_DOTA_TAUNT end
function juggernaut_ex_second_attack:GetPlaybackRateOverride() 	return 2.0 end
function juggernaut_ex_second_attack:GetCastPointSpeed() 			return 10 end
function juggernaut_ex_second_attack:GetAnimationTranslate()		return "odachi" end

function juggernaut_ex_second_attack:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = Clamp(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), self:GetCastRange(Vector(0,0,0), nil))
	local ability_damage = self:GetSpecialValueFor("ability_damage")
	local duration = self:GetSpecialValueFor("duration")
	local duration_per_stack = self:GetSpecialValueFor("duration_per_stack")
	self.radius = self:GetSpecialValueFor("radius")
    
	local direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()
	local stacks = SafeGetModifierStacks("modifier_juggernaut_basic_attack_stacks", caster, caster)
	local final_stun_duration = duration + (stacks * duration_per_stack)

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
		enemy:AddNewModifier(caster, self , "modifier_generic_stunned", { duration = duration })

		local damage_table = {
			victim = enemy,
			attacker = caster,
			damage = ability_damage,
			damage_type = DAMAGE_TYPE_PHYSICAL,
			activate_counters = 1,
		}
		ApplyDamage(damage_table)
		
		self:PlayEffectsOnImpact(enemy)

		break
	end

	self:PlayEffectsOnFinish(point)
	self:PlayEffectsOnCast()
	SafeDestroyModifier("modifier_juggernaut_basic_attack_stacks", caster, caster)
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
Abilities.Tie(juggernaut_ex_second_attack, 'juggernaut_second_attack')
Abilities.Tie(juggernaut_second_attack, 'juggernaut_ex_second_attack')