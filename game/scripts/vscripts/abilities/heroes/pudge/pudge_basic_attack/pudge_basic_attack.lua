pudge_basic_attack = class({})
LinkLuaModifier( "modifier_pudge_basic_attack", "abilities/heroes/pudge/pudge_basic_attack/modifier_pudge_basic_attack", LUA_MODIFIER_MOTION_NONE )

function pudge_basic_attack:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()

	local damage = caster:GetAttackDamage() -- or self:GetSpecialValueFor("ability_damage")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local duration =  self:GetSpecialValueFor("duration")

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
			local damage_table = {
				victim = unit,
				attacker = _self.Source,
				damage = damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
			}
			ApplyDamage( damage_table )
			self:PlayEffectsOnImpact(unit, _self.currentPosition)

			if _self.Source == caster then 
				unit:AddNewModifier(caster, self, "modifier_pudge_basic_attack", { duration = duration })
				caster:GiveManaPercent(mana_gain_pct, unit)
			end
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
function pudge_basic_attack:PlayEffectsOnFinish( pos )
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
end

function pudge_basic_attack:PlayEffectsOnCast()
	EmitSoundOn("Hero_Pudge.PreAttack", self:GetCaster())
end

function pudge_basic_attack:PlayEffectsOnImpact( hTarget, pos )
	EmitSoundOn("Hero_Pudge.Attack", hTarget)
end

if IsClient() then require("wrappers/abilities") end
Abilities.BasicAttack( pudge_basic_attack )
Abilities.Initialize( 
	pudge_basic_attack,
	{ activity = ACT_DOTA_ATTACK, rate = 1.0 },
	{ movement_speed = 40, hide_indicator = 1 }
)