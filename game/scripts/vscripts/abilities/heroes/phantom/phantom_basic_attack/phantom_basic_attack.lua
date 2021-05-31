phantom_basic_attack = class({})
phantom_ex_basic_attack = class({})
LinkLuaModifier("modifier_phantom_strike_stack", "abilities/heroes/phantom/phantom_shared_modifiers/modifier_phantom_strike_stack", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phantom_ex_basic_attack", "abilities/heroes/phantom/phantom_basic_attack/modifier_phantom_ex_basic_attack", LUA_MODIFIER_MOTION_NONE)

function phantom_basic_attack:GetCastPoint()
	if IsServer() then
		return self:GetCaster():GetAttackAnimationPoint()
	end
end

function phantom_basic_attack:GetCooldown(iLevel)
	if IsServer() then
        local attacks_per_second = self:GetCaster():GetAttacksPerSecond()
        local attack_speed = (1 / attacks_per_second)
		
		return self.BaseClass.GetCooldown(self, self:GetLevel()) + attack_speed
	end
end

function phantom_basic_attack:GetCastAnimationCustom()		return ACT_DOTA_SPAWN end
function phantom_basic_attack:GetPlaybackRateOverride() 	return 1.7 end
function phantom_basic_attack:GetCastPointSpeed() 			return self:GetSpecialValueFor('cast_point_speed_pct') end
function phantom_basic_attack:GetFadeGestureOnCast()		return false end

function phantom_basic_attack:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = ClampPosition(origin, CustomAbilitiesLegacy:GetCursorPosition(self), self:GetCastRange(Vector(0,0,0), nil), self:GetCastRange(Vector(0,0,0), nil))
	local radius = self:GetSpecialValueFor("radius") + CustomEntitiesLegacy:GetMeeleExtraRadius(caster)
	local cooldown_reduction = self:GetSpecialValueFor("cooldown_reduction")
    local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")

	local direction = (Vector(point.x - origin.x, point.y - origin.y, 0)):Normalized()

	CustomEntitiesLegacy:MeeleAttack(caster, {
		vDirection = direction,
		vOrigin = origin, 
		fRadius = radius,
		bIsBasicAttack = true,
		iMaxTargets = 1,
		Callback = function(hTarget)
			CustomEntitiesLegacy:AttackWithBaseDamage(caster, {
				hTarget = hTarget,
				hAbility = self,
			})

			if not CustomEntitiesLegacy:IsObstacle(hTarget) then
				if CustomEntitiesLegacy:ProvidesMana(hTarget) then
					CustomEntitiesLegacy:GiveManaAndEnergyPercent(caster, mana_gain_pct, true)
				end

				caster:AddNewModifier(caster, self, "modifier_phantom_strike_stack", {})
				self:ReduceCooldown(caster, 'phantom_second_attack', cooldown_reduction)
			end
	
			self:PlayEffectsOnImpact(hTarget)
		end
	})

	self:PlayEffectsOnFinish(direction, radius)
	self:PlayEffectsOnCast()
end

function phantom_basic_attack:ReduceCooldown(hCaster, sAbilityName, fCooldownReduction)
	local hAbility = hCaster:FindAbilityByName(sAbilityName)
	local fAbilityCooldown = hAbility:GetCooldownTimeRemaining()
	local fNewCooldown = Clamp((fAbilityCooldown - fCooldownReduction), nil, 0)

	hAbility:EndCooldown()
	hAbility:StartCooldown(fNewCooldown)
end

function phantom_basic_attack:PlayEffectsOnFinish(vDirection, nRadius)
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	
	local efx = EFX('particles/juggernaut/juggernaut_basic_attack_parent.vpcf', PATTACH_WORLDORIGIN, nil, {
		cp0 = origin,
		cp0f = vDirection,
		cp3 = Vector(nRadius, 0, 0),
	})
	ParticleManager:SetParticleControl(efx, 60, Vector(43, 100, 125))
	ParticleManager:SetParticleControl(efx, 61, Vector(1, 0, 0))
	ParticleManager:ReleaseParticleIndex(efx)
end

function phantom_basic_attack:PlayEffectsOnImpact(hTarget)
	EFX('particles/phantom/phantom_basic_attack.vpcf', PATTACH_ABSORIGIN, hTarget, {
		release = true
	})

	EmitSoundOn("Hero_PhantomAssassin.Attack", hTarget)
end

function phantom_basic_attack:PlayEffectsOnCast()
	EmitSoundOn("Hero_PhantomAssassin.PreAttack", self:GetCaster())
end

function phantom_ex_basic_attack:OnSpellStart()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")

    caster:AddNewModifier(
        caster,
        self,
        "modifier_phantom_ex_basic_attack",
        { duration = duration }
   )

    self:PlayEffects()
end

function phantom_ex_basic_attack:PlayEffects()
    EmitSoundOn("Hero_PhantomAssassin.Blur", self:GetCaster())

    local particle_cast = "particles/econ/events/ti5/blink_dagger_end_sparkles_end_lvl2_ti5.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_POINT, self:GetCaster())
	ParticleManager:SetParticleControl(effect_cast, 3, self:GetCaster():GetOrigin())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function phantom_ex_basic_attack:OnUpgrade()
	CustomAbilitiesLegacy:LinkUpgrades(self, "phantom_basic_attack_related")
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(phantom_basic_attack)