mars_basic_attack = class({})
mars_ex_basic_attack = class({})

LinkLuaModifier("modifier_mars_basic_attack_stacks", "abilities/heroes/mars/mars_basic_attack/modifier_mars_basic_attack_stacks", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_mars_ex_basic_attack", "abilities/heroes/mars/mars_basic_attack/modifier_mars_ex_basic_attack", LUA_MODIFIER_MOTION_NONE)

function mars_basic_attack:GetCastPoint()
	if IsServer() then
		return self:GetCaster():GetAttackAnimationPoint()
	end
end

function mars_basic_attack:GetCooldown(iLevel)
	if IsServer() then
        local attacks_per_second = self:GetCaster():GetAttacksPerSecond()
        local attack_speed = (1 / attacks_per_second)
		
		return self.BaseClass.GetCooldown(self, self:GetLevel()) + attack_speed
	end
end

function mars_basic_attack:GetCastAnimationCustom()	    return ACT_DOTA_ATTACK end
function mars_basic_attack:GetPlaybackRateOverride() 	return 2.0 end
function mars_basic_attack:GetCastPointSpeed() 		    return self:GetSpecialValueFor('cast_point_speed_pct') end
function mars_basic_attack:GetAnimationTranslate() 		return "attack_close_range" end

function mars_basic_attack:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = ClampPosition(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), self:GetCastRange(Vector(0,0,0), nil))
    local attack_damage = caster:GetAttackDamage()
    
	local radius = self:GetSpecialValueFor("radius")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")
	local direction = (Vector(point.x-origin.x, point.y-origin.y, 0)):Normalized()

	local enemies = caster:FindUnitsInCone(
		direction, 
		0, 
		origin, 
		radius, 
		DOTA_UNIT_TARGET_TEAM_ENEMY, 
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
		DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_CLOSEST
	)

	for _,enemy in pairs(enemies) do 
		self:PlayEffectsOnImpact(enemy)

		local damage_table = {
			victim = enemy,
			attacker = caster,
			damage = attack_damage,
			damage_type = DAMAGE_TYPE_PHYSICAL,
			activate_counters = 1,
		}
		ApplyDamage(damage_table)

		if not enemy:IsObstacle() then
			if enemy:ProvidesMana() then
				caster:GiveManaAndEnergyPercent(mana_gain_pct, true)
			end

			caster:AddNewModifier(
				caster, -- player source
				self, -- ability source
				"modifier_mars_basic_attack_stacks", -- modifier name
				{} -- kv
			)
		end

		if caster.OnBasicAttackImpact then
			caster:OnBasicAttackImpact(enemy)
		end

		break
	end
    
    ExecuteOrderFromTable({ OrderType = DOTA_UNIT_ORDER_STOP, UnitIndex = caster:entindex() })
	self:PlayEffectsOnMiss(point)
	self:PlayEffectsOnFinish(point)
end

function mars_basic_attack:PlayEffectsOnFinish(pos)
	local caster = self:GetCaster()
	local offset = 40
	local origin = caster:GetOrigin()
	local direction = (pos - origin):Normalized()
	local final_position = origin + Vector(direction.x * offset, direction.y * offset, 0)

	local particle_cast = "particles/meele_swing_red/pa_arcana_attack_blinkb_red.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_POINT, caster)
	ParticleManager:SetParticleControl(effect_cast, 0, final_position)
	ParticleManager:SetParticleControlForward(effect_cast, 0, direction)	
	ParticleManager:ReleaseParticleIndex(effect_cast)

	particle_cast = "particles/econ/items/juggernaut/jugg_ti8_sword/juggernaut_ti8_sword_crit_golden.vpcf"
	effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_POINT, caster)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function mars_basic_attack:PlayEffectsOnImpact(hTarget)
	EmitSoundOn("Hero_Juggernaut.Attack", hTarget)
end

function mars_basic_attack:PlayEffectsOnMiss(pos)
	EmitSoundOnLocationWithCaster(pos, "Hero_Juggernaut.PreAttack", self:GetCaster())
end


function mars_ex_basic_attack:GetCastAnimationCustom()		return ACT_DOTA_TAUNT end
function mars_ex_basic_attack:GetPlaybackRateOverride()		return 1.0 end
function mars_ex_basic_attack:GetCastPointSpeed() 			return 10 end
function mars_ex_basic_attack:GetAnimationTranslate() 		return "ti10_taunt" end

function mars_ex_basic_attack:OnSpellStart()
	local caster = self:GetCaster()
	local heal = self:GetSpecialValueFor('heal')
	local duration = self:GetSpecialValueFor('duration')
	caster:Heal(heal, caster)
	caster:AddNewModifier(caster, self, 'modifier_mars_ex_basic_attack', { duration = duration })
	
	EmitSoundOn("DOTA_Item.Cheese.Activate", caster)
	EmitSoundOn("DOTA_Item.FaerieSpark.Activate", caster)
	EmitSoundOn("mars_mars_attack_20", caster)
	 
	EFX('particles/econ/taunts/bane/taunt_purple/bane_taunt_purple_food_end_left.vpcf', PATTACH_ABSORIGIN_FOLLOW, caster, {release = true})
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(mars_basic_attack)
Abilities.Castpoint(mars_ex_basic_attack)