pudge_special_attack = class({})

--------------------------------------------------------------------------------
-- Ability Start
function pudge_special_attack:OnCastPointEnd()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = CalcRange(caster:GetOrigin(), self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), self:GetCastRange(Vector(0,0,0), nil))
	local offset = 50
	
	-- Projectile data
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local damage = self:GetSpecialValueFor("ability_damage")
	
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()
	local distance = (point - origin):Length2D()
	local duration = (distance / projectile_speed) * 2.2
	local hitbox = self:GetSpecialValueFor("hitbox")

    if caster and caster:IsHero() then
		local hHook = caster:GetTogglableWearable( DOTA_LOADOUT_TYPE_WEAPON )
		if hHook ~= nil then
			hHook:AddEffects( EF_NODRAW )
		end
    end

	-- Projectile
	local projectile = {
		EffectName = "PROJECTILE_PARTICLE_NAME",
		vSpawnOrigin =		origin + Vector(projectile_direction.x * offset, projectile_direction.y * offset, 96),
		fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fUniqueRadius = hitbox,
		Source = caster,
		vVelocity = projectile_direction * (projectile_speed),
		UnitBehavior = PROJECTILES_DESTROY,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_NOTHING,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 80,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
		OnUnitHit = function(_self, unit) 
			local damage_table = {
				victim = unit,
				attacker = _self.Source,
				damage = damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
				ability = self
			}
			ApplyDamage( damage_table )

			local source_direction = (_self.Source:GetOrigin() - unit:GetOrigin()):Normalized()
			local source_distance = (_self.Source:GetOrigin() - unit:GetOrigin()):Length2D()
			unit:AddNewModifier(
				caster, -- player source
				self, -- ability source
				"modifier_generic_displacement", -- modifier name
				{
					x = source_direction.x,
					y = source_direction.y,
					r = source_distance - 160,
					speed = projectile_speed,
					peak = 0,
					colliding = 0,
					activity = ACT_DOTA_FLAIL,
					rate = 1.0,
				} -- kv
			)

			if _self.Source == caster then 
				caster:GiveManaPercent(mana_gain_pct, unit)
			end

			self:PlayEffectsOnImpact(source_distance, projectile_speed, unit)
		end,
		OnFinish = function(_self, pos)
			StopSoundOn("Hero_Pudge.AttackHookExtend", self:GetCaster())
			
			if next(_self.rehit) == nil then
				ParticleManager:SetParticleControlEnt( self.effect_cast, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_weapon_chain_rt", self:GetCaster():GetOrigin() , true);
			end--self:PlayEffectsOnFinish(pos)
		end,
	}

	self:EndCooldown()
	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast(projectile_speed, distance, hitbox, duration, Vector(point.x, point.y, 0))
end

function pudge_special_attack:PlayEffectsOnCast( speed, distance, hitbox, duration, direction )
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	EmitSoundOn( "Hero_Pudge.AttackHookExtend", caster )

	local particle_cast = "particles/units/heroes/hero_pudge/pudge_meathook.vpcf"
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_CUSTOMORIGIN, caster )
	ParticleManager:SetParticleAlwaysSimulate( self.effect_cast )
	ParticleManager:SetParticleControlEnt( self.effect_cast, 0, caster, PATTACH_POINT_FOLLOW, "attach_weapon_chain_rt", origin, true )
	ParticleManager:SetParticleControl( self.effect_cast, 1, direction )
	ParticleManager:SetParticleControl( self.effect_cast, 2, Vector( speed, distance, hitbox ) )
	ParticleManager:SetParticleControl( self.effect_cast, 3, Vector( duration, 0,0 ) )
	ParticleManager:SetParticleControl( self.effect_cast, 4, Vector( 1, 0, 0 ) )
	ParticleManager:SetParticleControl( self.effect_cast, 5, Vector( 1, 0, 0 ) )
	ParticleManager:SetParticleControlEnt( self.effect_cast, 7, caster, PATTACH_CUSTOMORIGIN, nil, origin, true )
end

function pudge_special_attack:PlayEffectsOnImpact( distance, speed, hTarget )
	EmitSoundOn( "Hero_Pudge.AttackHookImpact", hTarget )

	local new_duration = (distance / speed) * 2
	ParticleManager:SetParticleControl( self.effect_cast, 3, Vector( new_duration, 0,0 ) )
	ParticleManager:SetParticleControlEnt( self.effect_cast, 1, hTarget, PATTACH_POINT_FOLLOW, "attach_hitloc", hTarget:GetOrigin(), true )
	ParticleManager:SetParticleControl( self.effect_cast, 4, Vector( 0, 0, 0 ) )
	ParticleManager:SetParticleControl( self.effect_cast, 5, Vector( 1, 0, 0 ) )
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	pudge_special_attack,
	{ activity = ACT_DOTA_GENERIC_CHANNEL_1, rate = 2.0 },
	{ movement_speed = 30, fixed_range = 1 }
)