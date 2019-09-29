attack_name = class({})
LinkLuaModifier( "modifier_treant_natures_punishment", "abilities/heroes/treant/treant_shared_modifiers/modifier_treant_natures_punishment", LUA_MODIFIER_MOTION_NONE )

function attack_name:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()
	local attack_damage = caster:GetAttackDamage()

	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")/100
	
	local projectile_speed = 3000
	local projectile_direction = ( Vector( point.x - origin.x, point.y - origin.y, 0)):Normalized()

	local projectile = {
		vSpawnOrigin =		origin + Vector(0,0,80),
		fDistance =			self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fUniqueRadius =		self:GetSpecialValueFor("hitbox"),
		Source =			caster,
		vVelocity =			projectile_direction * projectile_speed,
		UnitBehavior =		PROJECTILES_NOTHING,
		TreeBehavior =		PROJECTILES_NOTHING,
		WallBehavior =		PROJECTILES_DESTROY,
		GroundBehavior =	PROJECTILES_NOTHING,
		fGroundOffset =		0,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" end,
		OnUnitHit = function(_self, unit)
			self:PlayEffectsOnImpact(unit, _self.currentPosition)
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}
	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

--------------------------------------------------------------------------------
-- Misc
-- Add mana on attack modifier. Only first time upgraded
function attack_name:OnUpgrade()
	if self:GetLevel()==1 then
		local caster = self:GetCaster()
		-- Gain mana
		caster:AddNewModifier(caster, self , "modifier_mana_on_attack", {})
	end
end

--------------------------------------------------------------------------------
-- Graphics & sounds

-- On Projectile Finish
function attack_name:PlayEffectsOnFinish( pos )
end

function attack_name:PlayEffectsOnCast( )
end

-- On Projectile Hit enemy
function attack_name:PlayEffectsOnImpact( hTarget, pos )
end

if IsClient() then require("abilities") end
Abilities.Initialize( 
	attack_name,
	{ activity = ACT_DOTA_ATTACK, rate = 1.8 },
	{ movement_speed = 30, hide_indicator = 1 }
)
Abilities.BasicAttack( attack_name )