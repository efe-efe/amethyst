item_basher_custom = class({})

function item_basher_custom:OnCastPointEnd( point )
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()
	local ability_damage = self:GetSpecialValueFor("ability_damage")
	local duration = self:GetSpecialValueFor("duration")
    
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
            unit:AddNewModifier(_self.Source, self , "modifier_generic_stunned", { duration = duration })

			local damage_table = {
				victim = unit,
				attacker = _self.Source,
				damage = ability_damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
				activate_counters = 1,
			}
            ApplyDamage( damage_table )
            
            self:PlayEffectsOnImpact(unit)
		end,
		OnFinish = function(_self, pos)
			if next(_self.rehit) == nil then
				self:PlayEffectsOnMiss(pos)
			end
			self:PlayEffectsOnFinish( pos )
		end,
	}
	-- Cast projectile
	Projectiles:CreateProjectile(projectile)
end


--------------------------------------------------------------------------------
-- Graphics & sounds
-- On Projectile Finish
function item_basher_custom:PlayEffectsOnFinish( pos )
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
    

    particle_cast = "particles/units/heroes/hero_spirit_breaker/spirit_breaker_greater_bash.vpcf"
	effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, final_position )
	ParticleManager:SetParticleControlForward(effect_cast, 0, direction)	
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function item_basher_custom:PlayEffectsOnImpact( hTarget )
	local sound_cast = "DOTA_Item.SkullBasher"
	EmitSoundOn( sound_cast, hTarget )

	local particle_cast = "particles/econ/items/troll_warlord/troll_warlord_ti7_axe/troll_ti7_axe_bash_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget )
	ParticleManager:SetParticleControl( effect_cast, 1, hTarget:GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function item_basher_custom:PlayEffectsOnMiss( pos )
	EmitSoundOnLocationWithCaster( pos, "Hero_Juggernaut.PreAttack", self:GetCaster() )
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	item_basher_custom,
	{ activity = ACT_DOTA_ATTACK, rate = 1.0 },
	{ movement_speed = 30 }
)