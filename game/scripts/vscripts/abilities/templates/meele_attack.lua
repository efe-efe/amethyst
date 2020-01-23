ability_name = class({})
LinkLuaModifier( "modifier_ability_name", "abilities/heroes/hero_name/ability_name/modifier_ability_name", LUA_MODIFIER_MOTION_NONE )

function ability_name:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()

	local damage = caster:GetAttackDamage() -- or self:GetSpecialValueFor("ability_damage")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	
	local offset = 80
	local projectile_speed = 2000
	local projectile_direction = ( Vector( point.x - origin.x, point.y - origin.y, 0)):Normalized()

	local projectile = {
		vSpawnOrigin =		origin + Vector(projectile_direction.x * offset, projectile_direction.y * offset, 0),
		fDistance =			self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fUniqueRadius =		self:GetSpecialValueFor("hitbox"),
		Source =			caster,
		vVelocity =			projectile_direction * projectile_speed,
		UnitBehavior =		PROJECTILES_DESTROY,
		TreeBehavior =		PROJECTILES_NOTHING,
		WallBehavior =		PROJECTILES_DESTROY,
		GroundBehavior =	PROJECTILES_NOTHING,
		fGroundOffset =		0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit)
			if _self.Source == caster then 
				caster:GiveManaPercent(mana_gain_pct, unit)
			end
			self:PlayEffectsOnImpact(unit, _self.current_position)
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}

	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

--------------------------------------------------------------------------------
-- Graphics & sounds
function ability_name:PlayEffectsOnFinish( pos )
end

function ability_name:PlayEffectsOnCast( )
end

function ability_name:PlayEffectsOnImpact( hTarget, pos )
end

if IsClient() then require("wrappers/abilities") end
--Abilities.BasicAttack( ability_name )
Abilities.Initialize( 
	ability_name,
	{ activity = ACT_DOTA_ATTACK, rate = 1.5 },
	{ movement_speed = 80, hide_indicator = 1 }
)