juggernaut_basic_attack = class({})
LinkLuaModifier( 
	"modifier_juggernaut_basic_attack_stacks", 
	"abilities/heroes/juggernaut/juggernaut_basic_attack/modifier_juggernaut_basic_attack_stacks", 
	LUA_MODIFIER_MOTION_NONE 
)

--------------------------------------------------------------------------------
-- Ability Start
function juggernaut_basic_attack:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = caster:GetAttackAnimationPoint()
	StartAnimation(caster, {duration = 0.4, activity=ACT_DOTA_ATTACK_EVENT, rate=1.8})
	
	caster:AddNewModifier( caster, self, "modifier_generic_pseudo_cast_point", { 
		duration = cast_point, 
		movement_speed = 90,
		placeholder = 0,
	})
end

function juggernaut_basic_attack:OnEndPseudoCastPoint( point )
	local caster = self:GetCaster()
	local offset = 20

	-- Projectile data
    local projectile_name = ""
	local projectile_start_radius = 50
	local projectile_end_radius = self:GetSpecialValueFor("hitbox")
	local projectile_distance = self:GetSpecialValueFor("projectile_range")
	local projectile_speed = 2000
	
	local cooldown_reduction = self:GetSpecialValueFor("cooldown_reduction")
	local stun_duration = caster:FindAbilityByName("juggernaut_ex_second_attack"):GetSpecialValueFor("stun_duration")
	local attacks_per_second = caster:GetAttacksPerSecond()
	local attack_speed = ( 1 / attacks_per_second )

	local attack_damage = caster:GetAttackDamage()
	local mana_gain = self:GetSpecialValueFor("mana_gain")/100
	local perform_special = false

	-- Dinamyc data
	local origin = caster:GetOrigin()
	local direction_normalized = (point - origin):Normalized()
	local final_position = origin + Vector(direction_normalized.x * offset, direction_normalized.y * offset, 0)
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()


	--Check if we should crit and stun
	if caster:HasModifier("modifier_juggernaut_ex_second_attack") then
		perform_special = true
	end


	local projectile = {
		EffectName = projectile_name,
		vSpawnOrigin = final_position + Vector(0,0,80),
		fDistance = projectile_distance,
		fStartRadius = projectile_start_radius,
		fEndRadius = projectile_end_radius,
		Source = caster,
		fExpireTime = 8.0,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_DESTROY,
		bMultipleHits = false,
		bIgnoreSource = true,
		TreeBehavior = PROJECTILES_NOTHING,
		bCutTrees = true,
		bTreeFullCollision = false,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 0,
		nChangeMax = 1,
		bRecreateOnChange = true,
		bZCheck = false,
		bGroundLock = true,
		bProvidesVision = true,
		iVisionRadius = 200,
		iVisionTeamNumber = caster:GetTeam(),
		bFlyingVision = false,
		fVisionTickTime = .1,
		fVisionLingerDuration = 1,
		draw = false,
		fRehitDelay = 1.0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and unit:GetTeamNumber() ~= _self.Source:GetTeamNumber() end,
		OnUnitHit = function(_self, unit)
			if perform_special == true then
				unit:AddNewModifier(_self.Source, self , "modifier_generic_stunned_lua", { duration = stun_duration })
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
				local mana_gain_final = caster:GetMaxMana() * mana_gain
				caster:GiveMana(mana_gain_final)

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
	self:StartCooldown(attack_speed)
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

