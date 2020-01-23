pudge_second_attack = class({})
LinkLuaModifier( "modifier_pudge_second_attack", "abilities/heroes/pudge/pudge_second_attack/modifier_pudge_second_attack", LUA_MODIFIER_MOTION_NONE )

function pudge_second_attack:OnSpellStart()
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_pudge_second_attack", {} )
	EmitSoundOn("Hero_Pudge.Dismember.Gore.Arcana", self:GetCaster())
end

function pudge_second_attack:OnStopPseudoCastPoint()
	SafeDestroyModifier("modifier_pudge_second_attack", self:GetCaster(), self:GetCaster())
end

function pudge_second_attack:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()
	local stacks = SafeGetModifierStacks("modifier_pudge_second_attack", caster, caster)

	local damage = self:GetSpecialValueFor("ability_damage")
	local heal = self:GetSpecialValueFor("heal")
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
			local damage_table = {
				victim = unit,
				attacker = _self.Source,
				damage = damage + 1.5 * (stacks/10),
				damage_type = DAMAGE_TYPE_PHYSICAL,
			}
			ApplyDamage( damage_table )

			if _self.Source == caster then 
				caster:Heal(heal + 1.25 * (stacks/10) , caster)
				caster:GiveManaPercent(mana_gain_pct, unit)
			end
			self:PlayEffectsOnImpact(unit, _self.current_position)
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
	}

    Projectiles:CreateProjectile(projectile)
    
    StartAnimation(caster, { 
        duration = 0.2, 
        activity = ACT_DOTA_ATTACK, 
        rate = 1.5
    })
	SafeDestroyModifier("modifier_pudge_second_attack", caster, caster)

	self:PlayEffectsOnCast()
end

--------------------------------------------------------------------------------
-- Graphics & sounds
function pudge_second_attack:PlayEffectsOnFinish( pos )
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

function pudge_second_attack:PlayEffectsOnCast( )
end

function pudge_second_attack:PlayEffectsOnImpact( hTarget, pos )
	EmitSoundOn("Hero_Pudge.Attack", hTarget)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	pudge_second_attack,
	{ activity = ACT_DOTA_ATTACK, rate = 0.2 },
	{ movement_speed = 70, hide_indicator = 1 }
)

function pudge_second_attack:CastOnRelease() 
    return true 
end