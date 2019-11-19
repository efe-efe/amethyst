juggernaut_basic_attack = class({})
LinkLuaModifier( "modifier_juggernaut_basic_attack_stacks", "abilities/heroes/juggernaut/juggernaut_basic_attack/modifier_juggernaut_basic_attack_stacks", LUA_MODIFIER_MOTION_NONE )

function juggernaut_basic_attack:OnCastPointEnd( point )
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()
	local attack_damage = caster:GetAttackDamage()
	
	local cooldown_reduction = self:GetSpecialValueFor("cooldown_reduction")
	local stun_duration = caster:FindAbilityByName("juggernaut_ex_second_attack"):GetSpecialValueFor("stun_duration")
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
				self:PlayEffectsBash(unit)
			else
				self:PlayEffects_b(unit)
			end

			local damage_table = {
				victim = unit,
				attacker = _self.Source,
				damage = attack_damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
				activate_counters = 1,
			}
			ApplyDamage( damage_table )

			if _self.Source == caster then 
				caster:GiveManaPercent(mana_gain_pct, unit)
				if unit:IsRealHero() then 
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
			end

		end,
		OnFinish = function(_self, pos)
			if next(_self.rehit) == nil then
				self:PlayEffects_c(pos)
			end
			self:PlayEffects_a(pos)
		end,
	}
	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
end

--------------------------------------------------------------------------------
-- Misc
-- Add mana on attack modifier. Only first time upgraded
function juggernaut_basic_attack:OnUpgrade()
	if self:GetLevel()==1 then
		local caster = self:GetCaster()
		-- Gain mana
		caster:AddNewModifier(caster, self , "modifier_mana_on_attack", {})
	end
end

--------------------------------------------------------------------------------
-- Graphics & sounds

-- On Projectile Finish
function juggernaut_basic_attack:PlayEffects_a( pos )
	local caster = self:GetCaster()
	-- Create Particles
	local particle_cast_a = "particles/econ/items/juggernaut/jugg_ti8_sword/juggernaut_ti8_sword_crit_golden.vpcf"
	local effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_POINT, caster )
	ParticleManager:ReleaseParticleIndex( effect_cast_a )
end

-- On Projectile Hit enemy
function juggernaut_basic_attack:PlayEffects_b( hTarget )
	local sound_cast = "Hero_Juggernaut.Attack"
	EmitSoundOn( sound_cast, hTarget )
end

-- On Projectile Hit enemy Special
function juggernaut_basic_attack:PlayEffectsBash( hTarget )
	local sound_cast = "DOTA_Item.AbyssalBlade.Activate"
	EmitSoundOn( sound_cast, hTarget )

	local particle_cast_a = "particles/items_fx/abyssal_blade_crimson_jugger.vpcf"
	local effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_ABSORIGIN_FOLLOW, hTarget )
	ParticleManager:ReleaseParticleIndex( effect_cast_a )
end

-- On Projectile miss
function juggernaut_basic_attack:PlayEffects_c( pos )
	local sound_cast = "Hero_Juggernaut.PreAttack"
	EmitSoundOnLocationWithCaster( pos, sound_cast, self:GetCaster() )
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	juggernaut_basic_attack,
	{ activity = ACT_DOTA_ATTACK_EVENT, rate = 1.8 },
	{ movement_speed = 80 }
)
Abilities.BasicAttack( juggernaut_basic_attack )