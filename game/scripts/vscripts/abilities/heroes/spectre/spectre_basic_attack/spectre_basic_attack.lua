spectre_basic_attack = class({})
LinkLuaModifier( "modifier_spectre_desolate", "abilities/heroes/spectre/spectre_shared_modifiers/modifier_spectre_desolate/modifier_spectre_desolate", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spectre_basic_attack_cooldown", "abilities/heroes/spectre/spectre_basic_attack/modifier_spectre_basic_attack_cooldown", LUA_MODIFIER_MOTION_NONE )

function spectre_basic_attack:GetIntrinsicModifierName()
	return "modifier_spectre_basic_attack_cooldown"
end

function spectre_basic_attack:GetCastPointOverride()
	if IsServer() then
		return self:GetCaster():GetAttackAnimationPoint()
	end
end

function spectre_basic_attack:GetCooldown(iLevel)
	if IsServer() then
        local attacks_per_second = self:GetCaster():GetAttacksPerSecond()
        local attack_speed = ( 1 / attacks_per_second )
		
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
function spectre_basic_attack:GetCastPointSpeed() 		return 80 end

function spectre_basic_attack:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()
	local damage = caster:GetAverageTrueAttackDamage(caster)

	local desolate_duration = self:GetSpecialValueFor("desolate_duration")
	local silence_duration = self:GetSpecialValueFor("silence_duration")
    local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")

	local heal_charged = self:GetSpecialValueFor("heal_charged")
	local damage_bonus_charged = self:GetSpecialValueFor("damage_bonus_charged")
    local damage_bonus_desolate = self:GetSpecialValueFor("damage_bonus_desolate")
    local heal_desolate = self:GetSpecialValueFor("heal_desolate")

	local projectile_speed = 2000
	local projectile_direction = ( Vector( point.x - origin.x, point.y - origin.y, 0)):Normalized()
	local offset = 50

	local is_charged = caster:FindModifierByName("modifier_spectre_basic_attack_cooldown"):IsCooldownReady()
	
	local projectile = {
		vSpawnOrigin = origin + Vector(projectile_direction.x * offset, projectile_direction.y * offset, 0),
		fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fUniqueRadius = self:GetSpecialValueFor("hitbox"),
		Source = caster,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_NOTHING,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit)
			local counter = 0
			for k, v in pairs(_self.rehit) do counter = counter + 1 end
			if counter > 1 and not is_charged then return end

			local final_damage = damage
			if unit:HasModifier("modifier_spectre_desolate") then
				final_damage = final_damage + damage_bonus_desolate

				if not unit:IsObstacle() then
					_self.Source:Heal(heal_desolate, _self.Source)
					self:PlayEffectsLifeSteal()
				end
			end

			local damage_table = {
				victim = unit,
				attacker = _self.Source,
				damage = final_damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
				ability = self
			}
			ApplyDamage( damage_table )
		
			if is_charged then
				unit:AddNewModifier(_self.Source, self , "modifier_generic_silence", { duration = silence_duration })
				unit:AddNewModifier(_self.Source, self , "modifier_spectre_desolate", { duration = desolate_duration })

				if not unit:IsObstacle() then
					_self.Source:Heal( heal_charged, _self.Source )
				end
			end

			if _self.Source == caster and not unit:IsObstacle() then 
				caster:GiveManaPercent(mana_gain_pct, unit)
			end

			self:PlayEffectsOnImpact(unit, _self.current_position, is_charged)

			if _self.Source.OnBasicAttackImpact then
				_self.Source:OnBasicAttackImpact(unit)
			end
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos, is_charged)
		end,
	}

	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

function spectre_basic_attack:PlayEffectsOnFinish( pos, is_charged )
	local caster = self:GetCaster()
	local offset = 50
	local new_position = caster:GetOrigin() + (pos - caster:GetOrigin()):Normalized() * offset

	local particle_cast = "particles/units/heroes/hero_nyx_assassin/nyx_assassin_vendetta_swipe.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, new_position)
	ParticleManager:SetParticleControlForward( effect_cast, 0, (pos - caster:GetOrigin()):Normalized())
	ParticleManager:ReleaseParticleIndex( effect_cast )

	if is_charged then
		particle_cast = "particles/econ/items/juggernaut/jugg_ti8_sword/juggernaut_crimson_blade_fury_abyssal_start.vpcf"
		effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )
		ParticleManager:SetParticleControl( effect_cast, 2, caster:GetOrigin())
		ParticleManager:ReleaseParticleIndex( effect_cast )
		
		particle_cast = "particles/econ/items/dragon_knight/dk_immortal_dragon/dragon_knight_dragon_tail_dragonform_iron_dragon.vpcf"
		effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )
		ParticleManager:SetParticleControl( effect_cast, 2, caster:GetOrigin())
		ParticleManager:SetParticleControl( effect_cast, 4, caster:GetOrigin())
		ParticleManager:ReleaseParticleIndex( effect_cast )
	end
end

function spectre_basic_attack:PlayEffectsOnCast( )
	EmitSoundOn( "Hero_Spectre.PreAttack", self:GetCaster() )
end

function spectre_basic_attack:PlayEffectsOnImpact( hTarget, pos, is_charged )
	if is_charged then
		EmitSoundOn( "Hero_BountyHunter.Jinada", hTarget )
		
		local particle_cast = "particles/econ/items/slark/slark_ti6_blade/slark_ti6_blade_essence_shift.vpcf"
		local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT, hTarget )
		ParticleManager:ReleaseParticleIndex( effect_cast )
	else
		EmitSoundOn( "Hero_Spectre.Attack", hTarget )

		local caster = self:GetCaster()
		local offset = 50
		local new_position = caster:GetOrigin() + (pos - caster:GetOrigin()):Normalized() * offset
	
		local particle_cast = "particles/units/heroes/hero_spectre/spectre_desolate.vpcf"
		local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT, caster )
		ParticleManager:SetParticleControl( effect_cast, 0, pos)
		ParticleManager:SetParticleControlForward( effect_cast, 0, (pos - caster:GetOrigin() ):Normalized())
		ParticleManager:ReleaseParticleIndex( effect_cast )
	
		local particle_cast_b = "particles/units/heroes/hero_nyx_assassin/nyx_assassin_vendetta_swipe.vpcf"
		local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_WORLDORIGIN, nil )
		ParticleManager:SetParticleControl( effect_cast_b, 0, new_position)
		ParticleManager:SetParticleControlForward( effect_cast_b, 0, (pos - caster:GetOrigin()):Normalized())
		ParticleManager:ReleaseParticleIndex( effect_cast_b )
	end
end

function spectre_basic_attack:PlayEffectsLifeSteal()
	local particle_cast = "particles/econ/items/bloodseeker/bloodseeker_eztzhok_weapon/bloodseeker_bloodbath_heal_eztzhok.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(spectre_basic_attack)