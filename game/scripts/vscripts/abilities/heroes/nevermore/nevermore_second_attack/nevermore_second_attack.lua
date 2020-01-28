nevermore_second_attack = class({})
LinkLuaModifier( "modifier_nevermore_second_attack_recast", "abilities/heroes/nevermore/nevermore_second_attack/modifier_nevermore_second_attack_recast", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nevermore_second_attack", "abilities/heroes/nevermore/nevermore_second_attack/modifier_nevermore_second_attack", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nevermore_second_attack_debuff", "abilities/heroes/nevermore/nevermore_second_attack/modifier_nevermore_second_attack_debuff", LUA_MODIFIER_MOTION_NONE )


function nevermore_second_attack:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()

	-- Projectile data
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()

	-- Probable data
    local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local radius = self:GetSpecialValueFor("radius")
	local damage = self:GetSpecialValueFor("ability_damage")
	local damage_per_stack = self:GetSpecialValueFor("damage_per_stack")
	local recast_duration = self:GetSpecialValueFor("recast_duration")
	
	-- Projectile
	local projectile = {
		EffectName = "particles/mod_units/heroes/hero_nevermore/invoker_tornado_ti6.vpcf",
		vSpawnOrigin = origin + Vector(0, 0, 96),
		fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fUniqueRadius = self:GetSpecialValueFor("hitbox"),
		Source = caster,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_DESTROY,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_DESTROY,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 80,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnFinish = function(_self, pos)
			local enemies = _self.Source:FindUnitsInRadius(
				pos, 
				radius, 
				DOTA_UNIT_TARGET_TEAM_ENEMY, 
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_ANY_ORDER
			)

			local damage_table = {
				attacker = _self.Source,
				damage_type = DAMAGE_TYPE_PURE,
			}

			local should_recast = false
	
			for _,enemy in pairs(enemies) do
				if not enemy:IsObstacle() then
					should_recast = true
				end

				local stacks = SafeGetModifierStacks("modifier_nevermore_second_attack_debuff", enemy)

				damage_table.victim = enemy
				damage_table.damage = damage + stacks * damage_per_stack


				ApplyDamage( damage_table )

				enemy:AddNewModifier(_self.Source, self, "modifier_nevermore_second_attack_debuff", { duration = recast_duration })
			end
	
			if _self.Source == caster then
				if should_recast then
					local modifier = caster:AddNewModifier(
						caster,
						self,
						"modifier_nevermore_second_attack",
						{}
					)

					if modifier:GetStackCount() <= self:GetSpecialValueFor("recasts") then
						caster:AddNewModifier(
							caster,
							self,
							"modifier_nevermore_second_attack_recast",
							{ duration = recast_duration }
						)
					else
						caster:RemoveModifierByName("modifier_nevermore_second_attack")
					end
					caster:GiveManaPercent(mana_gain_pct, unit)
				else
					caster:RemoveModifierByName("modifier_nevermore_second_attack")
				end
			end

			self:PlayEffectsRaze( pos, radius )
		end,
	}

	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

function nevermore_second_attack:PlayEffectsOnCast()
	EmitSoundOn( "Hero_Nevermore.Attack", self:GetCaster() )
end

function nevermore_second_attack:PlayEffectsRaze( pos, radius )
	local caster = self:GetCaster()
    EmitSoundOnLocationWithCaster( pos, "Hero_Nevermore.Shadowraze", caster )
	
    local particle_cast = "particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf"
    local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, pos )
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, 1, 1 ) )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	nevermore_second_attack,
	{ activity = ACT_DOTA_RAZE_2, rate = 1.5 },
	{ movement_speed = 10, hide_indicator = 1, fixed_range = 1 },
	{ modifier_name = "modifier_nevermore_second_attack_recast" }
)