centaur_axe_attack = class({})

function centaur_axe_attack:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_2 end 
function centaur_axe_attack:GetPlaybackRateOverride() 		return 1.0 end
function centaur_axe_attack:GetCastPointSpeed() 			return 0 end

function centaur_axe_attack:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	local point = self:GetCursorPosition()
	local damage = 20
	local radius = self:GetSpecialValueFor("radius")
	
	local direction = (Vector(point.x - origin.x, point.y - origin.y, 0)):Normalized()

	local damage_table = {
		attacker = caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_PHYSICAL,
	}

	CustomEntities:MeeleAttack(caster, {
		vDirection = direction,
		vOrigin = origin, 
		fRadius = radius,
		bShakeOnHeroes = true,
		Callback = function(hTarget)
			damage_table.victim = hTarget
			ApplyDamage(damage_table)
			
			if stacks == 3 then
				local modifier = caster:FindModifierByName("modifier_phantom_mobility_charges")

				if self:GetLevel() >= 2 then
					modifier:RefreshCharges()
				else
					modifier:AddCharge()
				end

				EmitSoundOn("DOTA_Item.MagicWand.Activate", caster)
			end
			self:PlayEffectsOnImpact(hTarget, stacks)
		end
	})

	self:PlayEffectsOnFinish(direction, radius/2)
	self:PlayEffectsOnFinish(direction, radius)
	CustomEntities:SafeDestroyModifier(caster, "modifier_phantom_strike_stack")
	self:PlayEffectsOnCast()
end

function centaur_axe_attack:PlayEffectsOnImpact(hTarget, stacks)
	EmitSoundOn("Hero_PhantomAssassin.Arcana_Layer", hTarget)
	
	local caster = self:GetCaster()
	local offset = 100
	local origin = caster:GetOrigin()
	local direction_normalized = (hTarget:GetOrigin() - origin):Normalized()
	local final_position = origin + Vector(direction_normalized.x * offset, direction_normalized.y * offset, 0)

	local particle_cast = "particles/econ/items/centaur/centaur_ti9/centaur_double_edge_ti9.vpcf"
	EmitSoundOn("Hero_PhantomAssassin.Spatter", hTarget)

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget)
    ParticleManager:SetParticleControl(effect_cast, 2, hTarget:GetAbsOrigin())
    ParticleManager:SetParticleControl(effect_cast, 3, hTarget:GetAbsOrigin())
    ParticleManager:SetParticleControlForward(effect_cast, 1, (origin - final_position):Normalized())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function centaur_axe_attack:PlayEffectsOnCast()
	EmitSoundOn("Hero_Centaur.DoubleEdge", self:GetCaster())
end

function centaur_axe_attack:PlayEffectsOnFinish(vDirection, nRadius)
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	
	local efx = EFX('particles/juggernaut/juggernaut_second_attack_parent.vpcf', PATTACH_WORLDORIGIN, nil, {
		cp0 = origin,
		cp0f = vDirection,
		cp3 = Vector(nRadius, 0, 0),
	})
	ParticleManager:SetParticleControl(efx, 60, Vector(255, 0, 255))
	ParticleManager:SetParticleControl(efx, 61, Vector(1, 0, 0))
	ParticleManager:ReleaseParticleIndex(efx)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(centaur_axe_attack)