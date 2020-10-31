nevermore_ultimate = class({})
LinkLuaModifier("modifier_nevermore_ultimate", "abilities/heroes/nevermore/nevermore_ultimate/modifier_nevermore_ultimate", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_ultimate_thinker", "abilities/heroes/nevermore/nevermore_ultimate/modifier_nevermore_ultimate_thinker", LUA_MODIFIER_MOTION_NONE)

function nevermore_ultimate:GetCastAnimationCustom()		return ACT_DOTA_CAST_ABILITY_6 end
function nevermore_ultimate:GetPlaybackRateOverride() 	    return 1.0 end
function nevermore_ultimate:GetCastPointSpeed() 			return 0 end

function nevermore_ultimate:OnAbilityPhaseStart()
	self.thinker = CreateModifierThinker(
		self:GetCaster(), --hCaster
		self, --hAbility
		"modifier_nevermore_ultimate_thinker", --modifierName
		{ duration = self:GetCastPoint() },
		self:GetCaster():GetAbsOrigin(), --vOrigin
		self:GetCaster():GetTeamNumber(), --nTeamNumber
		false --bPhantomBlocker
	)

	local particle_cast = "particles/units/heroes/hero_nevermore/nevermore_wings.vpcf"
	self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	EmitGlobalSound("Hero_Nevermore.ROS.Arcana.Cast")
	return true
end

function nevermore_ultimate:OnAbilityPhaseInterrupted()
	self.thinker:Destroy()
	
	ParticleManager:DestroyParticle(self.effect_cast, true)
	ParticleManager:ReleaseParticleIndex(self.effect_cast)
	StopGlobalSound("Hero_Nevermore.ROS.Arcana.Cast")
end

function nevermore_ultimate:OnSpellStart()
	local caster = self:GetCaster()
	local origin = self:GetCaster():GetAbsOrigin()
	local duration = self:GetSpecialValueFor("slow_duration")
	local damage = self:GetSpecialValueFor("damage_per_soul")
	local radius = self:GetSpecialValueFor("radius")
	local base_damage = self:GetSpecialValueFor("base_damage")
	local damage_per_soul = self:GetSpecialValueFor("damage_per_soul") 

	local damage_table = {
		attacker = caster,
		damage_type = DAMAGE_TYPE_PURE,
	}

	local modifier = self:GetCaster():FindModifierByName('modifier_nevermore_souls')
	local souls = modifier:GetStackCount()
	modifier:SetStackCount(0)

	local lines = 5 + (souls * 3)
	damage_table.damage = (base_damage + (souls * damage_per_soul))/2

	local initial_angle_deg = caster:GetAnglesAsVector().y
	local delta_angle = 360/lines

	for i = 0, lines - 1 do
		local facing_angle_deg = initial_angle_deg + delta_angle * i
		if facing_angle_deg>360 then facing_angle_deg = facing_angle_deg - 360 end
		local facing_angle = math.rad(facing_angle_deg)
		local facing_vector = Vector(math.cos(facing_angle), math.sin(facing_angle), 0):Normalized()
		local velocity = facing_vector * 1800

        local projectile = {
            EffectName = "particles/nevermore/nevermore_basic_attack.vpcf",
            vSpawnOrigin = caster:GetAbsOrigin() + Vector(0, 0, 80),
            fDistance = radius,
            Source = caster,
            vVelocity = velocity,
            UnitBehavior = PROJECTILES_NOTHING,
            TreeBehavior = PROJECTILES_NOTHING,
            WallBehavior = PROJECTILES_NOTHING,
            GroundBehavior = PROJECTILES_NOTHING,
			fGroundOffset = 80,
            UnitTest = function(_self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and not _self.Source:IsAlly(unit) end,
            OnFinish = function(_self, pos)
               self:PlayEffectsOnFinish(pos)
            end,
        }
        Projectiles:CreateProjectile(projectile)
	end

	ApplyCallbackForUnitsInArea(caster, origin, radius/2, DOTA_UNIT_TARGET_TEAM_ENEMY, function(enemy)
		damage_table.victim = enemy
		ApplyDamage(damage_table)
		EmitSoundOn("Hero_Spectre.Attack", enemy)
	end)

	ApplyCallbackForUnitsInArea(caster, origin, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, function(enemy)
		damage_table.victim = enemy
		ApplyDamage(damage_table)
		EmitSoundOn("Hero_Spectre.Attack", enemy)
	end)

	CreateRadiusMarker(caster, origin, radius/2, RADIUS_SCOPE_PUBLIC, 0.1)
	CreateRadiusMarker(caster, origin, radius, RADIUS_SCOPE_PUBLIC, 0.1)
	ScreenShake(origin, 100, 300, 0.45, 1000, 0, true)

	ParticleManager:ReleaseParticleIndex(self.effect_cast)
	self:PlayEffectsLines(lines)
end

function nevermore_ultimate:PlayEffectsLines(lines)
	local caster = self:GetCaster()
	EmitSoundOn("Hero_Nevermore.ROS.Arcana", caster)

	local particle_cast = "particles/units/heroes/hero_nevermore/nevermore_requiemofsouls.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(lines, 0, 0))	-- Lines
	ParticleManager:SetParticleControlForward(effect_cast, 2, caster:GetForwardVector())		-- initial direction
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function nevermore_ultimate:PlayEffectsOnFinish(pos)
	local particle_cast = "particles/econ/items/shadow_fiend/sf_desolation/sf_base_attack_desolation_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, self:GetCaster())
	ParticleManager:SetParticleControl(effect_cast, 3, pos)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(nevermore_ultimate)