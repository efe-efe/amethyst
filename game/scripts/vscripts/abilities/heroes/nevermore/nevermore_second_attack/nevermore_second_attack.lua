nevermore_second_attack = class({})
LinkLuaModifier( "modifier_nevermore_second_attack_recast", "abilities/heroes/nevermore/nevermore_second_attack/modifier_nevermore_second_attack_recast", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nevermore_second_attack", "abilities/heroes/nevermore/nevermore_second_attack/modifier_nevermore_second_attack", LUA_MODIFIER_MOTION_NONE )

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
		bIsReflectable = false,
		fGroundOffset = 80,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit) 
		end,
		OnFinish = function(_self, pos)
			local enemies = caster:FindUnitsInRadius(
				pos, 
				radius, 
				DOTA_UNIT_TARGET_TEAM_ENEMY, 
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_ANY_ORDER
			)
	
			-- for each affected enemies
			for _,enemy in pairs(enemies) do
				-- Apply damage
				local damage_table = {
					victim = enemy,
					attacker = caster,
					damage = damage,
					damage_type = DAMAGE_TYPE_MAGICAL,
				}
				ApplyDamage( damage_table )
			end
	
			if #enemies > 0 then
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
						{ duration = 5.0 }
					)
				else
					caster:RemoveModifierByName("modifier_nevermore_second_attack")
				end

				caster:GiveManaPercent(mana_gain_pct, unit)
			end

			self:PlayEffectsRaze( pos, radius )
		end,
	}

	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

function nevermore_second_attack:PlayEffectsOnCast()
	EmitSoundOn( "CAST_SOUND", self:GetCaster() )
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