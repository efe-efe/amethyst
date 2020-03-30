juggernaut_basic_attack = class({})
LinkLuaModifier( "modifier_juggernaut_basic_attack_stacks", "abilities/heroes/juggernaut/juggernaut_basic_attack/modifier_juggernaut_basic_attack_stacks", LUA_MODIFIER_MOTION_NONE )

function juggernaut_basic_attack:OnCastPointEnd( point )
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()
	local attack_damage = caster:GetAttackDamage()

	local cooldown_reduction = self:GetSpecialValueFor("cooldown_reduction")
	local stun_duration = 0.0--caster:FindAbilityByName("juggernaut_ex_second_attack"):GetSpecialValueFor("stun_duration")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local perform_special = caster:HasModifier("modifier_juggernaut_ex_second_attack") and true or false
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()
	local offset = 80
	local projectile_speed = 2000

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
			if perform_special == true then
				unit:AddNewModifier(_self.Source, self , "modifier_generic_stunned", { duration = stun_duration })
				self:PlayEffectsOnImpactBash(unit)
			else
				self:PlayEffectsOnImpact(unit)
			end

			local damage_table = {
				victim = unit,
				attacker = _self.Source,
				damage = attack_damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
				activate_counters = 1,
			}
			ApplyDamage( damage_table )

			if _self.Source == caster and not unit:IsObstacle() then 
				caster:GiveManaPercent(mana_gain_pct, unit)
				-- Add modifier
				caster:AddNewModifier(
					caster, -- player source
					self, -- ability source
					"modifier_juggernaut_basic_attack_stacks", -- modifier name
					{} -- kv
				)

				-- Reduce the cd of the second attack by 1
				local second_attack = caster:FindAbilityByName("juggernaut_second_attack")
				local second_attack_cd = second_attack:GetCooldownTimeRemaining()
				local new_cd = second_attack_cd - cooldown_reduction

				if (new_cd) < 0 then 
					second_attack:EndCooldown()
				else
					second_attack:EndCooldown()
					second_attack:StartCooldown(new_cd)
				end
			end

			if _self.Source.OnBasicAttackImpact then
				_self.Source:OnBasicAttackImpact(unit)
			end
		end,
		OnFinish = function(_self, pos)
			if next(_self.rehit) == nil then
				self:PlayEffectsOnMiss(pos)
			end
			self:PlayEffectsOnFinish( pos )
		end,
	}

	Projectiles:CreateProjectile(projectile)
end

--------------------------------------------------------------------------------
-- Graphics & sounds
function juggernaut_basic_attack:PlayEffectsOnFinish( pos )
	local caster = self:GetCaster()
	local offset = 40
	local origin = caster:GetOrigin()
	local direction = (pos - origin):Normalized()
	local final_position = origin + Vector(direction.x * offset, direction.y * offset, 0)

	-- Create Particles
	local particle_cast = "particles/meele_swing_red/pa_arcana_attack_blinkb_red.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, final_position )
	ParticleManager:SetParticleControlForward(effect_cast, 0, direction)	
	ParticleManager:ReleaseParticleIndex( effect_cast )

	particle_cast = "particles/econ/items/juggernaut/jugg_ti8_sword/juggernaut_ti8_sword_crit_golden.vpcf"
	effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT, caster )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function juggernaut_basic_attack:PlayEffectsOnImpact( hTarget )
	EmitSoundOn( "Hero_Juggernaut.Attack", hTarget )
end

function juggernaut_basic_attack:PlayEffectsOnImpactBash( hTarget )
	EmitSoundOn( "DOTA_Item.AbyssalBlade.Activate", hTarget )

	local particle_cast = "particles/items_fx/abyssal_blade_crimson_jugger.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function juggernaut_basic_attack:PlayEffectsOnMiss( pos )
	EmitSoundOnLocationWithCaster( pos, "Hero_Juggernaut.PreAttack", self:GetCaster() )
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	juggernaut_basic_attack,
	{ activity = ACT_DOTA_ATTACK_EVENT, rate = 1.8 },
	{ movement_speed = 80 }
)
Abilities.BasicAttack( juggernaut_basic_attack )