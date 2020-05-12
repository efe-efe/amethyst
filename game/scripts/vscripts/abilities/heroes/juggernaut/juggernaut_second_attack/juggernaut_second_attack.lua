juggernaut_second_attack = class({})
LinkLuaModifier( "modifier_juggernaut_spin_animation", "abilities/heroes/juggernaut/modifier_juggernaut_spin_animation", LUA_MODIFIER_MOTION_HORIZONTAL )

function juggernaut_second_attack:GetCastPoint()
	return self:GetSpecialValueFor("cast_point")
end

function juggernaut_second_attack:OnAbilityPhaseStart()
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_casting", { 
		duration = self:GetCastPoint(), 
		translate = "odachi",
		movement_speed = 40,
	})
	self:GetCaster():StartGestureWithPlaybackRate(self:GetCastAnimation(), 1.5)

	local caster = self:GetCaster()
	local particle_cast = "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_crit_tgt.vpcf"

	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )
    ParticleManager:SetParticleControl( effect_cast, 1, caster:GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 3, caster:GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	return true
end

function juggernaut_second_attack:GetCastAnimation() 
	if self:GetCaster():HasModifier("modifier_juggernaut_basic_attack_stacks") and self:GetCaster():FindModifierByName("modifier_juggernaut_basic_attack_stacks"):GetStackCount() >= 4 then 
		return ACT_DOTA_ATTACK
	else
		return ACT_DOTA_ATTACK_EVENT
	end
end

function juggernaut_second_attack:OnAbilityPhaseInterrupted()
	self:GetCaster():FadeGesture(self:GetCastAnimation())
	self:GetCaster():RemoveModifierByName("modifier_casting")
end

function juggernaut_second_attack:OnSpellStart( )
	self:GetCaster():FadeGesture(self:GetCastAnimation())
	
	local random_number = RandomInt(0, 4)
	if random_number > 0 then
		EmitSoundOn("juggernaut_jug_attack_0" .. random_number, self:GetCaster())
	end

	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()
	
	local damage = self:GetSpecialValueFor("ability_damage")
	local damage_per_stack = self:GetSpecialValueFor("damage_per_stack")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")

	-- Dinamyc data
	local projectile_speed = 2000
	local projectile_direction = ( Vector( point.x - origin.x, point.y - origin.y, 0)):Normalized()
	local offset = 80
	local stacks = SafeGetModifierStacks("modifier_juggernaut_basic_attack_stacks", caster, caster)
	local final_damage = damage + ( stacks * damage_per_stack )

	if stacks <= 3 then
		local projectile = {
			vSpawnOrigin = origin + Vector(projectile_direction.x * offset, projectile_direction.y * offset, 0),
			fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
			fUniqueRadius = self:GetSpecialValueFor("hitbox"),
			Source = caster,
			vVelocity = projectile_direction * projectile_speed,
			UnitBehavior = PROJECTILES_DESTROY,
			TreeBehavior = PROJECTILES_NOTHING,
			WallBehavior = PROJECTILES_DESTROY,
			GroundBehavior = PROJECTILES_NOTHING,
			fGroundOffset = 0,
			UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
			OnUnitHit = function(_self, unit) 
				local damage_table = {
					victim = unit,
					attacker = _self.Source,
					damage = final_damage,
					damage_type = DAMAGE_TYPE_PHYSICAL,
				}
				ApplyDamage( damage_table )
				
				--SendOverheadEventMessage(nil, OVERHEAD_ALERT_CRITICAL, unit, final_damage, nil )

				if _self.Source == caster then
					caster:GiveManaPercent(mana_gain_pct, unit)
				end
				
				self:PlayEffectsOnImpact(unit)
			end,
			OnFinish = function(_self, pos)
				self:PlayEffectsOnFinish(pos)
			end,
		}
		Projectiles:CreateProjectile(projectile)
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
			ApplyDamage( damage_table )
			--SendOverheadEventMessage(nil, OVERHEAD_ALERT_CRITICAL, enemy, final_damage, nil )
			self:PlayEffectsOnImpact(enemy)
		end

		if give_mana == true then
			caster:GiveManaPercent(mana_gain_pct, nil)
		end

		caster:AddNewModifier(caster, self, "modifier_juggernaut_spin_animation", { duration = 0.5 })
		self:PlayEffectsAoe(radius)
	end

	SafeDestroyModifier("modifier_juggernaut_basic_attack_stacks", caster, caster)
end

function juggernaut_second_attack:PlayEffectsOnImpact( hTarget )
	EmitSoundOn( "Hero_Juggernaut.BladeDance.Arcana", hTarget )
	EmitSoundOn( "Hero_Juggernaut.BladeDance.Layer", hTarget )
	EmitSoundOn( "Hero_Juggernaut.Attack", hTarget )
end

function juggernaut_second_attack:PlayEffectsOnFinish(pos)
	local caster = self:GetCaster()
	local offset = 40
	local origin = caster:GetOrigin()
	local direction = (pos - origin):Normalized()
	local final_position = origin + Vector(direction.x * offset, direction.y * offset, 0)

	EmitSoundOnLocationWithCaster( pos, "Hero_Juggernaut.BladeDance", caster )

	local position_final = caster:GetOrigin() + (pos - caster:GetOrigin()):Normalized() * 20

	local particle_cast_a = "particles/econ/items/chaos_knight/chaos_knight_ti9_weapon/chaos_knight_ti9_weapon_blur_crit_arc.vpcf"
	local effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_POINT, caster )
    ParticleManager:SetParticleControl( 
		effect_cast_a, 
		0, 
		Vector(position_final.x, position_final.y, caster:GetOrigin().z - 100)
	)
	ParticleManager:ReleaseParticleIndex( effect_cast_a )

	particle_cast = "particles/meele_swing_red/pa_arcana_attack_blinkb_red.vpcf"
	effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, final_position )
	ParticleManager:SetParticleControlForward(effect_cast, 0, direction)	
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function juggernaut_second_attack:PlayEffectsAoe( radius )
	local caster = self:GetCaster()
	EmitSoundOn("juggernaut_jugsc_arc_ability_bladefury_12", caster)

	local particle_cast = "particles/econ/items/axe/axe_helm_shoutmask/axe_beserkers_call_owner_shoutmask.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )
    ParticleManager:SetParticleControl( effect_cast, 2, Vector( radius, 1, 1 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end