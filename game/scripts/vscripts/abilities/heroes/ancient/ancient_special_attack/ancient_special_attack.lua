ancient_special_attack = class({})

LinkLuaModifier( "modifier_ancient_special_attack_charges", "abilities/heroes/ancient/ancient_special_attack/modifier_ancient_special_attack_charges", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ancient_special_attack", "abilities/heroes/ancient/ancient_special_attack/modifier_ancient_special_attack", LUA_MODIFIER_MOTION_NONE )




--------------------------------------------------------------------------------
-- Passive Modifier
function ancient_special_attack:GetIntrinsicModifierName()
	return "modifier_ancient_special_attack_charges"
end

function ancient_special_attack:HasCharges()
	return true
end

function ancient_special_attack:OnSpellStart()
	local particle_cast = "particles/units/heroes/hero_keeper_of_the_light/keeper_chakra_magic.vpcf"
    local effect_cast = ParticleManager:CreateParticle( 
        particle_cast, 
        PATTACH_CUSTOMORIGIN, 
        self:GetCaster()
    )

    ParticleManager:SetParticleControlEnt( 
        effect_cast, 
        0, 
        self:GetCaster(), 
        PATTACH_POINT_FOLLOW, 
        "attach_hitloc", 
        self:GetCaster():GetOrigin(), 
        true 
	)
	ParticleManager:SetParticleControlEnt( 
        effect_cast, 
        1, 
        self:GetCaster(), 
        PATTACH_POINT_FOLLOW, 
        "attach_hitloc", 
        self:GetCaster():GetOrigin(), 
        true 
    )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end


function ancient_special_attack:OnCastPointEnd()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
    local origin = caster:GetOrigin()
	local damage = self:GetSpecialValueFor("ability_damage")
	local consume_damage = self:GetSpecialValueFor("consume_damage")
	
	-- Extra data
	local duration = self:GetSpecialValueFor("duration")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local knockback_distance = self:GetSpecialValueFor("knockback_distance")
	
	-- Dinamyc data
	local projectile_direction = (Vector( point.x-origin.x, point.y-origin.y, 0 )):Normalized()
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	local projectile = {
		EffectName = "particles/ranged_tower_good.vpcf",
		vSpawnOrigin = caster:GetAbsOrigin() + Vector(0,0,80),
		fDistance =	self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
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
			local final_damage = damage

			if _self.Source == caster then
				caster:GiveManaPercent(mana_gain_pct, unit)

				if unit:HasModifier("modifier_ancient_special_attack") then
					unit:RemoveModifierByName("modifier_ancient_special_attack")
					final_damage = final_damage + consume_damage

					unit:AddNewModifier(
						caster, -- player source
						self, -- ability source
						"modifier_generic_displacement", -- modifier name
						{
							x = projectile_direction.x,
							y = projectile_direction.y,
							r = knockback_distance,
							speed = 1350,
							peak = 100,
							restricted = 1,
						} -- kv
					)
					self:PlayEffectsConsume(unit)
				else
					unit:AddNewModifier(caster, self, "modifier_ancient_special_attack", { duration = duration })
				end
			end
			
			local damage_table = {
				victim = unit,
				attacker = caster,
				damage = final_damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
			}
			ApplyDamage( damage_table )
		end,
		OnFinish = function(_self, pos)
			self:PlayEffectsOnFinish(pos)
		end,
		OnThinkBegin = function(_self)
			self:PlayEffectsOnThink(_self.currentPosition)
		end
	}

	Projectiles:CreateProjectile(projectile)
	self:PlayEffectsOnCast()
end


--------------------------------------------------------------------------------
-- Effects
function ancient_special_attack:PlayEffectsOnThink( pos )
	local particle_cast = "particles/base_attacks/ranged_tower_good_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function ancient_special_attack:PlayEffectsOnFinish(pos)
	EmitSoundOnLocationWithCaster( pos, "Hero_Ancient_Apparition.ChillingTouch.Target", self:GetCaster() )
	
	local particle_cast = "particles/base_attacks/ranged_tower_good_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 3, pos )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function ancient_special_attack:PlayEffectsOnCast( )
	EmitSoundOn( "Hero_Ancient_Apparition.ChillingTouch.Cast", self:GetCaster() )
end

function ancient_special_attack:PlayEffectsConsume( hTarget )
	 local particle_cast = "particles/econ/items/meepo/meepo_colossal_crystal_chorus/meepo_divining_rod_poof_end_explosion_ring.vpcf"

	 local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	 ParticleManager:SetParticleControl( effect_cast, 0, hTarget:GetOrigin() )
	 ParticleManager:SetParticleControl( effect_cast, 6, Vector(0, 245, 240) )
	 ParticleManager:ReleaseParticleIndex( effect_cast )
	 
end

if IsClient() then require("wrappers/abilities") end
Abilities.Initialize( 
	ancient_special_attack,
	{ activity = ACT_DOTA_TELEPORT_END, rate = 1.0 },
	{ movement_speed = 80, fixed_range = 1}
)