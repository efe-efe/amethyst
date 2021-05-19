item_diffusal_custom = class({})
LinkLuaModifier("modifier_item_diffusal_custom", "items/item_diffusal_custom/modifier_item_diffusal_custom", LUA_MODIFIER_MOTION_HORIZONTAL)

function item_diffusal_custom:OnAbilityPhaseStart()
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_casting", { 
		duration = self:GetCastPoint(), 
		movement_speed = 30,
	})
	self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 1.0)
    return true
end

function item_diffusal_custom:OnAbilityPhaseInterrupted()
	self:GetCaster():FadeGesture(ACT_DOTA_ATTACK)
	self:GetCaster():RemoveModifierByName("modifier_casting")
end

function item_diffusal_custom:OnSpellStart()
	self:GetCaster():FadeGesture(ACT_DOTA_ATTACK)
	local caster = self:GetCaster()
	local origin = caster:GetOrigin()
	local point = ClampPosition(origin, CustomAbilitiesLegacy:GetCursorPosition(self), self:GetCastRange(Vector(0,0,0), nil), self:GetCastRange(Vector(0,0,0), nil))
	local ability_damage = self:GetSpecialValueFor("ability_damage")
	local duration = self:GetSpecialValueFor("duration")
	local radius = self:GetSpecialValueFor("radius")
    
	local direction = Direction2D(origin, point)

	local enemies = CustomEntitiesLegacy:FindUnitsInCone(
		caster,
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
		enemy:AddNewModifier(caster, self , "modifier_item_diffusal_custom", { duration = duration })

		local damage_table = {
			victim = enemy,
			attacker = caster,
			damage = ability_damage,
			damage_type = DAMAGE_TYPE_PHYSICAL,
			activate_counters = 1,
		}
		ApplyDamage(damage_table)
		
		self:PlayEffectsOnImpact(enemy)
		break
	end
	
	self:PlayEffectsOnMiss(point)
	self:PlayEffectsOnFinish(point)
	self:PlayEffectsOnCast()
end

function item_diffusal_custom:PlayEffectsOnCast()
	EmitSoundOn("DOTA_Item.DiffusalBlade.Activate", self:GetCaster())
end

function item_diffusal_custom:PlayEffectsOnFinish(pos)
	local caster = self:GetCaster()
	local offset = 40
	local origin = caster:GetOrigin()
	local direction = (pos - origin):Normalized()
	local final_position = origin + Vector(direction.x * offset, direction.y * offset, 0)

	local particle_cast = "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_attack_blinkb.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_POINT, caster)
	ParticleManager:SetParticleControl(effect_cast, 0, final_position)
	ParticleManager:SetParticleControlForward(effect_cast, 0, direction)	
	ParticleManager:ReleaseParticleIndex(effect_cast)
    

    particle_cast = "particles/units/heroes/hero_spirit_breaker/spirit_breaker_greater_bash.vpcf"
	effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_POINT, caster)
	ParticleManager:SetParticleControl(effect_cast, 0, final_position)
	ParticleManager:SetParticleControlForward(effect_cast, 0, direction)	
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function item_diffusal_custom:PlayEffectsOnImpact(hTarget)
	local particle_cast = "particles/econ/items/arc_warden/arc_warden_ti9_immortal/arc_warden_ti9_wraith_cast.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, hTarget)
	ParticleManager:SetParticleControl(effect_cast, 1, hTarget:GetOrigin())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function item_diffusal_custom:PlayEffectsOnMiss(pos)
	EmitSoundOnLocationWithCaster(pos, "Hero_Juggernaut.PreAttack", self:GetCaster())
end

--[[
if IsClient() then require("wrappers/abilities") end
Abilities.Initialize(
	item_diffusal_custom,
	{ activity = ACT_DOTA_ATTACK, rate = 1.0 },
	{ movement_speed = 30 }
)]]