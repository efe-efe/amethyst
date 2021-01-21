spectre_special_attack = class({})
spectre_ex_special_attack = class({})
spectre_ex_special_attack_recast = class({})
LinkLuaModifier("modifier_spectre_special_attack_debuff", "abilities/heroes/spectre/spectre_special_attack/modifier_spectre_special_attack_debuff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spectre_special_attack_thinker", "abilities/heroes/spectre/spectre_special_attack/modifier_spectre_special_attack_thinker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spectre_special_attack_buff", "abilities/heroes/spectre/spectre_special_attack/modifier_spectre_special_attack_buff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spectre_ex_special_attack_thinker", "abilities/heroes/spectre/spectre_special_attack/modifier_spectre_ex_special_attack_thinker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spectre_ex_special_attack_recast", "abilities/heroes/spectre/spectre_special_attack/modifier_spectre_ex_special_attack_recast", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spectre_ex_special_attack_banish", "abilities/heroes/spectre/spectre_special_attack/modifier_spectre_ex_special_attack_banish", LUA_MODIFIER_MOTION_NONE)

function spectre_special_attack:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_1 end
function spectre_special_attack:GetPlaybackRateOverride()		return 0.7 end
function spectre_special_attack:GetCastPointSpeed() 			return 20 end

function spectre_special_attack:OnSpellStart()
	local caster = self:GetCaster()
	local damage = self:GetSpecialValueFor("ability_damage")
	local origin = caster:GetOrigin()
	local point = ClampPosition(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)

	local projectile_name = "particles/spectre/spectre_special_attack.vpcf" 
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local hitbox = self:GetSpecialValueFor("hitbox")

	local path_duration = self:GetSpecialValueFor("path_duration")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local debuff_duration = self:GetSpecialValueFor("debuff_duration")

	local projectile_direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()

	local projectile = {
		vSpawnOrigin = origin,
		fDistance = self:GetSpecialValueFor("projectile_distance") ~= 0 and self:GetSpecialValueFor("projectile_distance") or self:GetCastRange(Vector(0,0,0), nil),
		fStartRadius = hitbox,
		Source = caster,
		vVelocity = projectile_direction * projectile_speed,
		UnitBehavior = PROJECTILES_NOTHING,
		TreeBehavior = PROJECTILES_NOTHING,
		WallBehavior = PROJECTILES_NOTHING,
		GroundBehavior = PROJECTILES_NOTHING,
		fGroundOffset = 0,
		bGroundLock = true,
		bIsSlowable = false,
		UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not CustomEntities:Allies(_self.Source, unit) end,
		OnUnitHit = function(_self, unit)
			local damage = {
				victim = unit,
				attacker = caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}

			ApplyDamage(damage)
			
			unit:AddNewModifier(
				caster,
				self,
				"modifier_spectre_special_attack_debuff",
				{ duration = debuff_duration }
			)

			if _self.Source == caster then
				if CustomEntities:ProvidesMana(unit) then
					CustomEntities:GiveManaAndEnergyPercent(caster, mana_gain_pct, true)
				end
			end

			self:PlayEffectsOnImpact(unit)
		end,
		OnFinish = function(_self, pos)
		end,
		OnThinkBegin = function(_self, pos)
			CreateModifierThinker(
				caster, -- player source
				self, -- ability source
				"modifier_spectre_special_attack_thinker", -- modifier name
				{ duration = path_duration }, -- kv
				pos,
				caster:GetTeamNumber(),
				false --bPhantomBlocker
			)
		end
	}

	local info = { 
		Source = caster, 
		Ability = self, 
		vSpawnOrigin = Vector(origin.x, origin.y, origin.z + 128), 
			
		bDeleteOnHit = false, 
			
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY, 
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE, 
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
			
		EffectName = projectile_name, 
		fDistance = projectile.fDistance, 
		fStartRadius = hitbox, 
		fEndRadius = hitbox, 
		vVelocity = projectile.vVelocity, 
	
		bHasFrontalCone = false, 
		bReplaceExisting = false, 
		fExpireTime = GameRules:GetGameTime() + 8.0, 
			
		bProvidesVision = true, 
		iVisionTeamNumber = caster:GetTeamNumber(),
		iVisionRadius = hitbox,
	} 
	ProjectilesManagerInstance:CreateProjectile(projectile)
	ProjectileManager:CreateLinearProjectile(info) 
	self:PlayEffectsOnCast()
	LinkAbilityCooldowns(caster, 'spectre_ex_special_attack')
end

function spectre_special_attack:PlayEffectsOnCast()
	EmitSoundOn("Hero_Spectre.DaggerCast", self:GetCaster())
end

function spectre_special_attack:PlayEffectsOnImpact(hTarget)
	EmitSoundOn("Hero_Spectre.DaggerImpact", hTarget)

	local particle_cast = "particles/econ/items/spectre/spectre_transversant_soul/spectre_ti7_crimson_spectral_dagger_path_owner_impact.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, hTarget)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end


spectre_ex_special_attack.PlayEffectsOnCast = spectre_special_attack.PlayEffectsOnCast
spectre_ex_special_attack.PlayEffectsOnFinish = spectre_special_attack.PlayEffectsOnFinish

function spectre_ex_special_attack:GetCastAnimationCustom()		return ACT_DOTA_FLAIL end
function spectre_ex_special_attack:GetPlaybackRateOverride()		return 1.0 end
function spectre_ex_special_attack:GetCastPointSpeed() 			return 0 end

function spectre_ex_special_attack:OnSpellStart()
	local caster = self:GetCaster()
    local origin = caster:GetOrigin()
	local point = ClampPosition(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)
		
	EmitSoundOn("Hero_Spectre.Haunt", caster)
	EFX('particles/spectre/spectre_illusion_warp.vpcf', PATTACH_CUSTOMORIGIN, caster, {
		cp0 = {
			ent = caster,
			point = 'attach_hitloc'
		},
		cp1 = point + Vector(0, 0, 128),
		cp2 = {
			ent = caster,
			point = 'attach_hitloc'
		},
        release = true,
	})

	CreateModifierThinker(caster, self, 'modifier_spectre_ex_special_attack_thinker', {}, point, caster:GetTeam(), false)
	LinkAbilityCooldowns(caster, 'spectre_special_attack')
end

function spectre_ex_special_attack_recast:OnSpellStart()
	local caster = self:GetCaster()
    local origin = caster:GetOrigin()
	local point = ClampPosition(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), nil)

	for _,hTarget in ipairs(self.targets) do
		hTarget:RemoveModifierByName('modifier_spectre_ex_special_attack_banish')
		FindClearSpaceForUnit(hTarget, point, true)
	end

	EFX('particles/spectre/spectre_illusion_warp.vpcf', PATTACH_CUSTOMORIGIN, caster, {
		cp0 = {
			ent = caster,
			point = 'attach_hitloc'
		},
		cp1 = point + Vector(0, 0, 128),
		cp2 = {
			ent = caster,
			point = 'attach_hitloc'
		},
        release = true,
	})

	EmitSoundOnLocationWithCaster(point, "Hero_Spectre.Reality", caster)
end

function spectre_ex_special_attack_recast:AddTarget(hTarget)
	if not self.targets then
		self.targets = {}
	end
	table.insert(self.targets, hTarget)
end

function spectre_ex_special_attack_recast:ClearTargets(hTarget)
	self.targets = nil
end


function spectre_ex_special_attack_recast:OnUpgrade()
	local related = self:GetCaster():FindAbilityByName('spectre_ex_special_attack')
	
	if self:GetLevel() > related:GetLevel() then
		related:UpgradeAbility(true)
	end
end

function spectre_ex_special_attack:OnUpgrade()
	local related = self:GetCaster():FindAbilityByName('spectre_ex_special_attack_recast')
	
	if self:GetLevel() > related:GetLevel() then
		related:UpgradeAbility(true)
	end
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(spectre_special_attack)
Abilities.Castpoint(spectre_ex_special_attack)