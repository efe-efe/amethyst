pango_basic_attack = class({})
LinkLuaModifier("modifier_pango_basic_attack_stacks", "abilities/heroes/pango/pango_basic_attack/modifier_pango_basic_attack_stacks", LUA_MODIFIER_MOTION_NONE)

function pango_basic_attack:GetCastPoint()
	if IsServer() then
		return self:GetCaster():GetAttackAnimationPoint()
	end
end

function pango_basic_attack:GetCooldown(iLevel)
	if IsServer() then
        local attacks_per_second = self:GetCaster():GetAttacksPerSecond()
        local attack_speed = (1 / attacks_per_second)
		
		return self.BaseClass.GetCooldown(self, self:GetLevel()) + attack_speed
	end
end

function pango_basic_attack:GetCastAnimationCustom()
	if RandomInt(0, 3) == 0 then
		return ACT_DOTA_SPAWN
	else
		return ACT_DOTA_CAST_ABILITY_4_END
	end
end
function pango_basic_attack:GetPlaybackRateOverride() 	
	return 1.2 
end
function pango_basic_attack:GetCastPointSpeed() 		return self:GetSpecialValueFor('cast_point_speed_pct') end

function pango_basic_attack:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = ClampPosition(origin, CustomAbilitiesLegacy:GetCursorPosition(self), self:GetCastRange(Vector(0,0,0), nil), self:GetCastRange(Vector(0,0,0), nil))
	local attack_damage = caster:GetAttackDamage()

	self.radius = self:GetSpecialValueFor("radius")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()
	
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

			self:TryProc(hTarget)
			self:PlayEffectsOnImpact(hTarget)

			if not CustomEntitiesLegacy:IsObstacle(hTarget) then
				if CustomEntitiesLegacy:ProvidesMana(hTarget) then
					CustomEntitiesLegacy:GiveManaAndEnergyPercent(caster, mana_gain_pct, true)
				end

				caster:AddNewModifier(caster, self, "modifier_pango_basic_attack_stacks", {})
			end
	
			self:PlayEffectsOnImpact(hTarget)
		end
	})

	self:PlayEffectsOnMiss(point)
	MeeleEFX(caster, direction, self.radius, nil)
end

function pango_basic_attack:TryProc(hTarget)
	local caster = self:GetCaster()
	local stacks = CustomEntitiesLegacy:SafeGetModifierStacks(caster, "modifier_pango_basic_attack_stacks")
	if stacks == 4 then
		CustomEntitiesLegacy:SafeDestroyModifier(caster, "modifier_pango_basic_attack_stacks")
		hTarget:AddNewModifier(caster, self, "modifier_generic_silence", { duration = 1.0 })
		hTarget:AddNewModifier(caster, self, "modifier_generic_fading_slow", { 
			duration = 1.0,
			maxSlowPct = 100 
		})
		EmitSoundOn("Hero_Pangolier.LuckyShot.Proc", hTarget)
		
		local damage_table = {
			victim = hTarget,
			attacker = caster,
			damage = 8,
			damage_type = DAMAGE_TYPE_PHYSICAL,
		}
		ApplyDamage(damage_table)
	end
end

function pango_basic_attack:PlayEffectsOnImpact(hTarget)
	EFX('particles/juggernaut/juggernaut_basic_attack_impact.vpcf', PATTACH_ABSORIGIN, hTarget, {
		release = true
	})

	EmitSoundOn("Hero_Pangolier.Attack.Impact", hTarget)
end

function pango_basic_attack:PlayEffectsOnMiss(pos)
	EmitSoundOnLocationWithCaster(pos, "Hero_Pangolier.PreAttack", self:GetCaster())
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(pango_basic_attack)