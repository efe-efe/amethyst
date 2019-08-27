nevermore_second_attack = class({})
LinkLuaModifier( "modifier_nevermore_second_attack_cooldown", "abilities/heroes/nevermore/nevermore_second_attack/modifier_nevermore_second_attack_cooldown", LUA_MODIFIER_MOTION_NONE )

function nevermore_second_attack:GetAlternateVersion()
    return self:GetCaster():FindAbilityByName("nevermore_ex_second_attack")
end

--------------------------------------------------------------------------------
-- Ability Start
function nevermore_second_attack:OnSpellStart()
	-- Initialize variables
	local caster = self:GetCaster()
	local cast_point = self:GetCastPoint()
	local radius = self:GetSpecialValueFor("radius")
	
	-- Animation and pseudo cast point
	StartAnimation(caster, {duration=1.0, activity=ACT_DOTA_RAZE_2, rate=0.8})
	caster:AddNewModifier(caster, self , "modifier_generic_pseudo_cast_point", { 
		duration = cast_point,
		movement_speed = 10,
		radius = radius
	})
end

--------------------------------------------------------------------------------
-- Ability Start
function nevermore_second_attack:OnEndPseudoCastPoint( pos )
	-- unit identifier
	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor("radius")
	local damage = self:GetAbilityDamage()
	local damage_per_stack = self:GetSpecialValueFor("damage")
	local stack_duration = self:GetSpecialValueFor("stack_duration")
	local mana_gain = self:GetSpecialValueFor("mana_gain")/100

	-- get affected enemies
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		pos,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	-- for each affected enemies
	for _,enemy in pairs(enemies) do
		-- Get Stack
		local modifier = enemy:FindModifierByNameAndCaster("modifier_nevermore_second_attack", caster)
		local stacks = 0
		if modifier~=nil then
			stacks = modifier:GetStackCount()
		end

		-- Apply damage
		local damageTable = {
			victim = enemy,
			attacker = caster,
			damage = damage + stacks * damage_per_stack,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = this,
		}
		ApplyDamage( damageTable )
	end

	if #enemies > 0 then
		-- Give Mana
				
		local mana_gain_final = caster:GetMaxMana() * mana_gain
		caster:GiveMana(mana_gain_final)   

		-- Refresh if posible
		local cooldownModifier = caster:AddNewModifier(
			caster,
			self,
			"modifier_nevermore_second_attack_cooldown",
			{ duration = stack_duration }
		)
		local cooldownStacks = cooldownModifier:GetStackCount()
		
		if cooldownStacks < 3 then
			self:EndCooldown()
		else
			SafeDestroyModifier("modifier_nevermore_second_attack_cooldown", caster, caster)
		end
 
	else
		SafeDestroyModifier("modifier_nevermore_second_attack_cooldown", caster, caster)
	end

	-- Effects
	self:PlayEffects( pos, radius )
    
    -- Put CD on the alternate of the ability
	local alternate_version = caster:FindAbilityByName("nevermore_ex_second_attack")
	alternate_version:StartCooldown(self:GetCooldown(0))
end

function nevermore_second_attack:PlayEffects( position, radius )
	local caster = self:GetCaster()
	
	-- get resources
	local particle_cast = "particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf"
	local sound_cast = "Hero_Nevermore.Shadowraze"

	-- create particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, position )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, 1, 1 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	
	-- create sound
	EmitSoundOnLocationWithCaster( position, sound_cast, caster )
end
