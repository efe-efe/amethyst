juggernaut_second_attack = class({})
LinkLuaModifier( "modifier_juggernaut_second_attack", "abilities/heroes/juggernaut/juggernaut_second_attack/modifier_juggernaut_second_attack", LUA_MODIFIER_MOTION_HORIZONTAL )

function juggernaut_second_attack:OnSpellStart()
	local caster = self:GetCaster()
	local particle_cast = "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_crit_tgt.vpcf"

	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )
    ParticleManager:SetParticleControl( effect_cast, 1, caster:GetOrigin() )
    ParticleManager:SetParticleControl( effect_cast, 3, caster:GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function juggernaut_second_attack:OnCastPointEnd( )
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()
	local damage = self:GetAbilityDamage()

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
				if next(_self.rehit) == nil then
					self:PlayEffectsOnFinish(pos)
				end
			end,
		}
		Projectiles:CreateProjectile(projectile)
	else
		caster:AddNewModifier(caster, self, "modifier_juggernaut_second_attack", { duration = 0.3 })
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

		self:PlayEffectsAoe(radius)
	end

	SafeDestroyModifier("modifier_juggernaut_basic_attack_stacks", caster, caster)

end

--------------------------------------------------------------------------------
-- Effects
-- On Projectile Hit enemy
function juggernaut_second_attack:PlayEffectsOnImpact( hTarget )
	-- Create Sound
	local sound_cast_a = "Hero_Juggernaut.BladeDance.Arcana"
	local sound_cast_b = "Hero_Juggernaut.BladeDance.Layer"
	local sound_cast_c = "Hero_Juggernaut.Attack"
	EmitSoundOn( sound_cast_a, hTarget )
	EmitSoundOn( sound_cast_b, hTarget )
	EmitSoundOn( sound_cast_c, hTarget )
end

-- On Projectile Miss
function juggernaut_second_attack:PlayEffectsOnFinish(pos)
	local caster = self:GetCaster()
	local offset = 40
	local origin = caster:GetOrigin()
	local direction = (pos - origin):Normalized()
	local final_position = origin + Vector(direction.x * offset, direction.y * offset, 0)

	-- Create Sound
	local sound_cast = "Hero_Juggernaut.BladeDance"
	EmitSoundOnLocationWithCaster( pos, sound_cast, caster )

	local position_final = caster:GetOrigin() + (pos - caster:GetOrigin()):Normalized() * 20

	-- Create Particles
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

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	juggernaut_second_attack,
	{ activity = ACT_DOTA_ATTACK, translate = "odachi", rate = 1.5 },
	{ movement_speed = 40 }
)