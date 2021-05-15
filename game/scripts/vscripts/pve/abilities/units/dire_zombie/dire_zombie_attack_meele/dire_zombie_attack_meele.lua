dire_zombie_attack_meele = class({})

function dire_zombie_attack_meele:GetCastAnimationCustom()	return ACT_DOTA_ATTACK end
function dire_zombie_attack_meele:GetPlaybackRateOverride() return 1.0 end

function dire_zombie_attack_meele:OnSpellStart()
    local caster = self:GetCaster()
    local origin = caster:GetOrigin()
    local point = ClampPosition(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), self:GetCastRange(Vector(0,0,0), nil))
    local projectile_direction = Direction2D(origin, point)

	self.radius = self:GetSpecialValueFor("radius")
	local direction = Direction2D(origin, point)
	
	CustomEntitiesLegacy:MeeleAttack(caster, {
		vDirection = direction,
		vOrigin = origin, 
		fRadius = self.radius,
		bIsBasicAttack = true,
		iMaxTargets = 1,
		Callback = function(hTarget)
			CustomEntitiesLegacy:AttackWithBaseDamage(caster, {
				hTarget = hTarget,
				hAbility = self,
			})

			self:PlayEffectsOnImpact(hTarget)
		end
	})

	self:PlayEffectsOnMiss(point)
    self:PlayEffectsOnFinish(direction, Vector(255, 0, 0))
end

function dire_zombie_attack_meele:PlayEffectsOnFinish(vDirection, vColor)
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()

	local efx = EFX('particles/juggernaut/juggernaut_basic_attack_parent.vpcf', PATTACH_WORLDORIGIN, nil, {
		cp0 = origin,
		cp0f = vDirection,
		cp3 = Vector(self.radius, 0, 0),
	})

	if vColor then
		ParticleManager:SetParticleControl(efx, 60, vColor)
		ParticleManager:SetParticleControl(efx, 61, Vector(1, 0, 0))
	end

	ParticleManager:ReleaseParticleIndex(efx)

	EFX('particles/juggernaut/juggernaut_basic_attack_dust.vpcf', PATTACH_ABSORIGIN_FOLLOW, self:GetCaster(), {
		release = true,
	})
end

function dire_zombie_attack_meele:PlayEffectsOnImpact(hTarget)
	EFX('particles/juggernaut/juggernaut_basic_attack_impact.vpcf', PATTACH_ABSORIGIN, hTarget, {
		release = true
	})

	EmitSoundOn("Hero_Juggernaut.Attack", hTarget)
end

function dire_zombie_attack_meele:PlayEffectsOnMiss(pos)
	EmitSoundOnLocationWithCaster(pos, "Hero_Juggernaut.PreAttack", self:GetCaster())
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(dire_zombie_attack_meele)