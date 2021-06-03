dire_zombie_attack_meele = class({})

function dire_zombie_attack_meele:GetCastAnimationCustom()	return ACT_DOTA_ATTACK end
function dire_zombie_attack_meele:GetPlaybackRateOverride() return 1.0 end
function dire_zombie_attack_meele:GetCastPointSpeed()		return 0 end
function dire_zombie_attack_meele:GetCastPoint()
	if IsServer() then
		return self:GetCaster():GetAttackAnimationPoint()
	end
end

function dire_zombie_attack_meele:GetCooldown(iLevel)
	if IsServer() then
        local attacks_per_second = self:GetCaster():GetAttacksPerSecond()
        local attack_speed = (1 / attacks_per_second)
		
		return self.BaseClass.GetCooldown(self, self:GetLevel()) + attack_speed
	end
end

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
		iMaxTargets = -1,
		Callback = function(hTarget)
			CustomEntitiesLegacy:AttackWithBaseDamage(caster, {
				hTarget = hTarget,
				hAbility = self,
			})

			self:PlayEffectsOnImpact(hTarget)
		end
	})

	self:PlayEffectsOnMiss(point)
    MeeleEFX(caster, direction, self.radius, Vector(255, 0, 0))
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