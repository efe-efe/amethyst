phantom_second_attack = class({})

function phantom_second_attack:GetCastAnimationCustom()		return ACT_DOTA_ATTACK_EVENT end 
function phantom_second_attack:GetPlaybackRateOverride() 	return 0.8 end
function phantom_second_attack:GetCastPointSpeed() 			return 80 end

function phantom_second_attack:OnSpellStart()
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	local point = ClampPosition(origin, self:GetCursorPosition(), self:GetCastRange(Vector(0,0,0), nil), self:GetCastRange(Vector(0,0,0), nil))
	local damage = self:GetSpecialValueFor("ability_damage")
	local radius = self:GetSpecialValueFor("radius")
	
	local damage_per_stack = self:GetSpecialValueFor("damage_per_stack")
	local mana_gain_pct = self:GetSpecialValueFor("mana_gain_pct")

	local direction = (Vector(point.x - origin.x, point.y - origin.y, 0)):Normalized()
	local stacks = SafeGetModifierStacks("modifier_phantom_strike_stack", caster, caster)

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
		local final_damage = damage + (stacks * damage_per_stack)

		local damage_table = {
			victim = enemy,
			attacker = caster,
			damage = final_damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
		}

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

		caster:GiveManaPercent(mana_gain_pct, enemy)
		self:PlayEffectsOnImpact(enemy, stacks)

		break
	end

	if #enemies > 0 then
		ScreenShake(point, 100, 300, 0.7, 1000, 0, true)
	end
	
	self:PlayEffectsOnFinish(point)
	SafeDestroyModifier("modifier_phantom_strike_stack", caster, caster)
	self:PlayEffectsOnCast()
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

function phantom_second_attack:PlayEffectsOnFinish(pos)
	local caster = self:GetCaster()

	local offset = 50
	local origin = caster:GetOrigin()
	local direction = (pos - origin):Normalized()
	local final_position = origin + Vector(direction.x * offset, direction.y * offset, 0)

	local particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_arcana_swoop_c.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_POINT, caster)
	ParticleManager:SetParticleControl(effect_cast, 1, final_position)
	ParticleManager:SetParticleControlForward(effect_cast, 1, (origin - final_position):Normalized())
	ParticleManager:ReleaseParticleIndex(effect_cast)
	
	particle_cast = "particles/phantom/phantom_second_attack.vpcf"
	effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_POINT, caster)
	ParticleManager:SetParticleControl(effect_cast, 0, final_position)
	ParticleManager:SetParticleControlForward(effect_cast, 0, direction)	
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

if IsClient() then require("wrappers/abilities") end
Abilities.Castpoint(phantom_second_attack)