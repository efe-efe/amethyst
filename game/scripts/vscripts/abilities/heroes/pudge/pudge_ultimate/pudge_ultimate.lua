pudge_ultimate = class({})
LinkLuaModifier( "modifier_pudge_ultimate_thinker", "abilities/heroes/pudge/pudge_ultimate/modifier_pudge_ultimate_thinker", LUA_MODIFIER_MOTION_NONE )

function pudge_ultimate:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()
    local offset = 100

	-- Projectile data
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()

	-- Probable data
    local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local damage = caster:GetAttackDamage() -- or self:GetSpecialValueFor("ability_damage")

	-- Projectile
	local projectile = {
		EffectName = "PROJECTILE_PARTICLE_NAME",
		vSpawnOrigin = origin + Vector(projectile_direction.x * offset, projectile_direction.y * offset, 96),
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
		OnUnitHit = function(_self, unit) 
			local damage_table = {
				victim = unit,
				attacker = _self.Source,
				damage = damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
				ability = self
			}
			ApplyDamage( damage_table )

			
			if _self.Source == caster then 
				caster:GiveManaPercent(mana_gain_pct, unit)
			end
		end,
		OnFinish = function(_self, pos)
            self:PlayEffectsOnFinish(pos)
            
            CreateModifierThinker(
                caster, --hCaster
                self, --hAbility
                "modifier_pudge_ultimate_thinker", --modifierName
                { duration = 5.0 },
                pos, --vOrigin
                caster:GetTeamNumber(), --nTeamNumber
                false --bPhantomBlocker
            )
        end,
        OnThinkBegin = function(_self)
            self:PlayEffectsOnThink(_self.currentPosition)
        end
	}

    self:EndCooldown()
    caster:GiveMana(100)
	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end

function pudge_ultimate:PlayEffectsOnCast()
	EmitSoundOn( "CAST_SOUND", self:GetCaster() )
end

function pudge_ultimate:PlayEffectsOnFinish( pos )
	local caster = self:GetCaster()

	-- Create Sound
	EmitSoundOnLocationWithCaster( pos, "IMPACT_SOUND", caster )

	-- Create Particle
	local particle_cast = "IMPACT_PARTICLE"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	--ParticleManager:SetParticleControl( effect_cast, 3, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function pudge_ultimate:PlayEffectsOnThink( pos )
    local particle_cast = "particles/pudge_ultimate.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, Vector(pos.x, pos.y, pos.z - 384) )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector(pos.x, pos.y, pos.z - 384)  )
	ParticleManager:ReleaseParticleIndex( effect_cast )
    
end

if IsClient() then require("wrappers/abilities") end
--Abilities.BasicAttack( pudge_ultimate )
Abilities.Initialize( 
	pudge_ultimate,
	{ activity = ACT_DOTA_CHANNEL_ABILITY_4, rate = 0.5 },
	{ movement_speed = 10, fixed_range = 1 }
)