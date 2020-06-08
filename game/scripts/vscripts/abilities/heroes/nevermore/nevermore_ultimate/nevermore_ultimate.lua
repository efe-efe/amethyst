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
		{ duration = self:GetCastPoint() + 0.2 },
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

	local lines = self:GetSpecialValueFor("base_lines")
	local modifier = caster:FindModifierByNameAndCaster("modifier_nevermore_souls", caster)
	if modifier ~= nil then
		lines = lines + modifier:GetStackCount()
		modifier:Destroy()
	end

	local width_start = self:GetSpecialValueFor("line_width_start")
	local width_end = self:GetSpecialValueFor("line_width_end")
	local line_speed = self:GetSpecialValueFor("line_speed")
	
	local initial_angle_deg = caster:GetAnglesAsVector().y
	local delta_angle = 360/lines

	for i = 0, lines - 1 do
		-- Determine velocity
		local facing_angle_deg = initial_angle_deg + delta_angle * i
		if facing_angle_deg>360 then facing_angle_deg = facing_angle_deg - 360 end
		local facing_angle = math.rad(facing_angle_deg)
		local facing_vector = Vector(math.cos(facing_angle), math.sin(facing_angle), 0):Normalized()
		local velocity = facing_vector * line_speed

        local projectile = {
            EffectName = "particles/mod_units/heroes/hero_nevermore/nevermore_base_attack.vpcf",
            vSpawnOrigin = caster:GetAbsOrigin() + Vector(0, 0, 80),
            fDistance = radius,
            fStartRadius = width_start,
            fEndRadius = width_end,
            Source = caster,
            vVelocity = velocity,
            UnitBehavior = PROJECTILES_NOTHING,
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
                    damage_type = DAMAGE_TYPE_PURE,
                    ability = self,
                }
                ApplyDamage(damage_table)
				
                unit:AddNewModifier(
                    _self.Source,
                    self,
                    "modifier_nevermore_ultimate",
                    { duration = duration }
               )

                self:PlayEffectsOnFinish(_self.current_position)
            end,
            OnFinish = function(_self, pos)
               self:PlayEffectsOnFinish(pos)
            end,
        }
        Projectiles:CreateProjectile(projectile)
    end
    
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
	local particle_cast = "particles/mod_units/heroes/hero_nevermore/sf_base_attack_desolation_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, self:GetCaster())
	ParticleManager:SetParticleControl(effect_cast, 3, pos)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(nevermore_ultimate)