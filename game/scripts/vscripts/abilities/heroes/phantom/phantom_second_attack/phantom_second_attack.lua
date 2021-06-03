phantom_second_attack = class({})
phantom_second_attack_recast = class({})
LinkLuaModifier("modifier_phantom_second_attack_recast", "abilities/heroes/phantom/phantom_second_attack/modifier_phantom_second_attack_recast", LUA_MODIFIER_MOTION_NONE)

function phantom_second_attack:GetCastAnimationCustom()		return ACT_DOTA_ATTACK_EVENT end 
function phantom_second_attack:GetPlaybackRateOverride() 	return 0.8 end
function phantom_second_attack:GetCastPointSpeed() 			return 80 end

function phantom_second_attack:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	local point = ClampPosition(origin, CustomAbilitiesLegacy:GetCursorPosition(self), self:GetCastRange(Vector(0,0,0), nil), self:GetCastRange(Vector(0,0,0), nil))
	local damage = caster:GetAverageTrueAttackDamage(caster)
	local radius = self:GetSpecialValueFor("radius") + CustomEntitiesLegacy:GetMeeleExtraRadius(caster)
	
	local damage_multiplier_per_stack = self:GetSpecialValueFor("damage_multiplier_per_stack")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")

	local direction = (Vector(point.x - origin.x, point.y - origin.y, 0)):Normalized()
	local stacks = CustomEntitiesLegacy:SafeGetModifierStacks(caster, "modifier_phantom_strike_stack")
	local final_damage = damage * ((stacks + 1) * damage_multiplier_per_stack)

	local damage_table = {
		attacker = caster,
		damage = final_damage,
		damage_type = DAMAGE_TYPE_PHYSICAL,
	}

	local units = CustomEntitiesLegacy:MeeleAttack(caster, {
		vDirection = direction,
		vOrigin = origin, 
		fRadius = radius,
		bShakeOnHeroes = true,
		Callback = function(hTarget)
			damage_table.victim = hTarget
			ApplyDamage(damage_table)
			
			if stacks == 3 then
				local modifier = caster:FindModifierByName("modifier_phantom_mobility_charges")

				if modifier then
					if self:GetLevel() >= 2 then
						modifier:RefreshCharges()
					else
						modifier:AddCharge()
					end
				end

				EmitSoundOn("DOTA_Item.MagicWand.Activate", caster)
			end
			if CustomEntitiesLegacy:ProvidesMana(hTarget) then
				CustomEntitiesLegacy:GiveManaAndEnergyPercent(caster, mana_gain_pct, true)
			end
			self:PlayEffectsOnImpact(hTarget, stacks)
		end
	})

	self:PlayEffectsOnFinish(direction, radius)
	CustomEntitiesLegacy:SafeDestroyModifier(caster, "modifier_phantom_strike_stack")
	self:PlayEffectsOnCast()

	if #units > 0 then
		caster:AddNewModifier(caster, self, "modifier_phantom_second_attack_recast", { duration = 3.0 })
	end
end

function phantom_second_attack:PlayEffectsOnImpact(hTarget, stacks)
	EmitSoundOn("Hero_PhantomAssassin.Arcana_Layer", hTarget)
	
	local caster = self:GetCaster()
	local offset = 100
	local origin = caster:GetOrigin()
	local direction_normalized = (hTarget:GetOrigin() - origin):Normalized()
	local final_position = origin + Vector(direction_normalized.x * offset, direction_normalized.y * offset, 0)

	local particle_cast = ""

	if stacks == 3 then 
		particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_arcana_swoop.vpcf"
		EmitSoundOn("Hero_PhantomAssassin.Spatter", hTarget)
	else 
		particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_arcana_swoop_r.vpcf"
	end

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_POINT, caster)
    ParticleManager:SetParticleControl(effect_cast, 1, final_position)
    ParticleManager:SetParticleControlForward(effect_cast, 1, (origin - final_position):Normalized())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function phantom_second_attack:PlayEffectsOnCast()
	EmitSoundOn("Hero_PhantomAssassin.Attack", self:GetCaster())
end

function phantom_second_attack:PlayEffectsOnFinish(vDirection, nRadius)
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

function phantom_second_attack:OnUpgrade()
	CustomAbilitiesLegacy:LinkUpgrades(self, "phantom_second_attack_recast")
end

function phantom_second_attack_recast:OnUpgrade()
	CustomAbilitiesLegacy:LinkUpgrades(self, "phantom_second_attack")
end

function phantom_second_attack_recast:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	local radius = self:GetSpecialValueFor("radius") + CustomEntitiesLegacy:GetMeeleExtraRadius(caster)
	local point = ClampPosition(origin, CustomAbilitiesLegacy:GetCursorPosition(self), self:GetCastRange(Vector(0,0,0), nil), nil)
	
    EmitSoundOn("Hero_PhantomAssassin.Blur", caster)
	EFX("particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_start.vpcf", PATTACH_WORLDORIGIN, nil, {
        cp0 = origin,
        cp3 = origin,
        release = true,
    })
    FindClearSpaceForUnit(self:GetCaster(), point, true)
    EmitSoundOn("Hero_PhantomAssassin.Blur.Break", caster)
    EFX("particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_end.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent, {
        cp3 = caster:GetAbsOrigin(),
        release = true,
    })
	local damage_table = {
		attacker = caster,
		damage = caster:GetAverageTrueAttackDamage(caster) * 2,
		damage_type = DAMAGE_TYPE_PHYSICAL,
	}
	ApplyCallbackForUnitsInArea(caster, caster:GetAbsOrigin(), radius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(unit)
		damage_table.victim = unit
		ApplyDamage(damage_table)
		self:PlayEffectsOnImpact(unit)
		EmitSoundOn("Hero_PhantomAssassin.Spatter", unit)
		EmitSoundOn("Hero_PhantomAssassin.Attack", caster)
	end)

	CreateRadiusMarker(caster, point, radius, RADIUS_SCOPE_PUBLIC, 0.1)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK_EVENT, 1.5)
end

phantom_second_attack_recast.PlayEffectsOnImpact = phantom_second_attack.PlayEffectsOnImpact

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(phantom_second_attack)